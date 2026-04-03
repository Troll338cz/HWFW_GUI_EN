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
var collectStatus = "";
var collectPercentage = "";
var IsWebStartCollectFlag = '<%HW_WEB_GetShowProFlag();%>';
var TableName = "collectApInfpInst";
var selctIndex = -1;
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
var initLanguage = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE.STRING);%>';
var languageSet = new Array();
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';


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

function stApDeviceList(domain,DeviceType,ApOnlineFlag,APMacAddr,SerialNumber)
{
    this.domain = domain;
    this.DeviceType = DeviceType;
    this.ApOnlineFlag = ApOnlineFlag;
    this.APMacAddr = APMacAddr;
    this.SerialNumber = SerialNumber;
}
var apDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i},DeviceType|ApOnlineFlag|APMacAddr|SerialNumber,stApDeviceList);%>;

var collectApDeviceList = new Array();
var collectApStatus = new Array();
var apCollectEnable = 0;
var idx = 0;

for (var i = 0; i < apDeviceList.length - 1; i++) {
    if (isBponFlag == 1) {
        collectApDeviceList[i] = apDeviceList[i];
        collectApStatus[i] = 0;
    } else {
        GetApCollectEnable(apDeviceList[i].APMacAddr);
        if (apCollectEnable == 1) {
            collectApDeviceList[idx] = apDeviceList[i];
            collectApStatus[idx] = 0;
            idx++;
        }
    }
}

function dealDataWithFun(str)
{
    if (typeof str === 'string' && str.indexOf('function') === 0) {
        return Function('"use strict";return (' + str + ')')()();
    }
    return str;
}

function GetApCollectStatusByIndex(index)
{
    var infos;
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../common/getApCollectStatus.asp?&1=1",
        data :'APMacAddr=' + collectApDeviceList[index].APMacAddr,
        success : function(data) {
            infos = dealDataWithFun(data);
            collectApStatus[index]  = infos[0];
        }
    });
}

function GetApCollectEnable(mac)
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../common/GetApActionEnable.asp?&1=1",
        data :'APMacAddr=' + mac,
        success : function(data) {
            apCollectEnable = data;
        }
    });
}

function SetDisplayStatus(index)
{
    if (collectApStatus[index] == "0") {
        setDisable('collect',0);
        setDisable('view', 1);
        getElement('CollectInfo').innerHTML = '';
    } else if (collectApStatus[index] == "1") {
        setDisable('collect',1);
        setDisable('view', 1);

        getElement('CollectInfo').innerHTML = '<B><FONT color=red>'+GetLanguageDesc("s1119")+ '</FONT><B>';
    } else if (collectApStatus[index] == "2") {
        setDisable('collect',0);
        setDisable('view', 0);
        getElement('CollectInfo').innerHTML = '<B><FONT color=red>'+GetLanguageDesc("s1120")+ '</FONT><B>';
    }
}

function GetCollectApInfoStatus()
{
    if (selctIndex == -1) {
        return;
    }
    GetApCollectStatusByIndex(selctIndex);
    SetDisplayStatus(selctIndex);
}

function LoadFrame()
{
    GetCollectApInfoStatus();
    setInterval(function() {
        try {
             GetCollectApInfoStatus();
        } catch (e) {
        }
    }, 1000 * 5);

    document.getElementById("faultInfo").style.textAlign = "left";
}

function CheckForm()
{
    return true; 
}

function AddSubmitParam(SubmitForm,type)
{
    setDisable('collect',1);
    SubmitForm.addParameter('APMacAddr', collectApDeviceList[selctIndex].APMacAddr);
    SubmitForm.setAction('apCollectFaultInfo.cgi?RequestFile=html/ssmp/collect/apCollectInfo.asp');
}

function viewFalutInfo()
{
    if (IsSupportPrompt() == true) {
        if (ConfirmEx(GetLanguageDesc("s1121")) == false) {
            return;
        }
    }

    var ua = navigator.userAgent.toLowerCase();	
    if (/iphone|ipad|ipod/.test(ua)) {
        window.open("/html/ssmp/collect/collectInfo_ios.asp");
        setDisable('view', 1);
        return;
    }
    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    Form.addParameter('APMacAddr', collectApDeviceList[selctIndex].APMacAddr);
    Form.setAction('apCollectInfodown.cgi?RequestFile=html/ssmp/collect/apCollectInfo.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();

    setDisable('view', 1);
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
        setDisplay('CollectFaultInfo', 0);
    } else if (index != -1) {
        setDisplay('CollectFaultInfo', 1);
        record = collectApDeviceList[index];
        setCtlDisplay(record);
        GetApCollectStatusByIndex(index);
        SetDisplayStatus(index);
    }
}

