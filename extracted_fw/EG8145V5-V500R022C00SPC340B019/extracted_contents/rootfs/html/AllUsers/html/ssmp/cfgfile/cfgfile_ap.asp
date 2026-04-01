<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" type="text/javascript">
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var UnicomFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>";
var NormalUpdownCfg = "<%HW_WEB_GetFeatureSupport(FT_NORMAL_UPDOWNLOADCFG);%>";
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var APwebGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>';
var isWebLoadConfigfile = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOAD_CONFIGFILE);%>";
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var cfgExportType = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_ConfigExportPolicy.ExportType);%>';
var clearExportType = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_ConfigExportPolicy.ClearExport);%>';
var compatibleForWeb = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_ConfigExportPolicy.CompatibleForWeb);%>';
var showCfgKeyOption = 'off';

if (compatibleForWeb === '3') {
    cfgExportType = Number(cfgExportType);
    if ((cfgExportType & 2) != 2) {
        isWebLoadConfigfile = '0';
    }
    if (clearExportType === '1') {
        showCfgKeyOption = 'on';
    }
}

function Check_SWM_Status()
{
    var xmlHttp = null;

    if(window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    } else if(window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlHttp.open("GET", "../../get_swm_status.asp", false);
    xmlHttp.send(null);

    var swm_status = xmlHttp.responseText;
    if (swm_status.substr(1,1) == "0") {
        return true;
    } else {
        return false;
    }
}

function setAllDisable()
{
	setDisable('f_file',1);
	setDisable('browse',1);
	setDisable('btnBrowse',1);
	setDisable('btnSubmit',1);
}
function GetLanguageDesc(Name)
{
	return CfgfileLgeDes[Name];
}

function LoadFrame() {
	if (curUserType != sysUserType) {
		if ((['PCCW4MAC', 'PCCWSMART', 'PCCW2'].indexOf(CfgMode.toUpperCase()) >= 0)
            || 1 == NormalUpdownCfg) {
			setDisplay('saveConfig',     1);
			setDisplay('downloadConfig', isWebLoadConfigfile);
			setDisplay('uploadConfig', isWebLoadConfigfile);
		}
		else
		{
			setDisplay('saveConfig',     1);
		setDisplay('downloadConfig', 0);
		setDisplay('uploadConfig',   0);
		}
	}
	else
	{
		setDisplay('downloadConfig', isWebLoadConfigfile);
		setDisplay('uploadConfig', isWebLoadConfigfile);
		if (1 == UnicomFlag)
		{
			setDisplay('saveConfig', 0);
		}
		else
		{
			setDisplay('saveConfig', 1);
		}
	}
	
	setTimeout('delayTime(top.SaveDataFlag)',30);

    if ((CfgMode.toUpperCase() == 'RDSAP') && (curUserType == '1')) {
        setDisplay('functitleid', 0);
        setDisplay('funcspreadid01', 0);
        setDisplay('funcspreadid02', 0);
        setDisplay('funcspreadid03', 0);
        setDisplay('titlespreadid', 0);
    }

    if ((isWebLoadConfigfile === '1') && (showCfgKeyOption === 'on')) {
        setDisplay('decrypt_key_input', 1);
        setDisplay('encrypt_key_desc', 1);
        setDisplay('save_encrypt_key', 1);
    }
}

function delayTime(saveflag){
	if (saveflag == 1)
	{			
		saveflag = 0;
		top.SaveDataFlag = 0;
		AlertEx(GetLanguageDesc("s0701"));
	}
}

function CheckForm(type) {
	with(document.getElementById("ConfigForm")) {
	}
	return true;
}

function AddSubmitParam(SubmitForm, type) {
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
	
	if (isBponFlag == 1){
        var ext = filePath.slice(filePath.lastIndexOf(".")+1).toLowerCase();  
        if ("xml" != ext) {
            AlertEx(GetLanguageDesc("s0712"));
            return false;
        }
    }

	return true;
}

function submitDecryptKey()
{
    var useLastKeyElm = document.getElementById('useLastKey');
    var useLastKey = 'off';
    var decryptKeyValue = getValue('decryptKey');
    if (useLastKeyElm.checked == 1) {
        useLastKey = 'on';
        decryptKeyValue = '*';
    }
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : 'decryptKey=' + decryptKeyValue + '&useLastKey=' + useLastKey + '&x.X_HW_Token=' + getValue('onttoken'),
        url : 'decryptKey.cgi',
        success : function(data) {
            var uploadForm = document.getElementById("fr_uploadSetting");
            uploadForm.submit();
            setDisable('browse',1);
            setDisable('btnBrowse',1);
        },
    });
}

