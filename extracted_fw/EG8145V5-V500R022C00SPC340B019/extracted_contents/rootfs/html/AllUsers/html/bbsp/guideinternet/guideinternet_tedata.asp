<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_servicelist.js);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_staticinfo.asp);%>"></script>
<style type="text/css">
.nofloat {
    float: none;
}

.contentItem {
    *text-align: left;
}

.contenbox {
    *width: 300px;
    *text-align: left;
    *padding-left: 10px;
}

.txt_Username {
    *padding-left: 10px;
}

.textboxbg {
    *margin: auto 0px;
}

#btnpre {
    margin-left: -90px;
}
#guideskip {
    text-decoration: none;
    color: #666666;
    white-space: nowrap;
    *display: block;
    *margin-top: -26px;
    *margin-left: 230px;
    *text-decoration: none;
}
a span {
    font-size: 16px;
    margin-left: 10px;
}
table {
    border: 0px;
    cellspacing: 0;
    cellpadding: 0;
}
.acctablehead {
    font-size: 16px;
    color: #666666;
    font-weight: bold;
}

.textbox {
    font-size: 16px;
    width: 279px;
    margin-left: 3px;
    background: none;
    border: 1px solid #ccc;
    padding: 0 2px;
}

.accountbox {
    width: 155px;
    margin:0 3px 0 13px;
}

.showpwd {
    margin: 10px 10px;
}

</style>
</head>
<script language="javascript">
var inter_index = -1;
var IsSupportWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var productType = '<%HW_WEB_GetProductType();%>';
var pwdChangeFlag = false;
var isTedata = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>";
var Wan = new Array();
var g_CurrentDomain = '';
var WanList = GetWanList();
var typeWord = '<%HW_WEB_GetTypeWord();%>';

for (var i = 0, j = 0; WanList.length >= 1 && j < WanList.length; i++, j++) {
    if (WanList[i].Tr069Flag == "1") {
        i--;
        continue;
    }
    Wan[i] = WanList[j];
}

function CheckForm() {
    var Username = document.getElementById('AccountValue').value;
    var Password = document.getElementById('PwdValue').value;
    if (Username.length > 15) {
        AlertEx(Languages['UserNameTedata1']);
        return false;
    } else if (!isNum(Username)) {
        AlertEx(Languages['UserNameTedata2']);
        return false; 
    }

    if ((Password != '') && (isValidAscii(Password) != '')) {  
        AlertEx(guideinternet_language['bbsp_pwdh'] + Languages['Hasvalidch'] + isValidAscii(Password) + '".');
        return false;
    }
    return true;
}

function ShowNoneWan() {
    setText('AccountValue', "");
    setText('PwdValue', "");

    setDisable('AccountValue', 1);
    setDisable('PwdValue', 1);

    return;
}

function ParseUsernameFortedata(userName) {
    var viewusrnm = '';
    var temp;
    var viewUserName = userName;

    var postFix = "@tedata.net.eg";

    if (userName.indexOf(postFix) >= 0) {
        if(userName.substring(userName.length - postFix.length) == postFix) {
            viewUserName =  userName.substring(0, userName.length - postFix.length);
        }
    }
    return viewUserName;
}

function IsModifyWan(index)
{
    if ((Wan[index].IPv4AddressMode.toUpperCase() == "PPPOE") &&
        ((Wan[index].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) ||
        ((Wan[index].ServiceList.toString().toUpperCase().indexOf("TR069") >= 0) && (typeWord == "BRIDGE")))) {
        return true;
    }
    return false;
}

function filterChooseWan() {
    var i = 0;
    var DisablePppInput = 1;

    for (i = 0; i < Wan.length; i++) {
        if (IsModifyWan(i) == false) {
            continue;
        }

        if ((Wan[i].Mode != "IP_Routed") && (Wan[i].Mode != "IP_Bridged")) {
            continue;
        }
        
        g_CurrentDomain = Wan[i].domain;
        inter_index = i;
        var temUsername = ParseUsernameFortedata(Wan[i].Username);
        setText('AccountValue', temUsername);
        setText('PwdValue', "********");
        setDisable('AccountValue', 0);
        setDisable('PwdValue', 0);
        DisablePppInput = 0;
        break;
    }

    return DisablePppInput;
}

