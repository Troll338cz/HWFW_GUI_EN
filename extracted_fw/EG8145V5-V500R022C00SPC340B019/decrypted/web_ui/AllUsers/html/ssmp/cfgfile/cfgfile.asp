<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_GetCusSource(ptvdfjs.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" type="text/javascript">
var aisApFlag= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MESH);%>";
var aisApRecover= "<%HW_WEB_GetFeatureSupport(FT_WEB_AIS_RECOVERY);%>";
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var UnicomFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>";
var NormalUpdownCfg = "<%HW_WEB_GetFeatureSupport(FT_NORMAL_UPDOWNLOADCFG);%>";
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var curUserType = '<%HW_WEB_GetUserType();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var sysUserType = '0';
var dbaa1SuperSysUserType = '2';
var maxisLocalUserType = '1';
var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
var initLanguage = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE.STRING);%>';
var languageSet = new Array();
var TableName = "ApInfpInst";
var selctIndex = -1;
var reqFile = "html/ssmp/cfgfile/cfgfile.asp";
var ProductType = '<%HW_WEB_GetProductType();%>';
var isWebLoadConfigfile = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOAD_CONFIGFILE);%>";
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var isCfgFileNeedPwd = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRANS_XML_PWD);%>';
var isTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var userAuthorCfg = '<%WEB_UserAuthorForCfgFile();%>';
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

if (CfgMode.toUpperCase() == "TURKCELL2") {
    reqFile = "remote/conf.html";
}


function IsDTedata()
{
    if ((ProductType == '2') && (isTedata == 1)) {
        return true;
    }

    return false;
}

function setSpanValueById(id, val) {
    document.getElementById(id).innerHTML = val;
}

function stCfgFileInfo(version, time, description)
{
    this.time = time;
    this.description = description;
}

if (isCfgFileNeedPwd == 1) {
    var cfgFileInfo = new stCfgFileInfo();
}

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

function AisCpeConfInit()
{
    var supportAisRecover = "<%HW_WEB_GetFeatureSupport(FT_WEB_AIS_RECOVERY);%>";
    if (supportAisRecover != 1) {
        return;
    }

    var userType = '<%HW_WEB_GetUserType();%>';
    if (userType != sysUserType) {
        return;
    }

    function aisCpeConf(domain, uploadServer, downloadServer)
    {
        this.domain = domain;
        this.upload_server = uploadServer;
        this.download_server = downloadServer;
    }

    var aisCpeConfList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Conf, upload_server|download_server, aisCpeConf);%>;
    var aisCpeConf = aisCpeConfList[0]

    setText('input_upload_config_server',   aisCpeConf.upload_server);
    setText('input_download_config_server', aisCpeConf.download_server);
    setDisplay('AisCpeServerConfig', 1);

    return;
}

function AisConfigHelper(attr, attrValue)
{
    var Form = new webSubmitForm();
    Form.setMethod('POST');
    Form.setAction('set.cgi?' + 'x=InternetGatewayDevice.X_HW_Conf' + '&RequestFile=html/ssmp/cfgfile/cfgfile.asp');
    Form.addParameter('x.' + attr, attrValue);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
    return;
}

function AisUploadServerApply()
{
    AisConfigHelper('upload_server', getValue('input_upload_config_server'));
    return;
}

function AisDownloadServerApply()
{
    AisConfigHelper('download_server', getValue('input_download_config_server'));
    return;
}

function AisUploadConfig()
{
    AisConfigHelper('upload_to_server', 1);
    return;
}

function AisDownloadConfig()
{
    AisConfigHelper('download_from_server', 1);
    return;
}

function stApDeviceList(domain,DeviceType,ApOnlineFlag,APMacAddr,SerialNumber)
{
    this.domain = domain;
    this.DeviceType = DeviceType;
    this.ApOnlineFlag = ApOnlineFlag;
    this.APMacAddr = APMacAddr;
    this.SerialNumber = SerialNumber;
}
var apDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i},DeviceType|ApOnlineFlag|APMacAddr|SerialNumber,stApDeviceList);%>;
var apEnableDeviceList = new Array();
var ApCfgStatus = new Array();
var apActionEnable = 0;
var idx = 0;
for (var i = 0; i < apDeviceList.length - 1; i++) {
    if (apDeviceList[i].ApOnlineFlag == '1') {
        GetApEnable(apDeviceList[i].APMacAddr);
        if (apActionEnable == 1) {
            apEnableDeviceList[idx] = apDeviceList[i];
            ApCfgStatus[idx] = 0;
            idx++;
        }
    }
}

function GetApEnable(mac)
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../common/GetApActionEnable.asp?&1=1",
        data :'APMacAddr=' + mac,
        success : function(data) {
            apActionEnable = data;
        }
    });
}

function GetApDownloadCfgStatusByIndex(index)
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../common/getApDownloadCfgStatus.asp?&1=1",
        data :'APMacAddr=' + apEnableDeviceList[index].APMacAddr,
        success : function(data) {
            if (data != '') {
                ApCfgStatus[index]  = data;
            }
        }
    });
}

function GetApDownloadCfgStatus()
{
    if (selctIndex == -1) {
        return;
    }
    GetApDownloadCfgStatusByIndex(selctIndex);
    SetDisplayStatus(ApCfgStatus[selctIndex]);
}

