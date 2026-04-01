<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" type="text/javascript">

var TableName = "certificateInfoInst";
var TableClass = new stTableClass("table_title width_per25", "table_right width_per75", "", "Select");
var AddFlag = true;
var selectIndex = -2;

function CertificateInfo(domain, X_HW_Type, X_HW_Usage, X_HW_Priority, X_HW_Thumbprint, LastModif, X_HW_Alias, X_HW_CRLPath) {
    this.domain = domain;
    this.type = X_HW_Type;
    this.usage = X_HW_Usage;
    this.priority = X_HW_Priority;
    this.thumbprint = X_HW_Thumbprint;
    this.uploadTime = LastModif;
    this.alias = X_HW_Alias;
    this.crlPath = X_HW_CRLPath;
}

var certificateList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.Security.Certificate.{i}, X_HW_Type|X_HW_Usage|X_HW_Priority|X_HW_Thumbprint|LastModif|X_HW_Alias|X_HW_CRLPath, CertificateInfo);%>;
var certificateInfoList = new Array();
for (var i = 0; i < certificateList.length - 1; i++) {
    if ((certificateList[i].usage == "ONT_AUTHEN_IPSEC") || (certificateList[i].usage == "ACS_AUTHEN_ONT") || 
        (certificateList[i].usage == "ONT_AUTHEN_ACS") || (certificateList[i].usage == "USER_AUTHEN_WEB")) {
        certificateInfoList.push(certificateList[i]);
    }
    
}

function stIpSecVPN(domain, IKECertificate) {
    this.domain = domain;
    this.IKECertificate = IKECertificate;
}

var ipsecVPN = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_VPN.A8C_IPSecVPN.{i},IKECertificate,stIpSecVPN);%>;
var usedIpsecCert = new Array();
for (var i = 0; i < ipsecVPN.length - 1; i++) {
    if (ipsecVPN[i].IKECertificate != '') {
        usedIpsecCert.push(ipsecVPN[i].IKECertificate);
    }
}

function setControl(index)
{
    selectIndex = index;
    if (index == -1) {
        if(certificateInfoList.length >= 16) {
            setDisplay('certificateForm', 0);
            setDisplay('applycancel', 0);
            AlertEx(certificateManageDes['s11024']);
            return;
        }
        AddFlag = true;
        setDisplay('certificateForm', 1);
        CtrlDisplay(index);
    } else if (index == -2) {
        setDisplay('certificateForm', 0);
    } else {
        AddFlag = false;
        setDisplay('certificateForm', 1);
        CtrlDisplay(index);
    }
    DisableApplyCancle(0);
}

function ChangeCertificateType(index)
{
    var cerType = getElementById('certificateUsage');
    cerType.options.length = 0;
    if (index == -1) {
        cerType.options.add(new Option(certificateManageDes['s11021'], 'ONT_AUTHEN_IPSEC'));
    } else {
        cerType.options.add(new Option(certificateManageDes['s11018'], 'ACS_AUTHEN_ONT'));
        cerType.options.add(new Option(certificateManageDes['s11019'], 'ONT_AUTHEN_ACS'));
        cerType.options.add(new Option(certificateManageDes['s11020'], 'USER_AUTHEN_WEB'));
        cerType.options.add(new Option(certificateManageDes['s11021'], 'ONT_AUTHEN_IPSEC'));
    }
}

function CtrlDisplay(index)
{
    ChangeCertificateType(index);
    setDisable('certificateUsage', 0);
    setDisable('certificateAlias', 0);
    setDisplay('certificatePriorityRow', 1);
    setDisplay('certPasswordRow', 1);
    setDisplay('cfmCertPasswordRow', 1);
    setDisplay('browseFileRow', 1);
    setDisplay('applycancel', 1);
    if (index == -1) {
        setDisplay('certificateThumbprintRow', 0);
        setDisplay('crlBrowseFileRow', 0);
        setDisplay('crlapplycancel', 0);
        CleanInput();
        CleanCRLInput();
    } else {
        setDisplay('certificateThumbprintRow', 1);
        var curCertificateInfo = certificateInfoList[index];
        getElById("certificateThumbprint").innerHTML = curCertificateInfo.thumbprint;
        setText('certificateAlias', curCertificateInfo.alias);
        setText('certificatePriority', curCertificateInfo.priority);
        setSelect('certificateUsage',curCertificateInfo.usage);
        var table = document.getElementById('crlBrowseFileRow');
        table.style.display = "";
        var ffile = document.getElementsByName("crltext")[0];
        ffile.value = curCertificateInfo.crlPath;
        
        setDisable('certificateUsage', 1);
        setDisable('certificateAlias', 1);
        setDisplay('crlapplycancel', 1);
        setDisplay('certificatePriorityRow', 0);
        setDisplay('certPasswordRow', 0);
        setDisplay('cfmCertPasswordRow', 0);
        setDisplay('browseFileRow', 0);
        setDisplay('applycancel', 0);
    }
}