function LoadFrame() {
    ShowNoneWan();

    if (Wan.length == 0) {
        return;
    }

    filterChooseWan();
    window.parent.adjustParentHeight();

    return;
}

function SubmitPre() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
        }
    });
    window.parent.location="../../../index.asp";
}

function WanPageTurn() {
    var tokenValue = getValue("onttoken");
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data: "pageTurn=" + "1" + "&x.X_HW_Token=" + tokenValue,
        url : "SetPageTurnStatus.cgi?1=1&RequestFile=guideinternet.asp",
        success : function() {
            window.parent.location="../../../index.asp";
        }
    });
}

function directionweb(val) {
    if (IsSupportWifi == '1') {
        val.id = "guidewlanconfig";
        val.name = "/html/amp/wlanbasic/guidewificfg.asp";
        window.parent.onchangestep(val); 
    } else {
        val.id = "guidecfgdone";
        val.name = "/html/ssmp/cfgguide/userguidecfgdone.asp";
        window.parent.onchangestep(val);
    }
}

function GetWanDomains()
{
    var domains=new Array();

    for (var i=1; i<=Wan.length; i++) {
        if ((Wan[i-1].ServiceList.toString().toUpperCase().indexOf("INTERNET") < 0) || (Wan[i-1].IPv4AddressMode.toUpperCase() != "PPPOE")) {
            continue;
        }
        domains.push("x" + i + "=" + Wan[i-1].domain);
    }
    return domains;
}

function GetPPPoeDomains() {
    var domains=new Array();
    for (var i=1; i<=Wan.length; i++) {
        if (IsModifyWan(i - 1)) {
            domains.push("x" + i + "=" + Wan[i-1].domain);
            if (productType != '2') {
                break;
            }
        }
    }
    return domains;
}

function GetWanParas() {
    var paras = new Array();
    var account = getValue('AccountValue');
    var pwd = getValue('PwdValue');

    for (var i=1; i<=Wan.length; i++) {
        if ((Wan[i-1].ServiceList.toString().toUpperCase().indexOf("INTERNET") < 0) || (Wan[i-1].IPv4AddressMode.toUpperCase() != "PPPOE")) {
            continue;
        }

        paras.push(new stSpecParaArray("x" + i + ".Username",account, 0));
        paras.push(new stSpecParaArray("x" + i + ".Password",pwd, 0));
    }
    return paras;
}

function GetPPPoeParas() {
    var paras = new Array();
    var account = getValue('AccountValue') + '@tedata.net.eg';
    var pwd = getValue('PwdValue');

    if (inter_index == -1) {
        return paras;
    }

    if (pwdChangeFlag == false) {
        pwd = Wan[inter_index].Password;
    } else if(getElById("showPwd").checked == true) {
        pwd = getValue('ShowPwdValue');
    }

    for (var i = 1; i <= Wan.length; i++) {
        if (IsModifyWan(i - 1)) {
            paras.push(new stSpecParaArray("x" + i + ".Username",account, 0));
            paras.push(new stSpecParaArray("x" + i + ".Password",pwd, 0));
            if (productType != '2') {
                break;
            }
        }
    }
    return paras;
}

function SubmitNext(val) {
    var domains = GetPPPoeDomains();
    var paras = GetPPPoeParas();

    if (false == CheckForm()) {
        return false;
    }

    if (inter_index != -1) {
        var guideConfigParaList = new Array(new stSpecParaArray("x.Username",getValue('AccountValue'), 0),
                                      new stSpecParaArray("x.Password",getValue('PwdValue'), 0));

        var Parameter = {}; 
        Parameter.OldValueList = null;
        Parameter.FormLiList = null;
        Parameter.UnUseForm = true;
        Parameter.asynflag = false;
        Parameter.SpecParaPair = paras;
        var ConfigUrl = "setajax.cgi?" + domains.join("&") + '&RequestFile=/html/bbsp/guideinternet/guideinternet.asp';
        var tokenvalue = getValue('onttoken');
        HWSetAction("ajax", ConfigUrl, Parameter, tokenvalue);
    }
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
        }
    });
    directionweb(val);
}

