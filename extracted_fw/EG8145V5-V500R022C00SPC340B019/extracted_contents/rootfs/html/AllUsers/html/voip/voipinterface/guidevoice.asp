<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="format-detection" content="telephone=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>VOIP Interface</title>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="javascript" src="../../bbsp/common/wandns.asp"></script>
<script language="javascript" src="../common/voip_disableallelement.asp"></script>

<style>
.interfacetextclass {
    width:300px;
    height:50px;
    color:black;
}

.TextBox {
    width:155px;
}

.tx_input {
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    border: 1px solid #CECACA;
    vertical-align: middle;
    font-size: 16px;
    height: 32px;
    width: 228px;
    padding-left: 5px;
    margin-left: 0px;
    line-height: 32px;
}
.gray {
    color: #767676;
};

.lineclass {
    width:200px;
}

.wordclass {
    word-wrap:break-all;
    word-break: break-all;
}

.labelBoxVoice {
    float:left;
    font-size:16px;
    font-family:"微软雅黑";
    color: #666666;
    height: 34px;
    line-height:34px;
    width: 200px;
    text-align:right;
    position:relative;
}

.acctableheadVoice {
    font-size:15px;
    color:#666666;
    font-weight:bold;
}

</style>

<script language="JavaScript" type="text/javascript"> 
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var selctIndex = -1;
var CfgMode = '<%HW_WEB_GetCfgMode();%>';

var DethMaxis = 0;
if (CfgMode.toUpperCase() == 'DETHMAXIS') {
    DethMaxis = 1;
}

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';

var vagIndex = 1;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function GetVagIndexByInst(vagInst)
{
    for (var i = 0; i < AllProfile.length-1; i++) {
        if (AllProfile[i].profileid == vagInst) {
            return i;
        }
    }
    return 0;
}

function stProfile(Domain, Region)
{
    this.Domain = Domain;
    var temp = Domain.split('.');
    this.profileid = temp[5];
}

var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}, Region, stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);

var maxvagnum = 1;

var ProductType = '<%HW_WEB_GetProductType();%>';

function LoadFrame()
{
    var j = 0;
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = sipinterface[b.getAttribute("BindText")];
    }
}

var g_Index = -1;

function vspaisValidCfgStr(cfgName, val, len)
{
    if (isValidAscii(val) != '') {  
        AlertEx(cfgName + sipinterface['vspa_hasvalidch'] + isValidAscii(val) + sipinterface['vspa_end']);
        return false;
    }
    if (val.length > len) {
        AlertEx(cfgName + sipinterface['vspa_cantexceed']  + len  + sipinterface['vspa_characters']);
        return false;
    }
}

function stLine(Domain, DirectoryNumber, Enable)
{
    this.Domain = Domain;
    if (DirectoryNumber != null) {
        this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'");
    } else {
        this.DirectoryNumber = DirectoryNumber;
    }

    if (Enable.toLowerCase() == 'enabled') {
        this.Enable = 1;
    } else {
        this.Enable = 0;
    }

    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}, DirectoryNumber|Enable, stLine);%>;
var LineList = new Array(new Array(),new Array(),new Array(),new Array());

for (var i = 0; i < AllLine.length-1; i++) {
    var temp = AllLine[i].Domain.split('.');
    var Vagindex = GetVagIndexByInst(temp[5]);
    if (Vagindex != 0) {
        continue;
    }

    LineList[Vagindex].push(AllLine[i]);
}