function CleanInput()
{
    getElById("certificateThumbprint").innerHTML = '';
    setText('certificateAlias', '');
    setText('certificatePriority', '1');
    setText('certPassword', '');
    setText('cfmCertPassword', '');
    setText('f_file_1', '');
    var ffile = document.getElementById("f_file_1");
    ffile.value = '';
}

function CleanCRLInput()
{
    getElById("certificateThumbprint").innerHTML = '';
    setText('certificateAlias', '');
    setText('certificatePriority', '1');
    setText('certPassword', '');
    setText('cfmCertPassword', '');
    setText('f_file_1', '');
    var ffile = document.getElementsByName("crltext");
    ffile.value = '';
}

function DisableApplyCancle(disable)
{
    if (disable == 0) {
        setDisable('btnApply1',0);
        setDisable('btnCancle1',0);
    } else {
        setDisable('btnApply1',1);
        setDisable('btnCancle1',1);
    }
}

function GetAbbreviationThumbprint(value)
{
    if (value.length < 16) {
        return value;
    }
    return value.substr(0, 4) + '......' + value.substr(value.length - 4, 4);
}

function GetUsageResource(value)
{
    switch (value) {
        case 'USER_AUTHEN_WEB': {
                value = certificateManageDes['s11020'];
            } break;
        case 'ONT_AUTHEN_ACS': {
                value = certificateManageDes['s11019'];
            } break;
        case 'ACS_AUTHEN_ONT': {
                value = certificateManageDes['s11018'];
            } break;
        case 'ONT_AUTHEN_IPSEC': {
                value = certificateManageDes['s11021'];
            } break;
        default :
            break
    }
    return value;
}

function GetTypeByUsage(value)
{
    var type = 'AUTHEN_CERT';
    switch (value) {
        case 'USER_AUTHEN_WEB': {
                type = 'AUTHEN_CERT';
            } break;
        case 'ONT_AUTHEN_ACS': {
                type = 'CA_CERT';
            } break;
        case 'ACS_AUTHEN_ONT': {
                type = 'AUTHEN_CERT';
            } break;
        case 'ONT_AUTHEN_IPSEC': {
                type = 'ALL_CERT';
            } break;
        default :
            break
    }
    return type;
}

function InitTableData()
{
    var TableDataInfo = new Array();
    var ColumnNum = 6;
    var ShowButtonFlag = true;
    var Listlen = 0;

    if (certificateInfoList.length == 0) {
        TableDataInfo[Listlen] = new CertificateInfo();
        TableDataInfo[Listlen].domain = '--';
        TableDataInfo[Listlen].certificateThumbprint = '--';
        TableDataInfo[Listlen].certificateAlias = '--';
        TableDataInfo[Listlen].uploadTime = '--';
        TableDataInfo[Listlen].certificateUsage = '--';
        TableDataInfo[Listlen].Priority = '--';
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, cerListInfo, certificateManageDes, null);
        return;
    } else {
        for (var i = 0; i < certificateInfoList.length; i++) {
            TableDataInfo[Listlen] = new CertificateInfo();
            TableDataInfo[Listlen].domain = certificateInfoList[i].domain;
            TableDataInfo[Listlen].certificateThumbprint = GetAbbreviationThumbprint(certificateInfoList[i].thumbprint);
            TableDataInfo[Listlen].certificateAlias = certificateInfoList[i].alias;
            TableDataInfo[Listlen].uploadTime = certificateInfoList[i].uploadTime;
            TableDataInfo[Listlen].certificateUsage = GetUsageResource(certificateInfoList[i].usage);
            TableDataInfo[Listlen].Priority = certificateInfoList[i].priority;
            Listlen++;
        }
        TableDataInfo.push(null);
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, cerListInfo, certificateManageDes, null);
    }
}