function onskip(val) {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
        }
    });
    directionweb(val);
}

function ShowPasswd() {
    var wanPwd = "";
    var showWanPwd = "";

    if (getElById("showPwd").checked == true) {
        wanPwd = getValue("PwdValue");
        getElById("ShowPwdValue").value = wanPwd;
        setDisplay("PwdValue", 0);
        setDisplay("ShowPwdValue", 1);
    } else {
        showWanPwd = getValue("ShowPwdValue");
        getElById("PwdValue").value = showWanPwd;
        setDisplay("PwdValue", 1);
        setDisplay("ShowPwdValue", 0);
    }
}

function PwdChange() {
    pwdChangeFlag = true;
}

function OnFocus() {
    if (pwdChangeFlag == false) {
        setText("PwdValue", "");
        setText("ShowPwdValue", "");
    }
}

function OnBlur() {
    if (pwdChangeFlag == false) {
        setText('PwdValue', "********");
        setText("ShowPwdValue", "********");
    }
}

</script>
<body onload="LoadFrame();" style="background-color: #ffffff; overflow-x:hidden; overflow-y:hidden;" scroll="no">
<div align="center">
    <table width="100%">
        <tr>
            <td height="35px"></td>
        </tr>
        <tr align="center"></tr>
        <td class="acctablehead" BindText="bbsp_title_dtedata"></td>
    </table>

<div id="userinfo">
    <div id="username" class="contentItem nofloat">
        <div class="labelBox" style="margin-left:142px;"><span id="user" BindText="bbsp_user_dtedata"></span></div>
        <div class="contenbox nofloat">
            <input type="text" disabled="disabled" id="AccountValue" name="AccountValue" style="line-height:34px;height:34px;" class="textbox accountbox" maxlength="64"/>
            <span style="color:#666;">@tedata.net.eg</span>
        </div>
    </div>
    <div id="userpwd" class="contentItem nofloat">
        <div class="labelBox" style="margin-left: 155px"> <span id="userpassword" BindText="bbsp_pwd_dtedata"></span></div>
        <div class="contenbox nofloat">
            <input type="password" autocomplete="off" id="PwdValue" name="PwdValue" class="textbox" style="font-size:14px;line-height:34px;height:34px;" maxlength="64" onFocus="OnFocus();" onChange="PwdChange();" onBlur="OnBlur();"/>
            <input type="text" autocomplete="off" id="ShowPwdValue" name="ShowPwdValue" class="textbox" style="display:none; font-size:14px; line-height:34px;" maxlength="64" onFocus="OnFocus();" onChange="PwdChange();" onBlur="OnBlur();"/>
        </div>
    </div>
    <script>
        if (isTedata == 1) {
            document.write('<div class="nofloat showpwd"><span style="color:#666; font-size: 14px; margin:0 38px 0 -286px;">' + guideinternet_language["bbsp_showpwd"] + '</span><input id="showPwd" type="checkbox" onClick="ShowPasswd()"></div>');
            document.write('<div class="nofloat"><a style="font-size:14px; color:#F00; cursor:pointer; margin-left: -10px;"  onclick="WanPageTurn()">' + guideinternet_language["bbsp_advancesetup"] + '</a></div>');
        }
    </script>
    <div class="contentItem btnGuideRow nofloat">
        <div class="labelBox"></div>
        <div class="contenbox nofloat">
            <input type="button" id="btnpre" name="/html/amp/wlanbasic/guidewificfg.asp"     class="CancleButtonCss buttonwidth_100px" onClick="SubmitPre(this);" BindText="bbsp_exit"/>
            <input type="button" id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitNext(this);" BindText="bbsp_next"/>
            <a id="guideskip" name="/html/amp/wlanbasic/guidewificfg.asp" href="#" onClick="onskip(this);">
                <span BindText="bbsp_skip"></span>
            </a>
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        </div>
    </div>
</div>
    <script>
        ParseBindTextByTagName(guideinternet_language, "span",  1);
        ParseBindTextByTagName(guideinternet_language, "td",    1);
        ParseBindTextByTagName(guideinternet_language, "input", 2);
    </script>
</div>
</body>
</html>