function uploadSetting() {
    if (isWebLoadConfigfile == "0") {
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

    if(!ConfirmEx(GetLanguageDesc("s0711"))) {
        return;
    }
    top.previousPage = '/html/ssmp/cfgfile/cfgfile_ap.asp';
    setDisable('btnSubmit', 1);
    if (showCfgKeyOption === 'on') {
        submitDecryptKey();
        return;
    }
    uploadForm.submit();
    setDisable('browse',1);
    setDisable('btnBrowse',1);

}

function checkEncryptKeyScore(encryKey) {
    var score = 0;
    if (encryKey.length < 8 ) {
        return score;
    }
    if (isLowercaseInString(encryKey)) {
        score++;
    }
    if (isUppercaseInString(encryKey)) {
        score++;
    }
    if (isDigitInString(encryKey)) {
        score++;
    }
    if (isSpecialCharacterInString(encryKey)) {
        score++;
    }

    return score;
}

function checkBackupValue() {
    if (showCfgKeyOption === 'on') {
        var encryKey = $("#encryptKey").val();
        if (checkEncryptKeyScore(encryKey) < 3) {
            AlertEx(GetLanguageDesc("s0715"));
            return false;
        }
    }
    return true;
}

function backupSetting() {
   if (isWebLoadConfigfile == "0" || !checkBackupValue()) {
        return;
    }
    if (CfgMode.toUpperCase() == 'DESKAP') {
        if (ConfirmEx(GetLanguageDesc("ss0a0b")) == false) {
            return;
        }
    }

    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    if (showCfgKeyOption === 'on') {
        var encryKey = getValue('encryptKey');
        var saveKeyElm = document.getElementById("enableSaveKey");
        var saveKey = "off";
        if (saveKeyElm.checked == 1) {
            saveKey = "on"
        }
        Form.addParameter('encryKey', encryKey);
        Form.addParameter('saveKey', saveKey);
    }
    Form.setAction('cfgfiledown.cgi?&RequestFile=html/ssmp/cfgfile/cfgfile_ap.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}


function RestoreDefaultCfg()
{	
	if(ConfirmEx(CfgfileLgeDes['ss0a01AP']))
	{
		var Form = new webSubmitForm();
		setDisable('btnRestoreDftCfg', 1);
		Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/cfgfile/cfgfile_ap.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}
</script>
<script language="JavaScript" type="text/javascript">

function fchange()
{
	var ffile = document.getElementById("f_file");
	var tfile = document.getElementById("t_file");
	ffile.value = tfile.value;
    if (isBponFlag == 1){
        var ext = ffile.value.slice(ffile.value.lastIndexOf(".")+1).toLowerCase();  
        if ("xml" != ext) {
            AlertEx(GetLanguageDesc("s0712"));
            return false;
        }
    }

	var buttonstart = document.getElementById('btnSubmit');
	buttonstart.focus();
	return ;
}

function StartFileOpt()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
}

function onGeneratRandKey() {
    var useRandKeyEnable = document.getElementById("UseRandKey");
    var randStr = "";
    if (1 == useRandKeyEnable.checked) {
        var strSet = "ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz1234567890`~!@#$%^&*()-_=+\\|[{}];:";
        var lenth = strSet.length;
        while (checkEncryptKeyScore(randStr) < 3) {
            randStr = "";
            for (i = 0; i < 16; i++) {
                randStr += strSet.charAt(Math.floor(Math.random() * lenth));
            }
        }
    }
    setText('encryptKey', randStr);
    setText('tencryptKey', randStr);
}

function onUseLastKey() {
    var useLastKeyEnable = document.getElementById("useLastKey");
    var lastStr = "";
    if (useLastKeyEnable.checked == 1) {
        var lastStr = "*************";
    }
    setText('decryptKey', lastStr);
}

function onSaveKey() {
    var saveKeyElm = document.getElementById("enableSaveKey");
    var saveKey = "off";
    if (saveKeyElm.checked == 1) {
        if(ConfirmEx(GetLanguageDesc('s0719')) == false) {
            setCheck('enableSaveKey',0);
        }
    }
}

function onHideKey() {
    var hideKeyEnable = document.getElementById("hideKey");
    if (hideKeyEnable.checked == 1) {
        setDisplay('encryptKey', 1);
        setDisplay('tencryptKey', 0);
    } else {
        setDisplay('encryptKey', 0);
        setDisplay('tencryptKey', 1);
    }
}

function onchangeEncryptKey() {
    var encryKey = getValue('encryptKey');
    setText('tencryptKey', encryKey);
}

function onchangeTEncryptKey() {
    var encryKey = $("input[name='tencryptKey']:text").val();
    setText('encryptKey', encryKey);
}

function title_show(input)
{
    var div=document.getElementById("title_show");
    div.style.left = (input.offsetLeft+390)+"px";
    div.innerHTML = CfgfileLgeDes['s0720'];
    div.style.display = '';
}

function title_back(input) 
{
    var div=document.getElementById("title_show");
    div.style.display = "none";
}

function dispEncryptOptions() {
    var str = '<tr id="encrypt_key_desc" style="display:none"><td class="filetitle" BindText="s0713"></td>';
    str += '<div id="title_show" class="filetitle" style="position:absolute; display:none; line-height:16px; width:310px; border:solid 1px #999999; background:#edeef0;"></div>';
    str += '<td><input id="encryptKey" style="margin-left:5px" type="password" autocomplete="off" onmouseover="title_show(this);" onmouseout="title_back(this); " oncopy="return false" name="encryptKey" size="30" maxlength="63" onchange="onchangeEncryptKey()">';
    str += '<input id="tencryptKey" type="text" autocomplete="off" style="display:none; margin-left:5px" onmouseover="title_show(this);" onmouseout="title_back(this); " oncopy="return false" name="tencryptKey" size="30" maxlength="63" onchange="onchangeTEncryptKey()"></td>';
    str += '<td style="width:130px" class="filetitle"><input id="hideKey" name="hideKey" type="CheckBox" class="CheckBox" checked ="checked" onclick="onHideKey()";>'+CfgfileLgeDes['s0721']+'</td>';
    str += '<td style="width:260px" class="filetitle"><input id="UseRandKey" name="useRandKey" type="CheckBox" class="CheckBox" onclick="onGeneratRandKey()">'+CfgfileLgeDes['s0714']+'</td>';
    str += '</tr>';

    str += '<tr id="save_encrypt_key" style="display:none">';
    str += '<td class="filetitle" BindText="s0716"></td>';
    str += '<td style="height:30px"><input id="enableSaveKey" type="CheckBox" name="enableSaveKey" class="CheckBox" onclick="onSaveKey()"></td>';
    str += '</tr>'

    document.write(str);
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
    <script language="JavaScript" type="text/javascript">
        if (((CfgMode.toUpperCase() == 'RDSAP') && (curUserType == '1')) || (isWebLoadConfigfile == "0")) {
            HWCreatePageHeadInfo("cfgfile", GetDescFormArrayById(CfgfileLgeDes, "ss0a03AP"), GetDescFormArrayById(CfgfileLgeDes, "ss0a02AP"), false);
        } else {
            HWCreatePageHeadInfo("cfgfile", GetDescFormArrayById(CfgfileLgeDes, "s0102a"), GetDescFormArrayById(CfgfileLgeDes, "s0a04"), false);
        }
    </script>
    <div id ="funcspreadid01" class="func_spread"></div>
        <div id="downloadConfig" style="display:none">
            <div class="func_title" BindText="s0a05"></div>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <script language="JavaScript" type="text/javascript">
                        if (showCfgKeyOption === 'on') {
                            dispEncryptOptions();
                        }
                    </script>
                    <tr>
                        <script language="JavaScript" type="text/javascript">
                            if (showCfgKeyOption === 'on') {
                                document.write('<td class="filetitle"> </td>')
                            }
                        </script>
                        <td><input class="ApplyButtoncss buttonwidth_150px_250px" name="downloadconfigbutton" id="downloadconfigbutton" type='button' onClick='backupSetting()' BindText="s0a05"></td>
                    </tr>
                 </table>
            </div>
        <div id ="funcspreadid02" class="func_spread"></div>
    <div id="uploadConfig" style="display:none">
        <table>
        <form action="cfgfileupload.cgi?RequestFile=html/ssmp/reset/reset.asp&FileType=config" method="post" enctype="multipart/form-data" name="fr_uploadSetting" id="fr_uploadSetting">
            <div class="func_title" BindText="s0a06"></div>
                <tr>
                    <td class="filetitle" BindText="s070e"></td>
                    <td>
                        <div class="filewrap">
                            <div class="fileupload">
                                <input type="hidden" id="hwonttoken" name="onttoken" value="<%HW_WEB_GetToken();%>" />
                                <input type="text"   id="f_file"     autocomplete="off" readonly="readonly" />
                                <input type="file"   id="t_file"     name="browse" size="1"  onblur="StartFileOpt();" onchange="fchange();" />
                                <input type="button" id="btnBrowse"  class="CancleButtonCss filebuttonwidth_100px" BindText="s070f" />
                            </div>
                        </div>
                    </td>
                    <td>
                        <input type='button' id="btnSubmit" name="btnSubmit" class="CancleButtonCss filebuttonwidth_150px_250px" onclick='uploadSetting();' BindText="s0a06" />
                    </td>
                </tr>
            </form>
            <form id="decryptKeyForm" style="display:none">
                    <tr id="decrypt_key_input" style="display:none">
                        <td class="filetitle" BindText="s0717"></td>
                        <td><input id="decryptKey" type="Password" name="decryptKey" autocomplete="off" size="30" style="width:180px"></td>
                        <td class="filetitle"><input id="useLastKey" name="useLastKey" type="CheckBox" class="CheckBox" onclick="onUseLastKey()" />
                            <script>
                                document.write(CfgfileLgeDes['s0718']);
                            </script>
                        </td>
                    </tr>
            </form>
        </table>
    </div>
    <div id ="funcspreadid03" class="func_spread"></div>
<div id ="titlespreadid" class="title_spread"></div>
<div id ="functitleid" class="func_title" BindText="ss0a03AP"></div>
    <table width="100%" cellpadding="0" cellspacing="0"> 
        <tr>
            <td>
                <input  class = "ApplyButtoncss buttonwidth_150px_250px" name="btnRestoreDftCfg" id="btnRestoreDftCfg" type='button' onClick='RestoreDefaultCfg()'  value="" >
                <script type="text/javascript">
                    if( APwebGuideFlag == 1) {
                        document.getElementsByName('btnRestoreDftCfg')[0].value = CfgfileLgeDes['ss0a03AP']; 
                    } else {
                        document.getElementsByName('btnRestoreDftCfg')[0].value = CfgfileLgeDes['ss0a03']; 
                    }
                </script>
            </td>
        </tr>
    </table>
</div>
    <script>
        ParseBindTextByTagName(CfgfileLgeDes, "div",    1);
        ParseBindTextByTagName(CfgfileLgeDes, "td",     1);
        ParseBindTextByTagName(CfgfileLgeDes, "input",  2);
        ParseBindTextByTagName(CfgfileLgeDes, "span", 1);
    </script>

</body>
</html>