function StartFileOpt()
{
    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
}

function IsValideFileSize(target)
{
    var fileSize = target.files[0].size;
    if (fileSize > 1024 * 1024) {
        AlertEx(GetDescFormArrayById(certificateManageDes, "s11042"));
        return false;
    }

    return true;
}

function IsValideFileType(target)
{
    var fileName = target.files[0].name;
    var index = fileName.lastIndexOf(".");
    var suffix = fileName.substring(index);
    var valideSuffix = [".crt", ".pem", ".crl", ".key"]
    for (var i = 0; i < valideSuffix.length; i++) {
        if (suffix === valideSuffix[i]) {
            return true;
        }
    }
    AlertEx(GetDescFormArrayById(certificateManageDes, "s11043"));
    return false;
}

function CleanAllInput()
{
    CleanInput();
    DisableApplyCancle(0);

    if (AddFlag == true) {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length > 2) {
            tableRow.deleteRow(tableRow.rows.length - 1);
            selectIndex = -2;
        }
    }
}

function fchange(target)
{
    if (!IsValideFileSize(target) || !IsValideFileType(target)) {
        CleanAllInput();
        return;
    }
    var ffile = document.getElementsByName("f_file_1")[0];
    var tfile = document.getElementsByName("browse")[0];
    ffile.value = tfile.value;
}

function CrlFchange(target)
{
    if (!IsValideFileSize(target) || !IsValideFileType(target))
    {
        CleanAllInput();
        return;
    }
    var ffile = document.getElementsByName("crltext")[0];
    var tfile = document.getElementsByName("crlBrowse")[0];
    ffile.value = tfile.value;
}

