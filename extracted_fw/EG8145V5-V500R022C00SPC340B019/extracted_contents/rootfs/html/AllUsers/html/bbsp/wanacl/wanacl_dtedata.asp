<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<title>Wan Access Configuration</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_staticinfo.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/wanaccesslist.asp"></script>    
<script>
    var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';

    var CurrentWanDomain = "";

    var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();

    var MaxSrcIpNum = '<%HW_WEB_GetSPEC(BBSP_SPEC_SEC_SIPWHITENUM.UINT32);%>';

    var CurSrcIpList;

    var appName = navigator.appName;

    var SingleFlag = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';

    var wanaclFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PORT_ACL);%>';

    var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
    var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
    var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';

    var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
    var IsPtVdfAP = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_VDFPTAP);%>";

    var IsViettel8045A2Flag='<%HW_WEB_GetFeatureSupport(FT_SSMP_VIETTEL_8045MODE);%>';

    function IsTedata()
    {
        return (('TEDATA' == CfgModeWord.toUpperCase()) || ('TEDATA2' == CfgModeWord.toUpperCase()))? true : false;
    }

    function IsNeedAddSafeDesForBelTelecom(){
        if (1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0) {
            return true;
        }

        return false;
    }

    function GetSrcIpList(srcip)
    {
        var iplist = srcip.split(",");
        var tmplist = new Array();
        var index = 0;

        for (var i = 0; i < iplist.length; i++) {
            if (iplist[i] != "") {
                tmplist[index++] = iplist[i];
            }
        }

        return tmplist;
    }

    function CreateWanAclList()
    {
        var WanAclList = GetWanAccessList();
        var HtmlCode = "";
        var DataGrid = getElById("DataGrid");
        var RecordCount = WanAclList.length;
        var i = 0;

        if (FltsecLevel != 'CUSTOM') {
            RecordCount = 0;
        }

        if (RecordCount == 0) {
            HtmlCode += '<TR id="record_no" class="tabal_01 align_center " onclick="selectLine(this.id);">';
            HtmlCode += '<TD >--</TD>';
            HtmlCode += '<TD >--</TD>';
            HtmlCode += '<TD >--</TD>';
            HtmlCode += '<TD >--</TD>';
            HtmlCode += '<TD >--</TD>';
            HtmlCode += '</TR>';
            return HtmlCode;
        }

        for (i = 0; i < RecordCount; i++) {
            HtmlCode += '<TR id="record_' + i + '" class="tabal_01 align_center "  onclick="selectLine(this.id);">';
            HtmlCode += '<TD>' + '<input type="checkbox" name="rml" id = \"Recordrml_'+i+'\"'  + ' value=\"' + WanAclList[i].domain  + '\" >' + '</TD>';
            HtmlCode += '<TD class=\"restrict_dir_ltr\" id = \"RecordWanName'+i+'\">' + GetWanFullName(WanAclList[i].WanName) + '</TD>';
            HtmlCode += '<TD id = \"RecordProtocol'+i+'\">' + WanAclList[i].Protocol.toUpperCase() + '</TD>';

            var list = GetSrcIpList(WanAclList[i].SrcIPPrefix);
            var listshow = "";
            for (var j = 0; j < list.length; j ++) {
                 listshow += list[j] + '<br>';
            }
            if (listshow == "") {
                HtmlCode += '<TD >--</TD>';
            } else {
                HtmlCode += '<TD id = \"SrcIpList'+i+'\">' + listshow  + '</TD>';
            }

            var enable = (WanAclList[i].Enable == 1) ? wan_acl_language['bbsp_td_enable']:wan_acl_language['bbsp_td_disable'];
            HtmlCode += '<TD id = \"AclEnable' + i+ '\">' + enable   + '</TD>';

            HtmlCode += '</TR>';
        }

        return HtmlCode;
    }

    function DeleteIpList(id)
    {
        var index = id.split('_')[1];
        CurSrcIpList.splice(index, 1);

        var Htmlcode = CreateSrcIPListCode(CurSrcIpList);
        $("#srciplist").empty();
        $("#srciplist").append(Htmlcode);
    }

    function AddIpList()
    {
       if (CurSrcIpList.length >= MaxSrcIpNum) {
           AlertEx(wan_acl_language['bbsp_alert_recfull']);
           return false;
       }

       CurSrcIpList.push("");

       var Htmlcode     = CreateSrcIPListCode(CurSrcIpList);
       $("#srciplist").empty();
       $("#srciplist").append(Htmlcode);

       if (IsTelmexOpenAccess()) {
          setCtrlConfigPanel(1);
       }
    }

    function radioClick(id)
    {
        var index = id.split('_')[1];

        CurSrcIpList[index] = getValue(id);
    }

    function CreateSrcIPListCode(iplist)
    {
        var HtmlCode = "";
        var i = 0;

        if (iplist.length > 0) {
            for (i = 0; i < iplist.length; i++) {
                HtmlCode += '<tr>';
                HtmlCode += '<td><input id=\"ip_' + i + '\" type=\"text\"  value=\"' + htmlencode(iplist[i]) + '\" onblur = \"radioClick(this.id);\" name=\"ip_' + i + '\" class=\"width_186px\" maxlength=\"255\">';
                HtmlCode += '<span class=\"gray\">' + wan_acl_language['bbsp_td_srcip_note'] + '</span>';
                HtmlCode += '</td>';

                HtmlCode += '<td>';
                HtmlCode += '<button id=\"btnDeleteIp_' + i + '\" type=\"button\" onclick=\"DeleteIpList(this.id);\" class=\"NewDelbuttoncss1\" >';
                HtmlCode += wan_acl_language['bbsp_delete'];
                HtmlCode += '</button>';
                HtmlCode += '</td>';
                HtmlCode += '</tr>';
            }
        }

        HtmlCode += '<tr>';
        HtmlCode += '<td>';
        HtmlCode += '<button id=\"btnAddIp\"  type=\"button\" onclick=\"AddIpList();\" class=\"NewDelbuttoncss1\" >';
        HtmlCode +=  wan_acl_language['bbsp_add'];
        HtmlCode += '</button>';
        HtmlCode += '</td>';
        HtmlCode += '</tr>';

        return HtmlCode;
     }

    function loadlanguage()
    {
        var all = document.getElementsByTagName("td");
        for (var i = 0; i <all.length ; i++) {
            var b = all[i];
            if (b.getAttribute("BindText") == null) {
                continue;
            }
            b.innerHTML = wan_acl_language[b.getAttribute("BindText")];
        }
    }

    function BindPageData(WanAclInfo)
    {
        setSelect("WanNameList", WanAclInfo.WanName);
        setText("domain", WanAclInfo.domain);

        setCheck('WanAclEnable', WanAclInfo.Enable);
        setCheck('cb_TELNET', 0);
        setCheck('cb_FTP', 0);
        setCheck('cb_HTTP', 0);
        setCheck('cb_SSH', 0);
        setCheck('cb_ICMP', 0);
        if ((IsPTVDFFlag == 1) || (IsPtVdfAP == 1)) {
            setCheck('cb_ACS', 0);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('TELNET')) {
            setCheck('cb_TELNET', 1);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('FTP')) {
            setCheck('cb_FTP', 1);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('HTTP')) {
            setCheck('cb_HTTP', 1);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('SSH')) {
            setCheck('cb_SSH', 1);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('ICMP')) {
            setCheck('cb_ICMP', 1);
        }

        if (((IsPTVDFFlag == 1) || (IsPtVdfAP == 1)) && (WanAclInfo.Protocol.toUpperCase().match('ACS'))) {
            setCheck('cb_ACS', 1);
        }

        $("#srciplist").empty();

        CurSrcIpList = GetSrcIpList(WanAclInfo.SrcIPPrefix);
        $("#srciplist").append(CreateSrcIPListCode(CurSrcIpList));

        if (IsTelmexOpenAccess()) {
            setCtrlConfigPanel(1);
        }
    }

    function GetWanAclData()
    {
        return new WanAccessItemClass(getValue("domain"), getValue("WanAclEnable"), "", getSelectVal("WanNameList"), "");
    }

    function IsTelmexOpenAccess()
    {
        return (('TELMEXVULA' == CfgModeWord.toUpperCase()) || ('TELMEXACCESS' == CfgModeWord.toUpperCase()) || ('TELMEXACCESSNV' == CfgModeWord.toUpperCase()) || ('TELMEXRESALE' == CfgModeWord.toUpperCase()))? true : false;
    }

    function setCtrlConfigPanel(iDisable)
    {
        setDisable("WanAclEnable", iDisable);
        setDisable("WanNameList", iDisable);
        setDisable("cb_TELNET", iDisable);
        setDisable("cb_HTTP", iDisable);
        setDisable("cb_FTP", iDisable);
        setDisable("cb_SSH", iDisable);
        setDisable("cb_ICMP", iDisable);
        if ((IsPTVDFFlag == 1) || (IsPtVdfAP == 1)) {
           setDisable("cb_ACS", iDisable);
        }
        setDisable("btnAddIp", iDisable);
        setDisable("ButtonApply", iDisable);
        setDisable("ButtonCancel", iDisable);
        setDisable("Newbutton", iDisable);
        setDisable("DeleteButton", iDisable);
        
        setDisable("ip_0", iDisable);
        setDisable("ip_1", iDisable);
        setDisable("ip_2", iDisable);
        setDisable("ip_3", iDisable);
        setDisable("btnDeleteIp_0", iDisable);
        setDisable("btnDeleteIp_1", iDisable);
        setDisable("btnDeleteIp_2", iDisable);
        setDisable("btnDeleteIp_3", iDisable);

        for (var i = 0; i < GetWanAccessList().length; i++) {
            setDisable("Recordrml_"+i, iDisable);
        }
    }

    function OnPageLoad()
    {
        if ((SingleFlag == 1) || (IsViettel8045A2Flag == 1)) {
          setDisplay("TD_cb_TELNET", 0);
          setDisplay("TD_cb_SSH", 0);
        }

        if (IsTedata()) {
            setDisplay("TD_cb_TELNET", 0);
            setDisplay("TD_cb_SSH", 0);
            setDisplay("TD_cb_FTP", 0);
            setDisplay("TD_cb_ICMP", 0);
        }

        if (wanaclFlag == 1) {
            setDisplay("appendwanacltitle",1);
        }

        if ((CfgModeWord.toUpperCase() == 'OI') || (CfgModeWord.toUpperCase() == 'OI2')) {
            setDisplay("appendwanacltitle", 0);
        }

        if (IsTelmexOpenAccess()) {
            setCtrlConfigPanel(1);
        }

        if ((IsPTVDFFlag != 1) && (IsPtVdfAP != 1)) {
            setDisplay("TD_cb_ACS", 0);
        }
        loadlanguage();
        return true;
    }

    function CheckParameter(WanAccessItem)
    {
        if (WanAccessItem.WanName == "") {
            AlertEx(wan_acl_language['bbsp_alert_wan']);
            return false;
        }

        return true;
    }

    function clickRemove() 
    {
        return OnRemoveButtonClick();
    }

    function setControl(Index)
    {
        if (Index < -1) {
            return;
        }
        if (Index == -1) {
            CurrentWanDomain = "";
            SetAddMode();
            if (GetWanAccessList().length >= 8) {
                AlertEx(wan_acl_language['bbsp_alert_recfull']);
                OnCancelButtonClick();
                return false;
            }
            return OnAddButtonClick();
        } else {
            CurrentWanDomain = GetWanAccessList()[Index].domain;
            SetEditMode();
            return OnEditButtonClick(Index);
        }
    }

    function OnAddButtonClick()
    {
        BindPageData(new WanAccessItemClass("", "", "", "", ""));
        setDisplay("TableConfigInfo", "1");
        return false;
    }

    function OnEditButtonClick(Index)
    {
        BindPageData(GetWanAccessList()[Index]);
        setDisplay("TableConfigInfo", "1");

        return false;
    }

    function OnRemoveButtonClick()
    {
        var CheckBoxList = document.getElementsByName("rml");
        var Form = new webSubmitForm();
        var Count = 0;

        for (var i = 0; i < CheckBoxList.length; i++) {
            if (CheckBoxList[i].checked != true) {
                continue;
            }

            Count++;
            Form.addParameter(CheckBoxList[i].value,'');
        }
        if (Count <= 0) {
            return false;
        }
        setDisable("DeleteButton","1");
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.AclServices.WanAccess' + '&RequestFile=html/bbsp/wanacl/wanacl_dtedata.asp');
        Form.submit();
        setDisable('ButtonApply',1);
        setDisable('ButtonCancel',1);
        return false;
    }

    function num2binstr(num, outputstrlen)
    {
        var outputstr = num.toString(2);
        var len = outputstr.length;

        for (var i = 0; i < outputstrlen - len; i++) {
            outputstr = '0' + outputstr;
        }

        return outputstr;
    }

    function IPv4Address2binstr(address)
    {
        var addrmum = IpAddress2DecNum(address);
        var addrbinstr = num2binstr(addrmum, 32);

        return addrbinstr;
    }

    function isIPv4AddrMaskValid(address, masklen)
    {
        if((isAbcIpAddress(address) == false) ||
           (isDeIpAddress(address) == true) ||
           (isLoopIpAddress(address) == true)) {
            return false;
        }

        if (CheckNumber(masklen, 1, 32) == false) {
            return false;
        }

        var addrbinstr = IPv4Address2binstr(address);
        var masklenum = parseInt(masklen, 10);
        for (var i = masklenum; i < addrbinstr.length; i++) {
            if (addrbinstr.charAt(i) != '0') {
                return false;
            }
        }

        return true;
    }

    function IPv6Address2binstr(address)
    {
        var ipv6addr_bin = "";
        var ipv6addr = standIpv6Address(address);
        for (var i = 0; i < ipv6addr.length; i++) {
            var tmp = parseInt(ipv6addr[i], 16);
            ipv6addr_bin += num2binstr(tmp, 16);
        }

        return ipv6addr_bin;
    }

    function isIPv6AddrMaskValid(address, masklen)
    {
        if (CheckIpv6Parameter(address) == false) {
            return false;
        }

        var ipv6addr_bin = IPv6Address2binstr(address);
        var masklenum = parseInt(masklen, 10);
        for (var j = masklenum; j < ipv6addr_bin.length; j++) {
            if (ipv6addr_bin.charAt(j) != '0') {
                return false;
            }
        }

        if (CheckNumber(masklen, 1, 128) == false) {
            return false;
        }

        return true;
    }

    function isDuplicatedAddress(pos, address, masken)
    {
        for (var i = 0; i < pos; i++) {
            var addrtmp = CurSrcIpList[i].split("/")[0];
            var masklentmp = CurSrcIpList[i].split("/")[1];

            if (address.indexOf(".") > 0) {
                if (addrtmp.indexOf(".") < 0) {
                    continue;
                }
                var addrbinstr_tmp = IPv4Address2binstr(addrtmp);
                var addrbinstr_cur = IPv4Address2binstr(address);

                if ((addrbinstr_tmp == addrbinstr_cur) && (masklentmp == masken)) {
                    return true;
                }
            } else {
                if (addrtmp.indexOf(":") < 0) {
                    continue;
                }

                var ipv6addr_bin_tmp = IPv6Address2binstr(addrtmp);
                var ipv6addr_bin_cur = IPv6Address2binstr(address);

                if ((ipv6addr_bin_tmp == ipv6addr_bin_cur) && (masklentmp == masken)) {
                    return true;
                }
            }
        }
        return false;
    }

    function GetSelectedWan(wanname)
    {
        var WanList = GetWanList();
        var i = 0;

        for (i = 0; i < WanList.length; i++) {
            if (wanname == domainTowanname(WanList[i].domain)) {
                return WanList[i];
            }
        }
        return null;
    }

    function OnApplyButtonClick()
    {
        var WanAclItem = GetWanAclData();
        var SrcIP = "";
        for (var i = 0; i < CurSrcIpList.length; i++) {
            CurSrcIpList[i] = getValue("ip_"+ i.toString());

            if (CurSrcIpList[i] == "") {
                continue;
            }

            if (CurSrcIpList[i].indexOf("/") < 0) {
                AlertEx(CurSrcIpList[i] + " " + wan_acl_language['bbsp_td_srcip_invalid']);
                return false;
            }
            var addresses = CurSrcIpList[i].split("/");
            if (addresses.length != 2) {
                AlertEx(wan_acl_language['bbsp_td_srcip_invalid']);
                return false;
            }

            var address = CurSrcIpList[i].split("/")[0];
            var masklen = CurSrcIpList[i].split("/")[1];
            if ((address == "") || (masklen == "")) {
                AlertEx(wan_acl_language['bbsp_td_srcip_invalid']);
                return false;
            }

            var valid = false;
            var WanInfo = GetSelectedWan(WanAclItem.WanName);
            if (address.indexOf(".") > 0) {
                if ((WanInfo != null) && (WanInfo.IPv4Enable != "1")) {
                    AlertEx(wan_acl_language['bbsp_td_srciptype_invalid']);
                    return false;
                }
                valid =  isIPv4AddrMaskValid(address, masklen);
            } else if (address.indexOf(":") > 0) {
                if ((WanInfo != null) && (WanInfo.IPv6Enable != "1")) {
                    AlertEx(wan_acl_language['bbsp_td_srciptype_invalid']);
                    return false;
                }
                valid =  isIPv6AddrMaskValid(address, masklen);
            }

            if (valid == false) {
                AlertEx(wan_acl_language['bbsp_td_srcip_invalid']);
                return false;
            }

            if (isDuplicatedAddress(i, address, masklen) == true) {
                AlertEx(wan_acl_language['bbsp_iprepeat']);
                return false;
            }

            if (i < CurSrcIpList.length - 1) {
                SrcIP += CurSrcIpList[i] + ',';
            } else {
                SrcIP += CurSrcIpList[i];
            }
        }

        if(SrcIP.charAt(SrcIP.length - 1) == ',') {
            SrcIP = SrcIP.substring(0, SrcIP.length - 1);
        }

        var Form = new webSubmitForm();
        var protoclStr = '';
        var selHttp = getCheckVal('cb_HTTP');
        var selFtp = getCheckVal('cb_FTP');
        var selIcmp = getCheckVal('cb_ICMP');
        var selAcs = getCheckVal('cb_ACS');
        if ((SingleFlag == 1) || (IsViettel8045A2Flag == 1)) {
            var selTelnet = 0;
            var selSSH = 0;
        } else if(IsTedata()) {
            var selTelnet = 0;
            var selSSH = 0;
            selFtp = 0;
            selIcmp = 0;
            selAcs = 0;
        } else {
            var selTelnet = getCheckVal('cb_TELNET');
            var selSSH = getCheckVal('cb_SSH');
        }

        if (selHttp == 1) {
            protoclStr="HTTP,";
        }
        if (selFtp == 1) {
            protoclStr=protoclStr+"FTP,";
        }
        if (selTelnet == 1) {
            protoclStr=protoclStr+"TELNET,";
        }
        if (selSSH == 1) {
            protoclStr=protoclStr+"SSH,";
        }
        if (selIcmp == 1) {
            protoclStr=protoclStr+"ICMP";
        }
        if ((selAcs == 1) && ((IsPTVDFFlag == 1) || (IsPtVdfAP == 1))) {
            protoclStr=protoclStr+"ACS";
        }
        if (protoclStr.charAt(protoclStr.length-1) == ',') {
            protoclStr = protoclStr.substring(0, protoclStr.length - 1);
        }

        WanAclItem.Enable = getCheckVal('WanAclEnable');

        WanAclItem.Protocol = protoclStr;

        if (protoclStr == '') {
            AlertEx(wan_acl_language['bbsp_alert_selproto']);
            return false;
        }

        Form.addParameter('x.WanName', WanAclItem.WanName);
        Form.addParameter('x.Enable', WanAclItem.Enable);
        Form.addParameter('x.Protocol', WanAclItem.Protocol);
        Form.addParameter('x.SrcIPPrefix', SrcIP);

        var WanAclList = GetWanAccessList();
        var RecordCount = WanAclList.length;
        var i = 0;
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        if (IsAddMode() == true) {
            Form.setAction('add.cgi?' + 'x=InternetGatewayDevice.X_HW_Security.AclServices.WanAccess' + '&RequestFile=html/bbsp/wanacl/wanacl_dtedata.asp');
        } else {
            Form.setAction('set.cgi?' + 'x='+WanAclItem.domain + '&RequestFile=html/bbsp/wanacl/wanacl_dtedata.asp');
        }
        Form.submit();
        DisableRepeatSubmit();
        setDisable('ButtonApply', 1);
        setDisable('ButtonCancel', 1);
        return false;
    }

    function OnCancelButtonClick()
    {
        if ((GetWanAccessList().length > 0) && (IsAddMode())) {
            var tableRow = getElementById("xxxInst");
            tableRow.deleteRow(tableRow.rows.length-1);
        }
        setDisplay("TableConfigInfo", "0");
        return false;
    }