function SetDisplayStatus(stauts)
{
    if (stauts == "0") {
        setDisable('collectApCfgButton',0);
        setDisable('downloadApCfgButton', 1);
        getElement('CollectInfo').innerHTML = '';
    } else if (stauts == "1") {
        setDisable('collectApCfgButton',1);
        setDisable('downloadApCfgButton', 1);
        getElement('CollectInfo').innerHTML = '<B><FONT color=red>'+GetLanguageDesc("s0b09")+ '</FONT><B>';
    } else if (stauts == "2") {
        setDisable('collectApCfgButton',0);
        setDisable('downloadApCfgButton', 0);
        getElement('CollectInfo').innerHTML = '<B><FONT color=red>'+GetLanguageDesc("s0b10")+ '</FONT><B>';
    }
}

if ((aisApFlag == "1") || (CfgMode.toUpperCase() == 'DNOVA2WIFI')) {
    curUserType='0';
}
function IsAdminUser()
{
    if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
    }
    return curUserType == sysUserType;
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

function isSGP210W()
{
    if ((CfgMode.toUpperCase() == 'SYNCSGP210W') || (CfgMode.toUpperCase() == 'SONETSGP210W')) {
        return true;
    }
    return false;
}

function isSGP210W()
{
    if ((CfgMode.toUpperCase() == 'SYNCSGP210W') || (CfgMode.toUpperCase() == 'SONETSGP210W')) {
        return true;
    }
    return false;
}