function stAuth(Domain, AuthUserName, AuthPassword)
{
    this.Domain = Domain;
    if (AuthUserName != null) {
        this.AuthUserName = AuthUserName.toString().replace(/&apos;/g,"\'");
    } else {
        this.AuthUserName = AuthUserName;
    }

    this.AuthPassword = AuthPassword;
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP, AuthUserName|AuthPassword, stAuth);%>;
var AuthList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllAuth.length-1; i++) {
    var temp = AllAuth[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    if (index != 0) {
        continue;
    }
    AuthList[index].push(AllAuth[i]);

    if (i == 0) {
        setCheck('box_phone1Enable', AllLine[i].Enable);
        setText('txt_phoneuserID1', AllLine[i].DirectoryNumber);
        setText('txt_phoneuser1', AllAuth[i].AuthUserName);
        setText('txt_phonepwd1', AllAuth[i].AuthPassword);
    }
    if (i == 1) {
        setCheck('box_phone2Enable', AllLine[i].Enable);
        setText('txt_phoneuserID2', AllLine[i].DirectoryNumber);
        setText('txt_phoneuser2', AllAuth[i].AuthUserName);
        setText('txt_phonepwd2', AllAuth[i].AuthPassword);
    }
}


function SubmitBasicPara()
{
    var lineNum = LineList[vagIndex].length;
    if (lineNum == 0) {
        return;
    }

    var guideConfigParaList = new Array();
    var Parameter = {};
    Parameter.OldValueList = null;
    Parameter.FormLiList = null;
    Parameter.UnUseForm = true;
    Parameter.asynflag = false;
    Parameter.SpecParaPair = guideConfigParaList;

    var actionUrl;

    var urlParm1 = "";
    var urlParm2 = "";

    actionUrl = 'setajax.cgi?';
    actionUrlTail = '&RequestFile=html/ssmp/accoutcfg/guideaccountcfg.asp';

    for (var i = 0; i < LineList[vagIndex].length; i++) {
        var temp = LineList[vagIndex][i].Domain.split('.');
        index = temp[7];

        if (index == 1) {
            urlParm1 = 'Add_b=' + LineList[vagIndex][index-1].Domain + '&c=' + LineList[vagIndex][index-1].Domain + '.SIP';
        }
        if (index == 2) {
            if (LineList[vagIndex].length == 1) {
                urlParm2 = 'Add_f=' + LineList[vagIndex][0].Domain + '&d=' + LineList[vagIndex][0].Domain + '.SIP';
            } else {
                urlParm2 = 'Add_f=' + LineList[vagIndex][index-1].Domain + '&d=' + LineList[vagIndex][index-1].Domain + '.SIP';
            }
        }
    }

    if (urlParm1 != "") {
        actionUrl = actionUrl + urlParm1;
        var enableCheckBox = 'Disabled';
        if (getCheckVal('box_phone1Enable') == 1) {
            enableCheckBox = 'Enabled';
        }
        guideConfigParaList.push(new stSpecParaArray("Add_b.Enable", enableCheckBox, 0));
        guideConfigParaList.push(new stSpecParaArray("Add_b.DirectoryNumber", getValue('txt_phoneuserID1'), 0));
        guideConfigParaList.push(new stSpecParaArray("c.AuthUserName", getValue('txt_phoneuser1'), 0));
        var strVar1 = getValue('txt_phonepwd1');
        if (strVar1 != '****************************************************************') {
            guideConfigParaList.push(new stSpecParaArray("c.AuthPassword", getValue('txt_phonepwd1'), 0));
        }
    }
    if (urlParm2 != "") {
        if (urlParm1 == "") {
            actionUrl = actionUrl + urlParm2;
        } else {
            actionUrl = actionUrl + '&' + urlParm2;
        }
        var enableCheckBox = 'Disabled';
        if (getCheckVal('box_phone2Enable') == 1) {
            enableCheckBox = 'Enabled';
        }
        guideConfigParaList.push(new stSpecParaArray("Add_f.Enable", enableCheckBox, 0));
        guideConfigParaList.push(new stSpecParaArray("Add_f.DirectoryNumber", getValue('txt_phoneuserID2'), 0));
        guideConfigParaList.push(new stSpecParaArray("d.AuthUserName", getValue('txt_phoneuser2'), 0));
        var strVar2 = getValue('txt_phonepwd2');
        if (strVar2 != '****************************************************************') {
            guideConfigParaList.push(new stSpecParaArray("d.AuthPassword", getValue('txt_phonepwd2'), 0));
        }
    }

    if (urlParm1 == "" && urlParm2 == "") {
        actionUrl = "";
    } else {
        actionUrl = actionUrl + actionUrlTail;
    }

    HWSetAction("ajax", actionUrl, Parameter, getValue('onttoken'));
}



function SubmitBasicParaAndNext(val)
{
    SubmitBasicPara();

    val.id = "guidewlanconfig";
    val.name = "/html/amp/wlanbasic/guidewificfg.asp";

    window.parent.onchangestep(val);
}

var g_Index = -1;

function CheckParaForm()
{
    var inSipAuthUserName;
    var inLen = 0;

    if (removeSpaceTrim(getValue('txt_phoneuserID1')) != '') {
        if (vspaisValidCfgStr(sipinterface['vspa_theregister'],getValue('txt_phoneuserID1'),64) == false) {
            return false;
        }
        if (removeSpaceTrim(getValue('txt_phoneuser1')) != '') {
            if (vspaisValidCfgStr(sipinterface['vspa_theauthname'],getValue('txt_phoneuser1'),64) == false) {
                return false;
            }
        }
        
        if (removeSpaceTrim(getValue('txt_phonepwd1')) != '') {
            if (vspaisValidCfgStr(sipinterface['vspa_thepassword'],getValue('txt_phonepwd1'),64) == false) {
                return false;
            }
        }
     }

     if (removeSpaceTrim(getValue('txt_phoneuserID2')) != '') {
        if (vspaisValidCfgStr(sipinterface['vspa_theregister'],getValue('txt_phoneuserID2'),64) == false) {
            return false;
        }
        if (removeSpaceTrim(getValue('txt_phoneuser2')) != '') {
            if (vspaisValidCfgStr(sipinterface['vspa_theauthname'],getValue('txt_phoneuser2'),64) == false) {
                return false;
            }
        }
        
        if (removeSpaceTrim(getValue('txt_phonepwd2')) != '') {
            if (vspaisValidCfgStr(sipinterface['vspa_thepassword'],getValue('txt_phonepwd2'),64) == false) {
                return false;
            }
        }
     }

     return true;
}

function stUserRepeatCheck(Domain, UserRepeatCheck)
{
    this.Domain = Domain;
    this.UserRepeatCheck = UserRepeatCheck;
}
var UserRepeatCheckFlag = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.X_HW_InnerParameters,UserRepeatCheck,stUserRepeatCheck);%>;