function CheckCertAlias()
{
    var alias = getValue('certificateAlias').trim();
    setText('certificateAlias', alias);
    if (alias.length > 32) {
        AlertEx(certificateManageDes['s11026']);
        return false;
    }
    for (var i = 0; i < alias.length; i++) {
        var ch = alias.charAt(i);
        if (((ch >= '0') && (ch <= '9')) || ((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')) ||
            (ch == '-') || (ch == '_')) {
            continue;
        }
        AlertEx(certificateManageDes['s11027']);
        return false;
    }
    return true;
}

function CheckPrvPassword(upload)
{
    var pwd = getValue('certPassword');
    if ((AddFlag || upload) && (pwd.length == 0)) {
        AlertEx(certificateManageDes['s11016']);
        setText('certPassword', '');
        setText("cfmCertPassword", '');
        return false;
    }
    if (pwd != getValue('cfmCertPassword')) {
        AlertEx(certificateManageDes['s11030']);
        setText('certPassword', '');
        setText("cfmCertPassword", '');
        return false;
    }
    if (pwd.length > 32) {
        AlertEx(certificateManageDes['s11031']);
        setText('certPassword', '');
        setText("cfmCertPassword", '');
        return false;
    }
    
    return true;
}

function CheckPriority()
{
    var priority = getValue('certificatePriority')
    if (CheckNumber(priority, 1, 100) == false) {
        AlertEx(certificateManageDes['s11029']);
        return false;
    }
    return;
}

function CheckForm(upload)
{
    if (CheckCertAlias() == false) {
        return false;
    }
    if (CheckPriority() == false) {
        return false;
    }
    if (CheckPrvPassword(upload) == false) {
        return false;
    }

    return true;
}

function SubmitForm()
{
    var uploadForm = document.getElementById("fr_uploadImage");
    var upload = false;
    var File = document.getElementsByName('f_file_1')[0].value;
    if (File.length != 0) {
        upload = true;
        if (File.length > 128) {
            AlertEx(GetDescFormArrayById(certificateManageDes, "s11032"));
            return false;
        }
    }
    if (CheckForm(upload) == false) {
        return;
    }
    
    if (AddFlag) {
        if (upload == false) {
            AlertEx(GetDescFormArrayById(certificateManageDes, "s11033"));
            return false;
        }
        fillDataToForm();
    } else {
        if (upload) {
            fillDataToForm();
        } else {
            ApplyParaWithoutCert();
            return;
        }
    }

    DisableApplyCancle(1);
    uploadForm.submit();
    DisableRepeatSubmit();
}

function SubmitCRLForm()
{
    var uploadForm = document.getElementById("crl_fr_uploadImage");
    var upload = false;
    var File = document.getElementsByName('crltext')[0].value;
    if (File.length != 0) {
        upload = true;
        if (File.length > 128) {
            AlertEx(GetDescFormArrayById(certificateManageDes, "s11032"));
            return false;
        }
    }

    if (upload == false) {
        AlertEx(GetDescFormArrayById(certificateManageDes, "s11033"));
        return false;
    }

    DisableApplyCancle(1);
    uploadForm.submit();
    DisableRepeatSubmit();
}

function ApplyParaWithoutCert()
{
    var Form = new webSubmitForm();

    Form.addParameter('x.X_HW_Usage', getSelectVal('certificateUsage'));
    Form.addParameter('x.X_HW_Type', GetTypeByUsage(getSelectVal('certificateUsage')));
    Form.addParameter('x.X_HW_Alias', getValue('certificateAlias'));
    Form.addParameter('x.X_HW_Priority', getValue('certificatePriority'));
    var prvPwd = getValue('certPassword');
    if (prvPwd != '') {
        Form.addParameter('x.X_HW_Password', getValue('certPassword'));
    }
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=' + certificateInfoList[selectIndex].domain +
                   '&RequestFile=html/ssmp/tr069/IpSec.asp');
    DisableApplyCancle(1);
    Form.submit();
}

function CheckDelete(checkedList) {
    for (var i = 0; i < checkedList.length; i++) {
        var certificateInfo = certificateInfoList[checkedList[i]];
        if ((certificateInfo.usage == 'USER_AUTHEN_WEB') || (certificateInfo.usage == 'ONT_AUTHEN_ACS') ||
            (certificateInfo.usage == 'ACS_AUTHEN_ONT')) {
            return false;
        }
        if (certificateInfo.usage == 'ONT_AUTHEN_IPSEC') {
            for (var k = 0; k < usedIpsecCert.length; k++) {
                if (certificateInfo.domain == usedIpsecCert[k]) {
                    return false;
                }
            }
        }
    }
    return true;
}

function OnDeleteButtonClick(TableID)
{
    if (certificateInfoList.length == 0) {
        AlertEx(certificateManageDes['s11035']);
        return;
    }
    if (selectIndex == -1) {
        AlertEx(certificateManageDes['s11036']);
        return;
    }

    var rml = document.getElementsByName(TableName + 'rml');
    var SubmitForm = new webSubmitForm();
    var Count = 0;
    var checkedList = new Array();
    for (var i = 0; i < rml.length; i++) {
        if (rml[i].checked != true) {
            continue;
        }
        checkedList[Count] = i;
        Count++;
        SubmitForm.addParameter(rml[i].value,'');
    }
    if (Count <= 0) {
        AlertEx(certificateManageDes['s11037']);
        return ;
    }

    if (ConfirmEx(certificateManageDes['s11038']) == false) {
        document.getElementById("DeleteButton").disabled = false;
        return;
    }
    if (CheckDelete(checkedList) == false) {
        AlertEx(certificateManageDes['s11039']);
        return ;
    }
    DisableApplyCancle(1);
    SubmitForm.addParameter('x.X_HW_Token', $("#onttoken1").val());
    SubmitForm.setAction('del.cgi?RequestFile=html/ssmp/tr069/IpSec.asp');
    SubmitForm.submit();
}

function CancelConfig() {
    setDisplay('certificateForm', 0);
    setDisplay('applycancel', 0);
    setDisplay('browseFileRow', 0);
    CleanInput();

    DisableApplyCancle(0);

    if (AddFlag == true) {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length > 2) {
            tableRow.deleteRow(tableRow.rows.length - 1);
            selectIndex = -2;
        }
    }
}