</script>

</head>
<body onLoad="OnPageLoad();" class="mainbody"> 
<form id="ConfigForm">
<div id="PromptPanel">
<script language="JavaScript" type="text/javascript">
if (IsNeedAddSafeDesForBelTelecom() == true) {
    HWCreatePageHeadInfo("wanacltitle", GetDescFormArrayById(wan_acl_language, "bbsp_mune"), GetDescFormArrayById(wan_acl_language, "bbsp_title_prompt") + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>", false);
} else {
    HWCreatePageHeadInfo("wanacltitle", GetDescFormArrayById(wan_acl_language, "bbsp_mune"), GetDescFormArrayById(wan_acl_language, "bbsp_title_prompt"), false);
}
</script> 
<div class="title_spread"></div>

</div>
<script language="JavaScript" type="text/javascript">
    ((FltsecLevel == 'CUSTOM') ? writeTabCfgHeader : writeTabInfoHeader)('wacl','100%');
</script>
<table class="tabal_bg" id="xxxInst" width="100%" cellspacing="1">
    <tr  class="head_title">
        <td class='width_per5'>&nbsp;</td>
        <td class='width_per30' BindText='bbsp_td_wanname'></td>
        <td class='width_per25' BindText='bbsp_td_proto'></td>
        <td class='width_per30' BindText='bbsp_td_srcip'></td>
        <td class='width_per10' BindText='bbsp_td_enable'></td>
    </tr>
    <script>
        document.write(CreateWanAclList());
    </script>
</table>

<div id="TableConfigInfo" style="display:none">
    <div class="list_table_spread"></div>
    <table class="tabal_noborder_bg" class="tabCfgArea" border="0" cellpadding="0" cellspacing="1"  width="100%">
        <tr class="trTabConfigure displaynone">
            <td  class="table_title align_left width_per15" BindText='bbsp_td_instance'></td>
            <td  class="table_right">
                <input type=text id="domain"  class='width_150px' maxlength=255  ErrorMsg="" datatype="int" minvalue="0" maxvalue="253" default="0"/>
            </td>
        </tr>

        <tr class="trTabConfigure">
            <td class="table_title align_left width_per15" BindText='bbsp_td_enable1'></td>
            <td class="table_right"> <input type='checkbox' id='WanAclEnable' name='WanAclEnable'> </td>
        </tr>

        <tr class="trTabConfigure">
            <td class="table_title align_left width_per15" BindText='bbsp_td_wanname2'></td>
            <td class="table_right"><select id="WanNameList"  class='width_200px restrict_dir_ltr' name="D1" ErrorMsg=""></select>
            </td>
        </tr>

        <tr class="trTabConfigure">
            <td class="table_title align_left width_per15" BindText='bbsp_td_proto2'></td>
            <td class="table_right">
                <div id="Div_TELNET">
                    <table>
                        <tr>
                            <td id="TD_cb_TELNET"><input id="cb_TELNET" name="cb_TELNET" type="checkbox" value='TELNET'>TELNET</td>
                            <td id="TD_cb_SSH"><input id="cb_SSH"  name="cb_SSH"  type="checkbox" value='SSH'>SSH</td>
                            <td id="TD_cb_HTTP"><input id="cb_HTTP" name="cb_HTTP" type="checkbox" value="HTTP">HTTP</td>
                            <td id="TD_cb_FTP"><input id="cb_FTP"  name="cb_FTP"  type="checkbox" value="FTP">FTP</td>
                            <td id="TD_cb_ICMP"><input id="cb_ICMP"  name="cb_ICMP"  type="checkbox" value="FTP">ICMP</td>
                            <td id="TD_cb_ACS"><input id="cb_ACS"  name="cb_ACS"  type="checkbox" value="ACS">ACS</td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="trTabConfigure">
            <td class="table_title align_left width_per15" BindText='bbsp_td_srcip1'></td>
            <td class="table_right">
                <table id="srciplist">
                </table>
            </td>
        </tr>
    </table>
 
    <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
        <tr>
            <td class='width_per15'>
            </td>
            <td class="table_submit pad_left5p">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(wan_acl_language['bbsp_app']);</script></button>
                <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(wan_acl_language['bbsp_cancel']);</script></button>
            </td>
        </tr>
    </table>
</div>
<script>
    function IsRouteWan(Wan)
    {
        if (viettelflag ==1) {
            if (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0) {
                return false;
            }
        }
        if (Wan.Mode =="IP_Routed") {
            return true;
        }

        return false;
    }
    InitWanNameListControl("WanNameList", IsRouteWan,true);
</script>
</form>
</body>
</html>