function showlistcontrol()
{
    var TableDataInfo = new Array();
    var ColumnNum = 3;
    var ShowButtonFlag = false;
    var Listlen = 0;

    if (collectApDeviceList.length == 0) {
        TableDataInfo[Listlen] = new stApDeviceList();
        TableDataInfo[Listlen].DeviceType = '--';
        TableDataInfo[Listlen].MacAddress = '--';
        TableDataInfo[Listlen].SerialNumber = '--';
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, collectAplistInfo, CollectAPInfoLgeDes, null);
        return;
    } else {
        for (var i = 0; i < collectApDeviceList.length; i++) {
            TableDataInfo[Listlen] = new stApDeviceList();
            if (collectApDeviceList[i].DeviceType == '') {
                TableDataInfo[Listlen].DeviceType = '--';
            } else {
                TableDataInfo[Listlen].DeviceType = collectApDeviceList[i].DeviceType;
            }
            if (collectApDeviceList[i].APMacAddr == '') {
                TableDataInfo[Listlen].MacAddress = '--';
            } else {
                TableDataInfo[Listlen].MacAddress = collectApDeviceList[i].APMacAddr;
            }
            if (collectApDeviceList[i].SerialNumber == '') {
                TableDataInfo[Listlen].SerialNumber = '--';
            } else {
                TableDataInfo[Listlen].SerialNumber = collectApDeviceList[i].SerialNumber;
            }
            Listlen++;
        }
        TableDataInfo.push(null);
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, collectAplistInfo, CollectAPInfoLgeDes, null);
    }
}
</script>
</head>

<body class="mainbody pageBg" onload="LoadFrame();"> 
<div id="faultInfo"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("collectApInfoasp", GetDescFormArrayById(CollectAPInfoLgeDes, "s1101"), GetDescFormArrayById(CollectAPInfoLgeDes, "s1102"), false);
</script> 
<div class="title_spread"></div>
<div class="func_title" BindText="s1101"></div> 
<script language="JavaScript" type="text/javascript">
    var collectAplistInfo = new Array(new stTableTileInfo("s1105","align_center","DeviceType"),
                                      new stTableTileInfo("s1106","align_center","MacAddress"),
                                      new stTableTileInfo("s1107","align_center","SerialNumber"),
                                      null);
    showlistcontrol();
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="margin-top:15;display:none"> 
</table> 
<form id="CollectFaultInfo" style="display:none"> 
    <table border="0" cellpadding="0" cellspacing="1" width="100%">
        <li id="DeviceType" RealType="HtmlText" DescRef="s1108" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FALSE" InitValue="Empty" ClickFuncApp="Empty"/>
        <li id="MacAddress" RealType="HtmlText" DescRef="s1109" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FALSE" InitValue="Empty" ClickFuncApp="Empty"/>
        <li id="SerialNumber" RealType="HtmlText" DescRef="s1110" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FALSE" InitValue="Empty" ClickFuncApp="Empty"/>
        <script>
            var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
            CollectFaultFormList = HWGetLiIdListByForm("CollectFaultInfo",null);
            HWParsePageControlByID("CollectFaultInfo", TableClass, CollectAPInfoLgeDes, null);
        </script> 

    </table>
    <div class="func_spread"></div>
    <table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
        <td>
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input class="ApplyButtoncss buttonwidth_150px pix_70_120" name="button" id="collect" type='button' onClick='Submit()' BindText="s1104" />
        <input class="ApplyButtoncss buttonwidth_150px pix_90_130" name="button" id="view" type='button' onClick='viewFalutInfo()' BindText="s1114" /> 
        </td> 
    </tr> 
    </table> 
    <div class="func_spread"></div>
    <div id="CollectInfo"></div> 
</form> 

<script>
function GetLanguageDesc(Name)
{
    return CollectAPInfoLgeDes[Name];
}

ParseBindTextByTagName(CollectAPInfoLgeDes, "td",     1);
ParseBindTextByTagName(CollectAPInfoLgeDes, "div",    1);
ParseBindTextByTagName(CollectAPInfoLgeDes, "input",  2);
</script>

</body>
</html>