function CancelCRLConfig() {
    setDisplay('certificateForm', 0);
    setDisplay('crlBrowseFileRow', 0);
    setDisplay('crlapplycancel', 0);
    CleanCRLInput();

    DisableApplyCancle(0);

    if (AddFlag == true) {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length > 2) {
            tableRow.deleteRow(tableRow.rows.length - 1);
            selectIndex = -2;
        }
    }
}

function fillDataToForm()
{
    var ctrl;
    if (AddFlag == true) {
        ctrl = document.getElementById("certInstNum");
        ctrl.value = '0';
        var usage = getSelectVal('certificateUsage');
        ctrl = document.getElementById("cerType");
        ctrl.value = GetTypeByUsage(usage);
        
    } else {
        ctrl = document.getElementById("certInstNum");
        ctrl.value = selectIndex + 1;
        ctrl = document.getElementById("cerType");
        ctrl.value = certificateInfoList[selectIndex].type;
    }
    ctrl = document.getElementById("certUsage");
    ctrl.value = getSelectVal('certificateUsage');

    ctrl = document.getElementById("certPriority");
    ctrl.value = getValue('certificatePriority');
    ctrl = document.getElementById("certAlias");
    ctrl.value = getValue('certificateAlias');
    
    ctrl = document.getElementById("certprvtPassword");
    ctrl.value = getValue('certPassword');
}

function certificateInfoInstselectRemoveCnt()
{

}

function LoadFrame()
{

}


</script>
</head>

<body class="mainbody pageBg" onload="LoadFrame();"> 
<div id="faultInfo"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("certificateManage", GetDescFormArrayById(certificateManageDes, "s11001"), GetDescFormArrayById(certificateManageDes, "s11002"), false);
</script> 
<div class="title_spread"></div>
<script type="text/javascript">
    var cerListInfo = new Array(new stTableTileInfo("Empty", "align_center width_per5", "DomainBox"),
                                new stTableTileInfo("s11003", "align_center", "certificateThumbprint", false, 16),
                                new stTableTileInfo("s11004", "align_center", "certificateAlias", false, 16),
                                new stTableTileInfo("s11005", "align_center", "uploadTime"),
                                new stTableTileInfo("s11006", "align_center", "certificateUsage"),
                                new stTableTileInfo("s11007", "align_center", "Priority"),
                                null);
    InitTableData();
</script>
<div class="title_spread"></div>
<form id="certificateForm" style="display:none;">

    <table border="0" cellpadding="0" cellspacing="0" border="0" width="100%"> 
        <tr id="certificateThumbprintRow"> 
            <td class="table_title width_per25" BindText='s11022'></td>
            <td class="table_right width_per75">
                <script>document.write("<label id='certificateThumbprint' title='" + certificateManageDes['s11023'] + "'></label>");</script>
            </td> 
        </tr> 
        <tr id="certificateAliasRow"> 
            <td class="table_title width_per25" BindText='s11008'></td>
            <td class="table_right width_per75"> <input type='text' id='certificateAlias'>
                <span class="gray"><script>document.write(certificateManageDes['s11017']);</script></span>
            </td> 
        </tr> 
        <tr id="certificateUsageRow"> 
            <td class="table_title width_per25" BindText='s11009'></td> 
            <td class="table_right width_per75">
                <select size="1" id='certificateUsage' class="width_150px"'>
                <option value="ACS_AUTHEN_ONT" selected BindText='s11018'></option> 
                <option value="ONT_AUTHEN_ACS" BindText='s11019'></option> 
                <option value="USER_AUTHEN_WEB" BindText='s11020'></option>
                <option value="ONT_AUTHEN_IPSEC" BindText='s11021'></option> 
                </select> 
            </td> 
        </tr>
        <tr id="certificatePriorityRow"> 
            <td class="table_title width_per25" BindText='s11010'></td>
            <td class="table_right width_per75"> <input type='text' id='certificatePriority' maxlength='16'>
                <strong style="color:#FF0033">*</strong>
                <span class="gray"><script>document.write(certificateManageDes['s11014']);</script></span>
            </td> 
        </tr>
        <tr id="certPasswordRow"> 
            <td class="table_title width_per25" BindText='s11012'></td>
            <td class="table_right width_per75"> <input type='password' id='certPassword' maxlength='32'>
                <span class="gray"><script>document.write(certificateManageDes['s11025']);</script></span>
            </td> 
        </tr>
        <tr id="cfmCertPasswordRow"> 
            <td class="table_title width_per25" BindText='s11013'></td>
            <td class="table_right width_per75"> <input type='password' id='cfmCertPassword' maxlength='32'>
                <span class="gray"><script>document.write(certificateManageDes['s11025']);</script></span>
            </td> 
        </tr> 

    </table>