function isEmpty(obj)
{
    if (typeof obj == "undefined" || obj == null || obj == "") {
        return true;
    } else {
        return false;
    }
}


function AddConfigFlag()
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
            ;
        }
    }); 
}

function guide_pre(obj)
{
    AddConfigFlag();
    window.parent.onchangestep(obj);
}

function guide_skip(obj)
{
    window.parent.onchangestep(obj);
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();"  style="background-color: #ffffff;margin-top: 35px;">

<div>
<table>
    <tr>
        <td></td>
        <td colspan="2" class="acctableheadVoice" align="left">Please enter the Username and Password. If the Username/Password are unknown, please contact your ISP.</td>
    </tr>
</table>
</div>
<br>
<div align="center"> 
<table align="center" border="0" cellpadding="5" cellspacing="1">
    <tr></tr>
    <tr id="tr_phone1enable">
        <td class="labelBoxVoice" id="Phone1Enable">Phone1 Enable:</td>
        <td>
            <input id="box_phone1Enable" type="checkbox" realtype="CheckBox" class="CheckBox" bindfield="box_phone1Enable">
        </td>
    </tr>
    <tr id="tr_phoneuserID1" style=""> 
        <td class="labelBoxVoice" id='tdPhoneUserID1'>Phone1 Number/User ID:</td>
        <td>
            <input type="text" name="txt_phoneuserID1" id="txt_phoneuserID1" class="tx_input" maxlength="64">
        </td>
    </tr>
    <tr id="tr_phoneuser1" style=""> 
        <td class="labelBoxVoice" id='tdPhoneUser1'>User Name:</td>
        <td>
            <input type="text" name="txt_phoneuser1" id="txt_phoneuser1" class="tx_input" maxlength="64">
        </td>
    </tr>
    <tr id="tr_phonepwd1">
    <td class="labelBoxVoice" id='tdPhonePwd1'>Password:</td>
    <td>
        <input type="password" autocomplete="off" id="txt_phonepwd1" title="0-64" class="tx_input" realtype="TextBox" bindfield="txt_phonepwd1" maxlength="64">
        <br>
        <br>
    </td>
    </tr>

    <tr id="tr_phone2enable">
        <td class="labelBoxVoice" id="Phone2Enable">Phone2 Enable:</td>
        <td>
            <input id="box_phone2Enable" type="checkbox" realtype="CheckBox" class="CheckBox" bindfield="box_phone2Enable">
        </td>
    </tr>
    <tr id="tr_phoneuserID2" style=""> 
        <td class="labelBoxVoice" id='tdPhoneUserID2'>Phone2 Number/User ID:</td>
        <td>
            <input type="text" name="txt_phoneuserID2" id="txt_phoneuserID2" class="tx_input" maxlength="64">
        </td>
    </tr>
    <tr id="tr_phoneuser2" style=""> 
        <td class="labelBoxVoice" id='tdPhoneUser2'>User Name:</td>
        <td>
            <input type="text" name="txt_phoneuser2" id="txt_phoneuser2" class="tx_input" maxlength="64">
        </td>
    </tr>
    <tr id="tr_phonepwd2">
    <td class="labelBoxVoice" id='tdPhonePwd2'>Password:</td>
    <td>
        <input type="password" autocomplete="off" id="txt_phonepwd2" title="0-64" class="tx_input" realtype="TextBox" bindfield="txt_phonepwd2" maxlength="64">
    </td>
    </tr>

</table>
</div>


<script language="JavaScript" type="text/javascript">
function GetVAGPara(vagInsId)
{
    var lineNum = LineList[vagInsId].length;
    if (lineNum == 0) {
        setDisable('box_phone1Enable', 1);
        setDisable('txt_phoneuserID1', 1);
        setDisable('txt_phoneuser1', 1);
        setDisable('txt_phonepwd1', 1);
        setDisable('box_phone2Enable', 1);
        setDisable('txt_phoneuserID2', 1);
        setDisable('txt_phoneuser2', 1);
        setDisable('txt_phonepwd2', 1);

        return;
    } else {
        for (var i = 0; i < lineNum; i++) {
            var temp = LineList[vagInsId][i].Domain.split('.');
            index = temp[7];

            if (index == 1) {
                if (lineNum == 1) {
                    setDisable('box_phone2Enable', 1);
                    setDisable('txt_phoneuserID2', 1);
                    setDisable('txt_phoneuser2', 1);
                    setDisable('txt_phonepwd2', 1);
                }

                setCheck('box_phone1Enable', LineList[vagInsId][index-1].Enable);
                setText('txt_phoneuserID1', LineList[vagInsId][index-1].DirectoryNumber);
                setText('txt_phoneuser1', AuthList[vagInsId][index-1].AuthUserName);
                setText('txt_phonepwd1', "****************************************************************");
            }
            if (index == 2) {
                if (lineNum == 1) {
                    setDisable('box_phone1Enable', 1);
                    setDisable('txt_phoneuserID1', 1);
                    setDisable('txt_phoneuser1', 1);
                    setDisable('txt_phonepwd1', 1);

                    setCheck('box_phone2Enable', LineList[vagInsId][0].Enable);
                    setText('txt_phoneuserID2',LineList[vagInsId][0].DirectoryNumber);
                    setText('txt_phoneuser2', AuthList[vagInsId][0].AuthUserName);
                    setText('txt_phonepwd2', "****************************************************************");
                } else {
                    setCheck('box_phone2Enable', LineList[vagInsId][index-1].Enable);
                    setText('txt_phoneuserID2',LineList[vagInsId][index-1].DirectoryNumber);
                    setText('txt_phoneuser2', AuthList[vagInsId][index-1].AuthUserName);
                    setText('txt_phonepwd2', "****************************************************************");
                }
            }
        }
    }
}

for (var index = 0; index < maxvagnum; index++) {
    GetVAGPara(index);
}

</script>

<div align="center">
<div id="btnguidevoice" border="0" cellpadding="0" cellspacing="0" class="contentItem nofloat" style="">
<div class="labelBoxVoice"></div>
<div class="contenbox nofloat">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"/>

<input type="button" id="guidepppoeconfig" class="CancleButtonCss buttonwidth_100px" name="/html/bbsp/guideinternet/guideinternet.asp" style="margin-left:0px;" onClick="guide_pre(this);"/>
<script>
    setText('guidepppoeconfig', "Previous");
</script>
</input>

<input type="button" id="guidevoicenext" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitBasicParaAndNext(this);"/>
    <script>setText('guidevoicenext', "Next");</script>
</input>

<a id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" href="#"  style="display:block; margin-top: -26px;margin-left: 300px;font-size:16px;text-decoration: none;color: #666666;" onclick="guide_skip(this);">
<span >Skip</span>
</a>
</div>
</div>
</div>
</div>


</body>
</html>
