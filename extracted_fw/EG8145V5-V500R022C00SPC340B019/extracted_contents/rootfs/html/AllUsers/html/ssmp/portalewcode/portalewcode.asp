<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function loadlanguage()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i < all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = portalewcode_language[b.getAttribute("BindText")];
    }
}

var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var portalEwcode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.InformEwcodeCtrl.Ewcode);%>';
var isTJCU = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TJCU);%>';
var nodePath = "InternetGatewayDevice.X_HW_DataModel.InformEwcodeCtrl";
var nodeName = "Ewcode";
if ((isTJCU == 1) || (CfgMode == 'XJCU')) {
    portalEwcode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Ewcode.Enable);%>';
    nodePath = "InternetGatewayDevice.Ewcode";
    nodeName = "Enable";
}

function LoadFrame()
{
    setCheck('portalEwcode',portalEwcode);
    loadlanguage();
}

function OnPortalEwcodeClick()
{

}

function SubmitForm()
{
    var Form = new webSubmitForm();
    var para = "x." + nodeName;
    var paraPath = "set.cgi?x=" + nodePath + "&RequestFile=html/ssmp/portalewcode/portalewcode.asp";
    Form.addParameter(para, getCheckVal('portalEwcode'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction(paraPath);
    setDisable('btnApply', 1);
    setDisable('cancelValue', 1);
    Form.submit();
}

function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div id="Configure"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("portalEwcodetitle", GetDescFormArrayById(portalewcode_language, "portalewcode_mune"), GetDescFormArrayById(portalewcode_language, "portalewcode_title"), false);
</script>
<div class="title_spread"></div>
<form id="portalEwcodeForm" name="portalEwcodeForm">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li id="portalEwcode"  RealType="CheckBox" DescRef="portalewcode_config" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Ewcode" InitValue="Empty" ClickFuncApp="onclick=OnPortalEwcodeClick"/>
    </table>
    <script>
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        var FirewallFormList = new Array();
        FirewallFormList = HWGetLiIdListByForm("portalEwcodeForm",null);
        HWParsePageControlByID("portalEwcodeForm",TableClass,portalewcode_language,null);
    </script>
    <table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
        <tr> 
        <td class='width_per25'></td> 
        <td class="table_submit">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
            <button name="btnApply" id="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();"><script>document.write(portalewcode_language['portalewcode_apply']);</script></button>
            <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(portalewcode_language['portalewcode_cancel']);</script></button> </td> 
        </tr>
    </table>
</form>
</div> 
</body>
</html>