</form>

<form action="certManagement.cgi?RequestFile=html/ssmp/reset/reset.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr id="browseFileRow" style="display:none;">
                <td class="table_title width_per25" BindText="s11015"></td>
                <td class="table_right width_per75">
                    <div class="filewrap">
                        <div class="fileupload">
                            <input type="hidden" id="onttoken1"  name="onttoken"    value="<%HW_WEB_GetToken();%>" />
                            <input type="hidden" id="certInstNum"  name="certInstNum" />
                            <input type="hidden" id="cerType"  name="cerType" />
                            <input type="hidden" id="certUsage"  name="certUsage" />
                            <input type="hidden" id="certPriority"  name="certPriority" />
                            <input type="hidden" id="certAlias"  name="certAlias" />
                            <input type="hidden" id="certprvtPassword"  name="certprvtPassword" />
                            <input type="text"   id="f_file_1"    name="f_file_1" autocomplete="off" readonly="readonly" />
                            <input type="file"   id="t_file"    name="browse"      size="1"  onblur="StartFileOpt();" onchange="fchange(this);" />
                            <input type="button" id="btnBrowse" BindText="s11011" />
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</form>
    
<table id="applycancel" width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button"  style="display:none;">
    <tr>
        <td class='width_per30'></td>
        <td class="table_submit">
            <button id="btnApply1" name="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitForm();"><script>document.write(certificateManageDes['s11090']);</script></button>
            <button id="btnCancle1" name="btnCancle1" type="button" class="CancleButtonCss buttonwidth_100px"   onClick="CancelConfig();"><script>document.write(certificateManageDes['s11091']);</script></button> </td>
    </tr>
</table>

<form action="crlManagement.cgi?RequestFile=html/ssmp/reset/reset.asp" method="post" enctype="multipart/form-data" name="crl_fr_uploadImage" id="crl_fr_uploadImage">
    <div>
        <table border="0" csellpadding="0" cellspacing="0" border="0" width="100%">
            <tr id="crlBrowseFileRow" style="display:none;">
                <td class="table_title width_per25" BindText="s11041"></td>
                <td class="table_right width_per75">
                    <div class="filewrap">
                        <div class="fileupload">
                            <input type="hidden" id="onttoken2"  name="onttoken"    value="<%HW_WEB_GetToken();%>" />
                            <input type="text"   id="f_file_1"  name="crltext"  autocomplete="off" readonly="readonly" />
                            <input type="file"   id="t_file"    name="crlBrowse"      size="1"  onblur="StartFileOpt();" onchange="CrlFchange(this);" />
                            <input type="button" id="btnBrowse" BindText="s11011" />
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</form>

<table id="crlapplycancel" width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button"  style="display:none;">
    <tr>
        <td class='width_per30'></td>
        <td class="table_submit">
            <button id="btnApply1" name="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitCRLForm();"><script>document.write(SmartOntdes['smart040']);</script></button>
            <button id="btnCancle1" name="btnCancle1" type="button" class="CancleButtonCss buttonwidth_100px"   onClick="CancelCRLConfig();"><script>document.write(certificateManageDes['s11091']);</script></button> </td>
    </tr>
</table>

<script>
    ParseBindTextByTagName(certificateManageDes, "td",     1);
    ParseBindTextByTagName(certificateManageDes, "div",    1);
    ParseBindTextByTagName(certificateManageDes, "input",  2);
    ParseBindTextByTagName(certificateManageDes, "span", 1);
    ParseBindTextByTagName(certificateManageDes, "option", 1);
</script>

</body>
</html>