function LoadFrame() {
    AisCpeConfInit();

    if (isCfgFileNeedPwd == 1) {
        setTimeout("DelayedProcessing()", 500);
    }

    if (top.uploaded == 1) {
        if (GetCfgFileInfo()) {
            displayPopupTable('updateTable');
            setSpanValueById('spanTime', cfgFileInfo.time);
            setSpanValueById('spanDescription', cfgFileInfo.description);
        }
        top.uploaded = 0;
    }


    if (IsAdminUser() || (CfgMode.toUpperCase() == 'OTE') || (CfgMode.toUpperCase() == 'TTNET2')) {
        setDisplay('downloadConfig', isWebLoadConfigfile);
        setDisplay('uploadConfig', isWebLoadConfigfile);
        if ((UnicomFlag == 1) || (IsDTedata())) {
            setDisplay('saveConfig', 0);
        } else {
            setDisplay('saveConfig', 1);
        }
    } else {
        if ((['PCCW4MAC', 'PCCWSMART', 'PCCW2', 'DMASMOVIL2WIFI'].indexOf(CfgMode.toUpperCase()) >= 0) ||
            (NormalUpdownCfg == 1)) {
            setDisplay('saveConfig', 1);
            setDisplay('downloadConfig', isWebLoadConfigfile);
            setDisplay('uploadConfig', isWebLoadConfigfile);
        } else {
            setDisplay('saveConfig', 1);
            if ((CfgMode.toUpperCase() == 'DETHMAXIS') && (curUserType == maxisLocalUserType)) {
                setDisplay('downloadConfig', isWebLoadConfigfile);
                setDisplay('uploadConfig', isWebLoadConfigfile);
            } else {
            setDisplay('downloadConfig', 0);
            setDisplay('uploadConfig', 0);
            }
        }

    }

    if (isSGP210W()) {
        setDisplay('saveConfig', 0);
        setDisplay('downloadConfig', IsWebLoadConfigfile);
        setDisplay('uploadConfig', IsWebLoadConfigfile);
    }

    if ((CfgMode.toUpperCase() == 'TURKCELL2') && (curLanguage == 'turkish')) {
        $("#btnSubmit").css("width", "258px");
    }

    setTimeout('delayTime(top.SaveDataFlag)', 30);
    
    if (apEnableDeviceList.length > 0) {
        if (isBponFlag == 1) {
            setDisplay('downloadApConfig', 0);
        } else {
            setDisplay('downloadApConfig', 1);
        }
        GetApDownloadCfgStatus();
        setInterval(function() {
            try {
                 GetApDownloadCfgStatus();
            } catch (e) {
            }
        }, 1000 * 5);
    }

    if ((isWebLoadConfigfile === '1') && (showCfgKeyOption === 'on')) {
        setDisplay('encrypt_key_desc', 1);
        setDisplay('save_encrypt_key', 1);
        setDisplay('decrypt_key_input', 1);
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

function uploadSettingPtvdf() {
    var uploadForm = document.getElementById("egvdffr_uploadSetting");

    if (Check_SWM_Status() == false) {
        alertVDF(GetLanguageDesc("s0905"));
        return;
    }
    if (VerifyFile('egvdfbrowse') == false) {
        return;
    }

    setDisable('cfgBtnSubmit', 1);
    uploadForm.submit();

    top.uploaded = 1;
    setDisable('egvdfbrowse',1);
    setDisable('cfgBtnBrowse',1);
    cancelPopupTable('loadTable');
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
    if (isCfgFileNeedPwd == 1) {
        uploadSettingPtvdf();
        return;
    }

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

    if(!ConfirmEx(GetLanguageDesc("s0711")))
    {
        return;
    }

    top.previousPage = '/html/ssmp/reset/reset.asp';
    setDisable('btnSubmit', 1);
    if ((isCfgFileNeedPwd != 1) && (showCfgKeyOption === 'on')) {
        submitDecryptKey();
        return;
    }

	uploadForm.submit();
	setDisable('browse',1);
	setDisable('btnBrowse',1);

}

function CheckParameter()
{
    var newPassword = document.getElementById("newPassword");
    var cfmPassword = document.getElementById("cfmPassword");

    if (newPassword.value == "") {
        alertVDF(AccountLgeDes['s0f02']);
        return false;
    }

    if (newPassword.value.length < 8) {
        alertVDF(CfgfileLgeDes["Cfgfile0011"]);
        return false;
    }

    if (newPassword.value.length > 127) {
        alertVDF(AccountLgeDes['s1904']);
        return false;
    }

    if (isValidAscii(newPassword.value) != '') {
        alertVDF(AccountLgeDes['s0f04']);
        return false;
    }

    if (cfmPassword.value != newPassword.value) {
        alertVDF(AccountLgeDes['s0f06']);
        return false;
    }

    return true;
}

function IsPasswordTrue(){
    var password = document.getElementById('newPassword').value;
    var confirmPassWord = document.getElementById('cfmPassword').value;
    if ( password == confirmPassWord) {
        return true
    }
}

function checkPasswordStrength() {
    ClearInput();
    var score = 0;
    var passWord = document.getElementById('newPassword').value;
    if (passWord.length < 8) {
        return score;
    }

    if (isLowercaseInString(passWord)) {
        score++;
    }
    if (isUppercaseInString(passWord)) {
        score++;
    }
    if (isDigitInString(passWord)) {
        score++;
    }
    if (isSpecialCharacterNoSpace(passWord)) {
        score++;
    }

    return score;
}

function egvdfbackupSetting() {
    if (!IsPasswordTrue()) {
      document.getElementById('newPassword').style.border = '1px solid #e60000';
      document.getElementById('newPassword').style.backgroundColor = '#fef0f0';
      document.getElementById('cfmPassword').style.border = '1px solid #e60000';
      document.getElementById('cfmPassword').style.backgroundColor = '#fef0f0';
      AlertEx(CfgfileLgeDes["Cfgfile0012"]);
      return false
    }

    var score = checkPasswordStrength();
    if (score <= 1) {
        AlertEx(AccountLgeDes["s1116l"]);
        return false;
    }
    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    Form.addParameter('description', getValueById("description"));
    Form.addParameter('password', getValueById("newPassword"));
    Form.setAction('ptvdfcfgfiledown.cgi?RequestFile=html/ssmp/cfgfile/cfgfile.asp');
    Form.addParameter('x.X_HW_Token', getValue('egvdfonttoken'));
    cancelPopupTable('saveTable');
    Form.submit();
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
    if ((isCfgFileNeedPwd !== '1') && (showCfgKeyOption === 'on')) {
        var encryKey = $("#encryptKey").val();
        if (checkEncryptKeyScore(encryKey) < 3) {
            AlertEx(GetLanguageDesc("s0715"));
            return false;
        }
    }
    return true;
}

function backupSetting() {
    if (isCfgFileNeedPwd == 1) {
        egvdfbackupSetting()
        return;
    }

    
    if (isWebLoadConfigfile == "0" || !checkBackupValue()) {
        return;
    }

    if (IsSupportPrompt() == true) {
        if (ConfirmEx(GetLanguageDesc("ss0a0b")) == false) {
            return;
        }
    }

    XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
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
    Form.setAction('cfgfiledown.cgi?&RequestFile=' + reqFile);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function aisBackupSetting() {
    if (IsSupportPrompt() == true) {
        if (ConfirmEx(GetLanguageDesc("ss0a0b")) == false) {
            return;
        }
    }
    XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    Form.setAction('cfgaisfiledown.cgi?&RequestFile=' + reqFile);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function SaveSetting() {
	var Form = new webSubmitForm();
	Form.setMethod('POST');
	top.SaveDataFlag = 1;
	Form.setAction('set.cgi?' + 'x=InternetGatewayDevice.X_HW_DEBUG.SSP.DBSave' + '&RequestFile=' + reqFile);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function SaveandReboot()
{
	if(ConfirmEx(GetLanguageDesc("s0706")))
	{
		setDisable('btnsaveandreboot', 1);
		var Form = new webSubmitForm();
		Form.setAction('set.cgi?' + 'x=InternetGatewayDevice.X_HW_DEBUG.SSP.DBSave&y=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard' + '&RequestFile=' + reqFile);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function fchange()
{
    if (isCfgFileNeedPwd == 1) {
        var ffile = document.getElementById("f_file_cfgfile");
        var tfile = document.getElementById("t_file_cfgfile");
        tfile.value = ffile.value;

        var buttonstart = document.getElementById('cfgBtnSubmit');
        buttonstart.focus();
        return ;
    }

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
    XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
}

function OnCollectApCfg()
{
    SetDisplayStatus("1");
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : "APMacAddr=" + apEnableDeviceList[selctIndex].APMacAddr + "&x.X_HW_Token=" + getValue('onttoken'),
        url : 'collectApConfig.cgi?&RequestFile=html/ssmp/cfgfile/cfgfile.asp',
        success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.Result == 0) {
                    return;
                }
                AlertEx(GetLanguageDesc("s0b11"));
                SetDisplayStatus("1");
            }
     });
}

function OnDownloadApCfg()
{
    if (IsSupportPrompt() == true) {
        if (ConfirmEx(GetLanguageDesc("ss0a0b")) == false) {
            return;
        }
    }

    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    Form.addParameter('APMacAddr', apEnableDeviceList[selctIndex].APMacAddr);
    Form.setAction('apCfgFileDownload.cgi?&RequestFile=html/ssmp/cfgfile/cfgfile.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function setCtlDisplay(record)
{
    if (record != null) {
        if (record.DeviceType == '') {
            getElById("DeviceType").innerHTML = '--';
        } else {
            getElById("DeviceType").innerHTML = record.DeviceType;
        }
        if (record.APMacAddr == '') {
            getElById("MacAddress").innerHTML = '--';
        } else {
            getElById("MacAddress").innerHTML = record.APMacAddr;
        }
        if (record.SerialNumber == '') {
            getElById("SerialNumber").innerHTML = '--';
        } else {
            getElById("SerialNumber").innerHTML = record.SerialNumber;
        }
    } else {
        getElById("DeviceType").innerHTML = '--';
        getElById("MacAddress").innerHTML = '--';
        getElById("SerialNumber").innerHTML = '--';
    }
}

function setControl(index)
{
    var record;
    selctIndex = index;
    if (index == -2) {
        setDisplay('ApDeviceListInfo', 0);
        setDisplay('downloadApConfigTable', 0);
    } else if (index != -1) {
        if (isBponFlag == 1) {
            setDisplay('ApDeviceListInfo', 0);
        } else {
            setDisplay('ApDeviceListInfo', 1);
        }
        setDisplay('downloadApConfigTable', 1);
        record = apEnableDeviceList[index];
        setCtlDisplay(record);
        GetApDownloadCfgStatusByIndex(index);
        SetDisplayStatus(ApCfgStatus[index]);
    }
}

function showlistcontrol()
{
    var TableDataInfo = new Array();
    var ColumnNum = 3;
    var ShowButtonFlag = false;
    var Listlen = 0;

    if (apEnableDeviceList.length == 0) {
        TableDataInfo[Listlen] = new stApDeviceList();
        TableDataInfo[Listlen].DeviceType = '--';
        TableDataInfo[Listlen].MacAddress = '--';
        TableDataInfo[Listlen].SerialNumber = '--';
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, apEnableDeviceListInfo, CfgfileLgeDes, null);
        return;
    } else {
        for (var i = 0; i < apEnableDeviceList.length; i++) {
            TableDataInfo[Listlen] = new stApDeviceList();
            if (apEnableDeviceList[i].DeviceType == '') {
                TableDataInfo[Listlen].DeviceType = '--';
            } else {
                TableDataInfo[Listlen].DeviceType = apEnableDeviceList[i].DeviceType;
            }
            if (apEnableDeviceList[i].APMacAddr == '') {
                TableDataInfo[Listlen].MacAddress = '--';
            } else {
                TableDataInfo[Listlen].MacAddress = apEnableDeviceList[i].APMacAddr;
            }
            if (apEnableDeviceList[i].SerialNumber == '') {
                TableDataInfo[Listlen].SerialNumber = '--';
            } else {
                TableDataInfo[Listlen].SerialNumber = apEnableDeviceList[i].SerialNumber;
            }
            Listlen++;
        }
        TableDataInfo.push(null);
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, apEnableDeviceListInfo, CfgfileLgeDes, null);
    }
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
    if (curWebFrame === 'frame_UNICOM') {
        div.style.color = 'rgb(41 41 41)';
        div.style.width = 'auto';
    }
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
    str += '<td style="width:200px" class="filetitle"><input id="UseRandKey" name="useRandKey" type="CheckBox" class="CheckBox" onclick="onGeneratRandKey()">'+CfgfileLgeDes['s0714']+'</td>';
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
        var desResId = "s0100";
        if (isWebLoadConfigfile == "0") {
            desResId = "s0707";
        } else if (UnicomFlag == 1) {
            desResId = "s0103";
        } else if (CfgMode.toUpperCase() == "DETHMAXIS") {
            desResId = "s0100_maxis";
        }
        HWCreatePageHeadInfo("cfgfile", GetDescFormArrayById(CfgfileLgeDes, "s0102"), GetDescFormArrayById(CfgfileLgeDes, desResId), false);
    </script>
    <div class="title_spread"></div>
    <div id="saveConfig">
        <script language="JavaScript" type="text/javascript">
            if (CfgMode.toUpperCase() == "DETHMAXIS") {
                document.write('<div class="func_title" BindText="s0101_maxis"></div>');
            } else {
                document.write('<div class="func_title" BindText="s0101"></div>');
            }
        </script>
        <table width="100%" cellpadding="0" cellspacing="0" class="table_button">
            <tr>
                <td><input  class="ApplyButtoncss buttonwidth_150px_250px" name="saveconfigbutton" id="saveconfigbutton" type='button' onClick='SaveSetting()' BindText="s0709" /></td>
                <td><input  class="ApplyButtoncss buttonwidth_150px_250px" name="btnsaveandreboot" id="btnsaveandreboot" type='button' onClick='SaveandReboot()' BindText="s070a" /></td>
            </tr>
        </table>
    <div class="func_spread"></div>
    </div>
    <div id="AisCpeServerConfig" style="display:none">
        <div class="func_spread"></div>
        <div class="func_title" BindText="aisConfigDiv">
        </div>
        <table width="100%" cellpadding="0" cellspacing="0" class="table_button">
            <tr>
                <td>
                    <label>CPE configuration server URL:</label>
                </td>
                <td style="padding-left: 10px;">
                    <input type="text" id="input_upload_config_server" size="40" style="width: 180px;" maxlength="256" >
                </td>
                <td style="padding-left: 15px;">
                    <input class="ApplyButtoncss buttonwidth_100px" name="btn_upload_server" id="id_btn_upload_server" type='button' onClick='AisUploadServerApply()' BindText="ss0a06">
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td>
                    <label>Configuration file URL:</label>
                </td>
                <td style="padding-left: 10px;">
                    <input type="text" id="input_download_config_server" size="40"  style="width: 180px;" maxlength="256" >
                </td>
                <td style="padding-left: 15px;">
                    <input class="ApplyButtoncss buttonwidth_100px" name="btn_download_server" id="id_btn_download_server" type='button' onClick='AisDownloadServerApply()' BindText="ss0a06">
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td> <input class="ApplyButtoncss buttonwidth_150px_250px" name="btn_ais_upload_config" id="id_btn_ais_upload_config" type='button' onClick='AisUploadConfig()' BindText="aisUploadBtn"> </td>
                <td> <input class="ApplyButtoncss buttonwidth_150px_250px" name="btn_ais_download_config" id="id_btn_ais_download_config" type='button' onClick='AisDownloadConfig()' BindText="aisDownloadBtn"></td>
            </tr>
        </table>
    </div>
    <div id="downloadConfig" style="display:none">
        <div class="func_title" BindText="s070c"></div>
        <table width="100%" cellpadding="0" cellspacing="0" class="table_button">
            <script language="JavaScript" type="text/javascript">
                if ((isCfgFileNeedPwd != 1) && (showCfgKeyOption === 'on')) {
                    dispEncryptOptions();
                }
            </script>
            <tr>
            <script language="JavaScript" type="text/javascript">
                var curClass = "ApplyButtoncss buttonwidth_150px_250px"
                if (curLanguage == 'russian') {
                    curClass = "ApplyButtoncss buttonwidth_36px_260px";
                }  else if (curLanguage == 'portuguese') {
                    curClass = "ApplyButtoncss buttonwidth_150px_300px";
                }

                if (isCfgFileNeedPwd == 1) {
                    document.write('<td><input class="' + curClass + '" name="saveButton" id="saveButton" type="button" onClick="SaveCfgFile()" BindText="s070c"></td>');
                } else {
                    document.write('<td class="filetitle"> </td>')
                    if (aisApRecover == 1) {
                        document.write('<td><input class="' + curClass + '" name="downloadconfigbutton" id="downloadconfigbutton" type="button" onClick="backupSetting()" BindText="s070c_aisvender"></td>');
                        document.write('<td><input class="' + curClass + '" name="downloadaisconfigbutton" id="downloadaisconfigbutton" type="button" onClick="aisBackupSetting()" BindText="s070c_aisstandard"></td>');
                    } else {
                        document.write('<td><input class="' + curClass + '" name="downloadconfigbutton" id="downloadconfigbutton" type="button" onClick="backupSetting()" BindText="s070c"></td>');
                    }
                }
            </script>
            </tr>
        </table>
    </div>
    <div class="func_spread"></div>
    <div id="uploadConfig" style="display:none">
        <form action="cfgfileupload.cgi?RequestFile=html/ssmp/reset/reset.asp&FileType=config" method="post" enctype="multipart/form-data" name="fr_uploadSetting" id="fr_uploadSetting">
            <script language="JavaScript" type="text/javascript">
                if (CfgMode.toUpperCase() == "DETHMAXIS") {
                    document.write('<div class="func_title" BindText="s0710_maxis"></div>');
                } else {
                    document.write('<div class="func_title" BindText="s0710"></div>');
                }
                if (isCfgFileNeedPwd == 1) {
                    document.write('<table width="100%" cellpadding="0" cellspacing="0" class="table_button">');
                } else {
                    document.write('<table>');
                }
            </script>
                <tr>
                    <script language="JavaScript" type="text/javascript">
                        if (isCfgFileNeedPwd != 1) {
                            document.write('<td class="filetitle" BindText="s070e"></td>');
                            document.write('<td>');
                        }
                    </script>
                    <div class="filewrap">
                        <div class="fileupload">
                            <script language="JavaScript" type="text/javascript">
                                if (isCfgFileNeedPwd == 1) {
                                    document.write('<td><input class="' + curClass + '" name="loadButton" id="loadButton" type="button" onClick="LoadCfgFile()" BindText="s0710"></td>');
                                } else {
                                    document.write('<input type="hidden" id="hwonttoken" name="onttoken" value="<%HW_WEB_GetToken();%>" />');
                                    document.write('<input type="text"   id="f_file"     autocomplete="off" readonly="readonly" />');
                                    document.write('<input type="file"   id="t_file"     name="browse" size="1"  onblur="StartFileOpt();" onchange="fchange();" />');
                                    document.write('<input type="button" id="btnBrowse"  class="CancleButtonCss filebuttonwidth_100px" BindText="s070f" />');
                                }
                                if (CfgMode.toUpperCase() == "DINFOTEK2") {
                                    document.getElementById("btnBrowse").style.backgroundColor = "#0cb433";
                                }
                            </script>
                        </div>
                    </div>
                    <script language="JavaScript" type="text/javascript">
                        if (isCfgFileNeedPwd != 1) {
                            document.write('</td>');
                        }
                    </script>
                    <td>
                    <script language="JavaScript" type="text/javascript">
                            var buttonTextId = "s0710";
                            if (CfgMode.toUpperCase() == "DETHMAXIS") {
                                buttonTextId = "s0710_maxis";
                        }
                        if (isCfgFileNeedPwd != 1) {
                            if (CfgMode == "DICELANDVDF") {
                                document.write('<input type="button" id="btnSubmit" name="btnSubmit" class="ApplyButtoncss filebuttonwidth_150px_250px" onclick="uploadSetting();" BindText="' + buttonTextId + '" />');
                            } else {
                                document.write('<input type="button" id="btnSubmit" name="btnSubmit" class="CancleButtonCss filebuttonwidth_150px_250px" onclick="uploadSetting();" BindText="' + buttonTextId + '" />');
                            }
                        }
                    </script>
                    </td>
                </tr>
            </form>
            <form>
                <tr id="decrypt_key_input" style="display:none">
                    <td class="filetitle" BindText="s0717"></td>
                    <td><input id="decryptKey" type="Password" name="decryptKey" autocomplete="off" size="30" style="width:180px;"></td>
                    <td class="filetitle"><input id="useLastKey" name="useLastKey" type="CheckBox" class="CheckBox" onclick="onUseLastKey()" />
                        <script>
                            document.write(CfgfileLgeDes['s0718']);
                        </script>
                    </td>
                </tr>
            </form>
        </table>
    </div>
    <div class="func_spread"></div>
    <form id="downloadApConfig" style="display:none">
    <div class="func_title" BindText="s0b00"></div> 
    <script language="JavaScript" type="text/javascript">
        var apEnableDeviceListInfo = new Array(new stTableTileInfo("s0b01","align_center","DeviceType"),
                                               new stTableTileInfo("s0b02","align_center","MacAddress"),
                                               new stTableTileInfo("s0b03","align_center","SerialNumber"),
                                               null);
        showlistcontrol();
    </script>
    </form> 
    <form id="ApDeviceListInfo" style="display:none">
        <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <li id="DeviceType" RealType="HtmlText" DescRef="s0b04" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FALSE" InitValue="Empty" ClickFuncApp="Empty"/>
            <li id="MacAddress" RealType="HtmlText" DescRef="s0b05" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FALSE" InitValue="Empty" ClickFuncApp="Empty"/>
            <li id="SerialNumber" RealType="HtmlText" DescRef="s0b06" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FALSE" InitValue="Empty" ClickFuncApp="Empty"/>
            <script>
                var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
                CollectFaultFormList = HWGetLiIdListByForm("ApDeviceListInfo",null);
                HWParsePageControlByID("ApDeviceListInfo", TableClass, CfgfileLgeDes, null);
            </script> 

        </table>
        <table width="100%" cellpadding="0" cellspacing="1" class="table_button">
        <tr>
            <td><input class="ApplyButtoncss buttonwidth_150px_250px" name="collectApCfgButton" id="collectApCfgButton" type='button' onClick='OnCollectApCfg()' BindText="s0b07"></td>
            <td><input class="ApplyButtoncss buttonwidth_150px_250px" name="downloadApCfgButton" id="downloadApCfgButton" type='button' onClick='OnDownloadApCfg()' BindText="s0b08"></td>
        </tr>
        <div id="CollectInfo"></div>
        </table> 
    </form>

    <script>
        ParseBindTextByTagName(CfgfileLgeDes, "div",    1);
        ParseBindTextByTagName(CfgfileLgeDes, "td",     1);
        ParseBindTextByTagName(CfgfileLgeDes, "input",  2);
    </script>

    <div id="content">
        <script>
        function sucessNext() {
            displayPopupTable('loadTable');
        }
        
        function CreatPopupInfoTable(tableTitle, tableID, info){
            var htmlinfo = '<div class="blackBackgroundBlock" id="' + tableID + '" style="display:none;">';
            htmlinfo +='<div class="popup big add">';
            htmlinfo +='<p class="title"><span id="' + tableID + '_title">' + tableTitle + '</span></p>';
            document.write(htmlinfo);
            document.write(info);
            document.write("</div></div>");
        }
        
        function tableArrayInfo(type, labelInfo, inputID, clickfunction) {
            this.type = type;
            this.labelInfo = labelInfo;
            this.inputID = inputID;
            this.clickfunction = clickfunction;
        }
        
        function SaveCfgFile()
        {
            displayPopupTable('saveTable');
            ClearInput();
            $('.passWordLeval_weak1').show();
            $('.passWordLeval_weak').hide();
            $('.passWordLeval_good').hide();
            $('.passWordLeval_strong').hide();
            document.getElementById('newPassword').value = ''; 
            document.getElementById('cfmPassword').value = ''; 
        }

      function CreatLineBySpanText(labelInfo, inputID, spanText, firstFalg) {
          var rowclass = firstFalg == true ? "row" : "row topline";
          var htmlinfo = '<div class="' + rowclass + '">'
          htmlinfo += '<div class="left" style="float:left;width:200px"><span class="table_title">' + labelInfo + ':</span></div>';
          htmlinfo += '<div class="right paddingall20 table_title">';
          var spanInfo = escapeHTML(spanText) == "" ? "&nbsp" : escapeHTML(spanText);
          htmlinfo += '<span id = "' + inputID + '">' + spanInfo + '</span>';
          htmlinfo += '</div>';
          htmlinfo += '</div>';
          document.write(htmlinfo);
      }

    function CreatLineBySingleInput(labelInfo, inputID, maxLength, firstFalg) {
      var inputType = "text";
      var maxLengthstr = ""
      if ((maxLength != "") && (maxLength != null)) {
          maxLengthstr = 'maxLength="' + maxLength + '"';
      }
      if (inputID.toUpperCase().indexOf("PASSWORD") > -1) {
          inputType = "password";
      } else if (inputID.toUpperCase().indexOf("NUMBER") > -1) {
          maxLengthstr = 'maxLength="' + maxLength + '" oninput="checkInputNumber(this)"';
      }
      var rowclass = firstFalg == true ? "row" : "row topline";
      var htmlinfo = '<div class="' + rowclass + '">'
      htmlinfo += '<div class="left" style="float:left;width:200px"><span class="table_title">' + labelInfo + ':</span></div>';
      htmlinfo += '<div class="right padding20 table_title">';
      htmlinfo += '<input type="' + inputType + '" id = "' + inputID + '" ' + maxLengthstr + '>';
      htmlinfo += '</div>';
      htmlinfo += '</div>';
      document.write(htmlinfo);
    }

    function CreatLineBySmartBox(labelInfo, inputID, smartboxinfo, firstFalg) {
      var rowclass = firstFalg == true ? "row" : "row topline";
      var htmlinfo = '<div class="' + rowclass + '">'
      htmlinfo += '<div class="left"><span class="table_title">' + labelInfo + '</span></div>';
      htmlinfo += '<div class="right padding20" id = "' + inputID + '">';
      htmlinfo += smartboxinfo;
      htmlinfo += '</div>';
      htmlinfo += '</div>';
      document.write(htmlinfo);
    }

function CreatPopupTable(tableTitle, tableID, tableArrayInfo, applyFunction){
    var Language = GetcurLanguage();
    applyFunction = ProcessFunctionName(applyFunction);
    var cancelFunction = "cancelPopupTable('" + tableID + "');";
    var htmlinfo = '<div class="blackBackgroundBlock" id="' + tableID + '" style="display:none;">';
    htmlinfo +='<div class="popup big add">';
    htmlinfo +='<p class="PageTitle_title"><span id="' + tableID + '_title">' + tableTitle + '</span></p>';
    document.write(htmlinfo);
    htmlinfo = "";
    CreatSetInfoTable("", tableID + "_table", tableArrayInfo);
    htmlinfo += '<div class="apply-cancel">';
    htmlinfo += '<input type="button" id="' + tableID + '_apply' + '" class="ApplyButtoncss buttonwidth_100px" value="Apply" onclick="' + applyFunction + '">';
    htmlinfo += '<input type="button" class="CancleButtonCss buttonwidth_100px" value="Cancel" onclick="' + cancelFunction + '">';
    htmlinfo += '</div>';
    htmlinfo += "</div></div>";
    document.write(htmlinfo);
}

        function CreatSetInfoTable(tableTitle, tableID, tableArrayInfo) {
            tableTitle = escapeHTML(tableTitle);
            if (tableTitle != "" && tableTitle != null) {
                document.write('<div id="' + tableID + '" class="padding_b50">');
                document.write('<h3><span class="language-string">' + tableTitle + '</span></h3>');
            } else {
                document.write('<div id="' + tableID + '">');
            }
            document.write('<div class="h3-wrapper-content">');
            for (var i=0; i < tableArrayInfo.length; i++) {
                var firstFalg = i == 0 ? true : false;
                switch (tableArrayInfo[i].type) {
                    case 'iptable':
                        CreatLineByIpTable(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, firstFalg);
                        break;
                    case 'mactable':
                        CreatLineByMacTable(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, firstFalg);
                        break;
                    case 'singleinput':
                        CreatLineBySingleInput(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'portolinput':
                        CreatLineByPortolInput(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'select':
                        CreatLineBySelect(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'selectnotop':
                        firstFalg = i == 1 ? false : true;
                        CreatLineBySelect(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'switchbutton':
                        CreatLineBySwitchButton(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'clickbutton':
                        CreatLineByClickButton(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                    break;
                    case 'radiobutton':
                        CreatLineByRadioButton(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'span':
                        CreatLineBySpanText(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'checkboxbutton':
                        CreatLineByCheckBoxButton(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'smartbox':
                        CreatLineBySmartBox(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                        break;
                    case 'selectportol':
                        CreatLineByPortolSelect(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                    break;
                    case 'multipleiptable': 
                        CreatLineByMultipleTable(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                    break;
                    case 'externaliptable':
                        CreatLineByExternalIPTable(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                    break;
                    case 'iprangetable': 
                        CreatLineByIPRangeTable(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                    break;
                    case 'externalipv4table':
                        CreatLineByExternalIPv4Table(tableArrayInfo[i].labelInfo, tableArrayInfo[i].inputID, tableArrayInfo[i].clickfunction, firstFalg);
                    break;
                    default:
                        break;
                }
            }
            document.write('</div>');
            document.write('</div>');
        }
        
        function updateSetting()
        {
            if (getValueById("enterPassword").length < 8) {
                alertVDF(CfgfileLgeDes["Cfgfile0011"]);
                return;
            }
        
            var Form = new webSubmitForm();
            Form.addParameter('password', getValueById("enterPassword"));
            Form.setAction('ptvdfcfgfileupgrade.cgi?' + 'RequestFile=html/ssmp/cfgfile/cfgfile.asp');
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            cancelPopupTable('updateTable');
            Form.submit();
        }
        
        function restoreSetting()
        {
            confirmVDF(RestoreLgeDes['s0a01'],"sucessSub()");
            return;
        }
        
        function ClearInput() {
            document.getElementById('newPassword').style.backgroundColor = '#ffffff';
            document.getElementById('newPassword').style.border = '1px solid #000000';
            document.getElementById('cfmPassword').style.backgroundColor = '#ffffff';
            document.getElementById('cfmPassword').style.border = '1px solid #000000';
        }
        
        function GetCfgFileInfo()
        {
            var result = false;
            $.ajax({
                type : "POST",
                async : false,
                cache : false,
                url : "/html/ssmp/common/getcfgfileinfo.asp",
                success : function(data) {
                    if (data == "error") {
                        AlertEx(CfgfileLgeDes["ss0a10"]);
                    } else {
                        cfgFileInfo = dealDataWithStr(data)[0];
                        result = true;
                    }
                }
            });
        
            return result;
        }
        
        function CreatHeaderTitle(Title, Description) {
            document.write("<div id='headtitle'>");
            document.write("<h1><span id='title_span'>" + Title + "</span></h1>");
            if ((Description != null) && (Description != "")) {
                document.write("<h2><span id='title_desp'>" + Description + "</span></h2>");
            }
            document.write("</div>");
        }
        
        function DelayedProcessing()
        {
            if (window.location.href.indexOf("ptvdfcfgfileupgrade.cgi?") > 0) {
                displayPopupTable('UpdateEndTable');
            }
        }
        
        function LoadCfgFile() {
          if (!ConfirmEx(CollectInfoLgeDes["s2019"])) {
            return;
          }
          displayPopupTable('loadTable');
        }
        </script>
            <div class="blackBackgroundBlock" id="saveTable" style="display: none;">
                <div class="popup big add">
                    <p class="PageTitle_title">
                        <span id="saveTable_title">Save Configuration to Computer</span>
                    </p>
                    <script>
                       document.write('<div style="font-size:14px;color:#5c5d55">' + CfgfileLgeDes["Cfgfile002"]+ '<br/>' + CfgfileLgeDes["Cfgfile003"] + " " + AccountLgeDes["s1116l"] + '</div><br/>');
                    </script>
                    <div id="saveTable_table"><div class="h3-wrapper-content">
                        <script>
                            if (isCfgFileNeedPwd == 1) {
                                document.write('<table width="100%"')
                                document.write('<table class="tabal_noborder_bg"><tbody>');
                                document.write('<tr border="1"><td class="table_title width_per30">Description:</td><td class="table_right width_per70"><input type="text" id="description" maxlength="512"></td></tr>');
                                document.write('<tr border="1"><td class="table_title width_per30">'+ AccountLgeDes["s0f09"] +'</td><td class="table_right width_per70"><input type="password" autocomplete="off" id="newPassword" maxlength="127"></tr>');
                                document.write('<tr border="1"><td class="table_title width_per30">'+ AccountLgeDes["s0f0b"] +'</td><td class="table_right width_per70"><input type="password" autocomplete="off" id="cfmPassword" maxlength="127"></td><td></td></tr>');
                                document.write('</tbody></table>');
                            }
                        </script>
                    </div>
                </div>
                <div class="apply-cancel" style="padding-top:15px;">
                    <input type="button" id="saveTable_apply" class="ApplyButtoncss buttonwidth_100px" value="Apply" onclick="backupSetting();">
                    <input type="button" class="CancleButtonCss buttonwidth_100px" value="Cancel" onclick="cancelPopupTable('saveTable');">
                </div>
            </div>
        </div>
        <script>
            if (isCfgFileNeedPwd == 1) {

                  var loadPopupInfo = '<div id="uploadConfig" class="no-padding">';
                  loadPopupInfo += '<form action="ptvdfcfgfileupload.cgi?RequestFile=html/ssmp/cfgfile/cfgfile.asp&FileType=config" method="post" enctype="multipart/form-data" name="egvdffr_uploadSetting" id="egvdffr_uploadSetting">';
                  loadPopupInfo += '<table width="100%" cellpadding="0" cellspacing="0" class="cfgTable_button">';
                  loadPopupInfo += '<div class="row">';
                  loadPopupInfo += '<div class="left width650">';
                  loadPopupInfo += '<input type="hidden" name="onttoken" id="egvdfonttoken" value="<%HW_WEB_GetToken();%>">';
                  loadPopupInfo += '<input type="text"   id="t_file_cfgfile"     autocomplete="off" readonly="readonly" />';
                  loadPopupInfo += '<input type="file"   id="f_file_cfgfile" name="egvdfbrowse" size="1"  onblur="StartFileOpt();" onchange="fchange();" />';
                  loadPopupInfo += '<input type="button" id="cfgBtnBrowse" class="ApplyButtoncss buttonwidth_100px filebutton_ptvdf" BindText="s070f" />';
                  loadPopupInfo += '<input type="button" id="cfgBtnSubmit" name="cfgBtnSubmit" class="ApplyButtoncss buttonwidth_100px filebutton_ptvdf" onclick="uploadSetting();" BindText="s1006"/></div></div>';
                  loadPopupInfo += '<div class="right padding20"/>';
                  loadPopupInfo += '<div class="confirmpop">';
                  loadPopupInfo += '<input id="cancel" type="button" value="Cancel" onclick="cancelPopupTable(\'loadTable\');" class="CancleButtonCss buttonwidth_100px">';
                  loadPopupInfo += '</div></table></form></div>';
                  CreatPopupInfoTable("File Upload", "loadTable", loadPopupInfo);
                  
                  var updateTableInfo = new Array(new tableArrayInfo("span", CfgfileLgeDes["Cfgfile006"], "spanTime", "--"),
                                                  new tableArrayInfo("span", CfgfileLgeDes["Cfgfile008"], "spanDescription", "--"),
                                                  new tableArrayInfo("smartbox", CfgfileLgeDes["Cfgfile009"], "", ""),
                                                  new tableArrayInfo("singleinput", CfgfileLgeDes["Cfgfile0018"], "enterPassword", 127));
                  CreatPopupTable(CfgfileLgeDes["Cfgfile005"], "updateTable", updateTableInfo, "updateSetting()");
                  
                  var UpdateEndTableInfo = '<span>' + PrompterDes['s131a'] + '</span>';
                  CreatPopupInfoTable(CfgfileLgeDes["Cfgfile004"], "UpdateEndTable", UpdateEndTableInfo);
                  
                  ParseBindTextByTagName(CfgfileLgeDes, "div",   1);
                  ParseBindTextByTagName(CfgfileLgeDes, "td",    1);
                  ParseBindTextByTagName(CfgfileLgeDes, "input", 2);
            }
        </script>
    </div>
</body>
</html>
