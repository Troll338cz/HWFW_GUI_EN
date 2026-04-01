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
<script language="javascript" src="../common/wan_staticinfo.asp"></script>
<title>Chinese -- Static Route</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
function stDftRoute(domain,autoenable,wandomain) {
    this.domain = domain;
    this.autoenable = autoenable;
    this.wandomain = wandomain;
}
var dftRoutes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Layer3Forwarding,X_HW_AutoDefaultGatewayEnable|DefaultConnectionService,stDftRoute);%>;
var dftRoute = dftRoutes[0];

function loadlanguage() {
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        setObjNoEncodeInnerHtmlValue(b, route_language[b.getAttribute("BindText")]);
    }
}

function filterWan(WanItem) {
    if (!(WanItem.Tr069Flag == '0' && (IsWanHidden(domainTowanname(WanItem.domain)) == false))) {
        return false;
    }
    return true;
}

function LoadFrame() {
    if (typeof(dftRoute) == 'undefined') {
        setCheck('dftIfStr',0);
    } else if (dftRoute.autoenable == '0') {
        setCheck('dftIfStr',0);
        setSelect('DefaultConnectionService',dftRoute.wandomain);
    } else {
        setCheck('dftIfStr',1);
        setSelect('DefaultConnectionService',dftRoute.wandomain);
    }
    
    loadlanguage();
}

function IsIPv4RouteWan(Wan) {
    if (Wan.IPv4Enable == "1" && Wan.Mode =="IP_Routed") {
        return true;
    } 
    return false;
}
function SubmitForm() {
    var Form = new webSubmitForm();
    var selectObj = getElement('DefaultConnectionService');
    var index = 0;

    if (getSelectVal("DefaultConnectionService") == "") {
        AlertEx(route_language['bbsp_alert_wan']);
        return false;
    }

    index = parseInt(selectObj.selectedIndex,10);
    if ( index < 0 ) {
        AlertEx(route_language['bbsp_alert_wan']);
        return false;
    }

    Form.addParameter('x.X_HW_AutoDefaultGatewayEnable',getCheckVal('dftIfStr'));
    Form.addParameter('x.DefaultConnectionService',getSelectVal('DefaultConnectionService'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('set.cgi?x=InternetGatewayDevice.Layer3Forwarding&RequestFile=html/bbsp/route/route_tedata.asp');
    setDisable('btnApply', 1);
    setDisable('cancelValue', 1);
    Form.submit();
}

function CancelConfig() {
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
    <script language="JavaScript" type="text/javascript">
        HWCreatePageHeadInfo("routetitle", GetDescFormArrayById(route_language, "bbsp_mune"), GetDescFormArrayById(route_language, "bbsp_title_prompt"), false);
    </script> 
    <div class="title_spread"></div>
    <form id="DefaultRouteForm" name="DefaultRouteForm">
        <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
            <li id="dftIfStr" RealType="CheckBox" DescRef="bbsp_td_deroute" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_AutoDefaultGatewayEnable" InitValue="Empty" InitValue="Empty"/>
            <li id="DefaultConnectionService" RealType="DropDownList" DescRef="bbsp_td_wanname" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" Elementclass="width_260px restrict_dir_ltr" InitValue="Empty" MaxLength="30"/>
        </table>
        <script>
            var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
            var DefaultRouteFormList = new Array();
            DefaultRouteFormList = HWGetLiIdListByForm("DefaultRouteForm",null);
            HWParsePageControlByID("DefaultRouteForm",TableClass,route_language,null);
        </script>
    </form>
    <table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
        <tr> 
            <td class='width_per25's></td> 
            <td class="table_submit">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
                <button name="btnApply" id="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();"><script>document.write(route_language['bbsp_app']);</script></button>
                <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(route_language['bbsp_cancel']);</script></button>
            </td> 
        </tr> 
    </table> 
    <script>
  	InitWanNameListControl1("DefaultConnectionService", IsIPv4RouteWan, false);
    </script>
</body>
</html>