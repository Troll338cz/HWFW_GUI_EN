<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_staticinfo.asp"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/ipv6staticroute.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script>
    var TableName = "StaticRouteConfigList";
    var IPv6SRoutelistMaxNum = '<%HW_WEB_GetSPEC(BBSP_SPEC_IPV6_ROUTE_MAXNUM.UINT32);%>';
    var currentFile='ipv6staticroute_dtedata.asp';

    function stStaticRoute(domain, DestIPAddress) {
        this.domain = domain;
        this.DestIPAddress = DestIPAddress;
    }

    var listNum = 10;
    var RouteInfoNr = GetStaticRouteList().length;
    var firstpage = 1;
    if (RouteInfoNr == 0) {
        firstpage = 0;
    }

    var lastpage = RouteInfoNr/listNum;
    if (lastpage != parseInt(lastpage, 10)) {
        lastpage = parseInt(lastpage, 10) + 1;
    }

    var page = firstpage;

    if (window.location.href.indexOf("del.cgi") == -1 && window.location.href.indexOf("add.cgi") == -1 && window.location.href.indexOf("set.cgi") == -1 && window.location.href.indexOf("?") > 0) {
        page = parseInt(window.location.href.split("?")[1], 10); 
    }

    if (page < firstpage) {
        page = firstpage;
    } else if ( page > lastpage ) {
        page = lastpage;
    }

    function IsValidPage(pagevalue) {
        if (true != isInteger(pagevalue)) {
            return false;
        }
        return true;
    }

    function GetInterfaceName(_interface) {
        if(_interface.toUpperCase().indexOf("WAN") > -1) {
            return GetWanFullName(_interface);
        } else {
            return _interface;
        }
    }

    function shoulist(startlist, endlist) {
        var ColumnNum = 4;
        var ShowButtonFlag = true;
        var StaticRouteTableConfigInfoList = new Array();
        var TableDataInfo = new Array();
        var Listlen = 0;
        var PolicyRouteList = GetStaticRouteList();
        var HtmlCode = "";
        var DataGrid = getElById("DataGrid");
        var RecordCount = PolicyRouteList.length;
        var i = 0;

        if (RecordCount == 0) {
            TableDataInfo[Listlen] = new RouteItemClass();
            TableDataInfo[Listlen].domain = '--';
            TableDataInfo[Listlen].DestIPPrefix = '--';
            TableDataInfo[Listlen].NextHop = '--';
            TableDataInfo[Listlen].WanName = '--';
            HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, StaticRouteConfiglistInfo, static_route_language, null);
            return;
        }

        for (i = startlist; i <= endlist - 1; i++) {
            TableDataInfo[Listlen] = new RouteItemClass();
            TableDataInfo[Listlen].domain = PolicyRouteList[i].domain;
            TableDataInfo[Listlen].WanName = GetInterfaceName(PolicyRouteList[i].WanName);
            TableDataInfo[Listlen].DestIPPrefix = PolicyRouteList[i].DestIPPrefix;
            TableDataInfo[Listlen].NextHop = PolicyRouteList[i].NextHop;
            Listlen++;
        }
        TableDataInfo.push(null);
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, StaticRouteConfiglistInfo, static_route_language, null);
    }

    function showlistcontrol() {
        if (RouteInfoNr == 0) {
            shoulist(0 , 0);
        } else if (RouteInfoNr >= listNum*parseInt(page, 10)) {
            shoulist((parseInt(page,10)-1)*listNum, parseInt(page, 10)*listNum);
        } else {
            shoulist((parseInt(page,10)-1)*listNum, RouteInfoNr);
        }
    }

    function submitfirst() {
        page = firstpage;

        if (false == IsValidPage(page)) {
            return;
        }
        window.location= currentFile + "?" + parseInt(page, 10);
    }

    function submitprv() {
        if (false == IsValidPage(page)) {
            return;
        }
        page--;
        window.location = currentFile + "?" + parseInt(page, 10);
    }

    function submitnext() {
        if (false == IsValidPage(page)) {
            return;
        }
        page++;
        window.location= currentFile + "?" + parseInt(page, 10);
    }

    function submitlast() {
        page = lastpage;
        if (false == IsValidPage(page)) {
            return;
        }
        window.location= currentFile + "?" + parseInt(page, 10);
    }

    function submitjump() {
        var jumppage = getValue('pagejump');
        if ((jumppage == '') || (isInteger(jumppage) != true)) {
            setText('pagejump', '');
            return;
        }

        jumppage = parseInt(jumppage, 10);
        if (jumppage < firstpage) {
            jumppage = firstpage;
        }
        if (jumppage > lastpage) {
            jumppage = lastpage;
        }
        window.location= currentFile + "?" + jumppage;
    }

    var Ipv6StaticRoute = GetStaticRouteList();
    function loadlanguage() {
        var all = document.getElementsByTagName("td");
        for (var i = 0; i <all.length; i++) {
            var b = all[i];
            if (b.getAttribute("BindText") == null) {
                continue;
            }
            setObjNoEncodeInnerHtmlValue(b, static_route_language[b.getAttribute("BindText")]);
        }
    }
    var route_selectIndex = -1;

    function BindPageData(RouteInfo) {
        setSelect("WanNameList", RouteInfo.WanName);
        setText("domain", RouteInfo.domain);
        setText("DestIPPrefix", RouteInfo.DestIPPrefix);
        setText("NextHop", RouteInfo.NextHop);
    }
    function GetBindPageData() {
        return new RouteItemClass(getValue("domain"), getValue("DestIPPrefix"), getValue("NextHop"), getSelectVal("WanNameList"));
    }
    function OnPageLoad() {
        loadlanguage();
        setDisplay('domainRow', 0);
        return true;
    }

    function processipv6(ipv6) {
        var ipv6array=ipv6.split(":");
        if(ipv6array.length != 8) {
            var str = "::";
            for(var i = 0; i < 8 - ipv6array.length; i++) {
                str += ":";
            }
        }
        return ipv6.replace("::",str);
    }
    function CheckParameter(RouteItem) { 
        if (RouteItem.DestIPPrefix == "") {
            AlertEx(static_route_language['bbsp_prefixreq']);
            return false;
        }
        var List = RouteItem.DestIPPrefix.split("/");
        if (List.length != 2) {
            AlertEx(static_route_language['bbsp_prefixinvalid']);
            return false;
        }
        if ('' == List[1]) {
            AlertEx(static_route_language['bbsp_prefixinvalid']);
            return false;
        }
        if (isNaN(List[1]) == true || parseInt(List[1],10) <= 0 || parseInt(List[1],10) > 128 || isNaN(List[1].replace(' ', 'a')) == true) {
            AlertEx(static_route_language['bbsp_prefixinvalid']);
            return false;
        }

        if (IsIPv6AddressValid(List[0]) == false || IsIPv6ZeroAddress(List[0]) == true || IsIPv6LoopBackAddress(List[0]) == true || IsIPv6MulticastAddress(List[0]) == true) {
            AlertEx(static_route_language['bbsp_prefixinvalid']);
            return false;
        }

        if (RouteItem.NextHop != "") {
            if (IsIPv6AddressValid(RouteItem.NextHop) == false || IsIPv6ZeroAddress(RouteItem.NextHop) == true || IsIPv6LoopBackAddress(RouteItem.NextHop) == true || IsIPv6MulticastAddress(RouteItem.NextHop) == true) {
                AlertEx(static_route_language['bbsp_nexthopinvalid']);
                return false;
            }
        }

        if (("1" == GetCfgMode().PCCWHK)) {
            if ((RouteItem.WanName == "") && (RouteItem.NextHop == "")) {
                AlertEx(static_route_language['bbsp_set_interface']);
                return false;
            }
            if ((RouteItem.WanName == "br0") && (RouteItem.NextHop == "")) {
                AlertEx(static_route_language['bbsp_set_nexthop']);
                return false;
            }
        } else {
            if ((RouteItem.WanName == "")) {
                AlertEx(static_route_language['bbsp_wanreq']);
                return false;
            }
        }

        var ipv6 = processipv6(List[0]).split(":");
        var j = 0;
        for (var i = 0; i < Ipv6StaticRoute.length; i++) {
            if (Ipv6StaticRoute[i] == null) {
                continue;
            }

            if (i == route_selectIndex) {
                continue;
            }
            Ipv6Route = Ipv6StaticRoute[i].DestIPPrefix.split("/");

            if (List[1]!=Ipv6Route[1]) {
                continue;
            }

            var itemipv6 = processipv6(Ipv6Route[0]).split(":");
            var isequal = 1;
            var k=parseInt((List[1]/16).toString().split(".")[0]);

            for (j = 0; j < k; j++) {
                if ((itemipv6[j] != ipv6[j]) && (parseInt(itemipv6[j], 16) != parseInt(ipv6[j], 16))) {
                    isequal = 0;
                    break;
                }
            }
            if (isequal == 0) {
                continue;
            }

            if ((itemipv6[j] == ipv6[j]) || (parseInt(itemipv6[j], 16) == parseInt(ipv6[j], 16))) {
                AlertEx(static_route_language['bbsp_prefixrepeated']);
                return false;
            } else {
                var y = List[1] % 16;
                if (ipv6[j] != '') {
                    var str1 = parseInt(ipv6[j], 16).toString(2);
                } else {
                    str1 = '0';
                }
                if (itemipv6[j] != '') {
                    var str2 = parseInt(itemipv6[j], 16).toString(2);
                } else {
                    str2 = '0';
                }
                var addstr1 = '';
                var addstr2 = '';
                for (var n = 0; n < 16 - str1.length; n++) {
                    addstr1 += '0';
                }
                for (var n = 0; n < 16 - str2.length; n++) {
                    addstr2 += '0';
                }
                str1 = addstr1 + str1;
                str2 = addstr2 + str2;
                var substr1 = str1.substring(0, y);
                var substr2 = str2.substring(0, y);

                if (substr1 == substr2) {
                    AlertEx(static_route_language['bbsp_prefixrepeated']);
                    return false;
                }
            }
        }
        return true;
    }

    function setControl(Index) {
        route_selectIndex = Index;
        if (Index < -1) {
            return;
        }
        if (Index == -1) {
            SetAddMode();
            if ((GetStaticRouteList().length) >= IPv6SRoutelistMaxNum) {
                AlertEx(static_route_language['bbsp_reachlimit']);
                OnCancelButtonClick();
                return false;
            }
            return OnAddButtonClick();  
        } else {
            var index1 =  Index + (parseInt(page, 10) - 1) * listNum;
            SetEditMode();
            return OnEditButtonClick(index1);
        }
    }

    function OnAddButtonClick() {
        BindPageData(new RouteItemClass("", "", "", "", ""));
        setDisplay("TableConfigInfo", "1");
        return false;
    }

    function OnEditButtonClick(Index) {
        BindPageData(GetStaticRouteList()[Index]);
        setDisplay("TableConfigInfo", "1");
        return false;
    }

    function StaticRouteConfigListselectRemoveCnt(val) {

    }

    function OnDeleteButtonClick(TableID) {
        var CheckBoxList = document.getElementsByName(TableName + 'rml');
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
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' + 'x=InternetGatewayDevice.X_HW_IPv6Layer3Forwarding.Forwarding' + '&RequestFile=html/bbsp/ipv6staticroute/ipv6staticroute_dtedata.asp');
        Form.submit();

        return false;
    }

    function OnApplyButtonClick() {
        var RouteItem = GetBindPageData();
        if (CheckParameter(RouteItem) == false) {
            return false;
        }

        var Form = new webSubmitForm();

        Form.addParameter('x.WanName', RouteItem.WanName);
        Form.addParameter('x.DestIPPrefix',RouteItem.DestIPPrefix);
        Form.addParameter('x.NextHop',RouteItem.NextHop);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));

        if (IsAddMode() == true) {
            Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_IPv6Layer3Forwarding.Forwarding' + '&RequestFile=html/bbsp/ipv6staticroute/ipv6staticroute_dtedata.asp');
        } else {
            Form.setAction('set.cgi?' +'x='+RouteItem.domain + '&RequestFile=html/bbsp/ipv6staticroute/ipv6staticroute_dtedata.asp');
        }
        Form.submit();
        DisableRepeatSubmit();

        return false;
    }

    function OnCancelButtonClick() {
        if (GetStaticRouteList().length > 0 && IsAddMode()) {
            var tableRow = getElementById(TableName);
            tableRow.deleteRow(tableRow.rows.length - 1);
        }
        setDisplay("TableConfigInfo", "0");
        return false;
    }
</script>
<title>IPv6 Static Route Configuration</title>
</head>
<body  class="mainbody" onload="OnPageLoad();"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("ipv6staticroutetitle", GetDescFormArrayById(static_route_language, "bbsp_mune"), GetDescFormArrayById(static_route_language, "bbsp_static_route_title"), false);
</script>
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
    var StaticRouteConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per7","DomainBox"),
                                new stTableTileInfo("bbsp_wanname","align_center width_per40 restrict_dir_ltr","WanName"),
                                new stTableTileInfo("bbsp_prefix","align_center width_per30","DestIPPrefix",false,20),
                                new stTableTileInfo("bbsp_nexthop","align_center width_per30","NextHop",false,20),null);
    showlistcontrol();
</script>
    <div id="TableConfigInfo2">
    <div class="list_table_spread"></div>
    <table id="ConfigPanelButtons2" width="100%" cellspacing="1" class="table_button">
        <tr >
        <td class='width_per40'></td>
        <td class='title_bright1' >
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <input name="first" id="first" class="PageNext jumppagejumplastbutton_wh_px" type="button" value="<<" onClick="submitfirst();"/>
            <input name="prv" id="prv"  class="PageNext jumppagejumpbutton_wh_px" type="button" value="<" onClick="submitprv();"/>
            <script>
                if (IsValidPage(page) == false) {
                    page = (0 == RouteInfoNr) ? 0 : 1;
                }
                document.write(htmlencode(parseInt(page, 10) + "/" + lastpage));
            </script>
            <input name="next"  id="next" class="PageNext jumppagejumpbutton_wh_px" type="button" value=">" onClick="submitnext();"/>
            <input name="last"  id="last" class="PageNext jumppagejumplastbutton_wh_px" type="button" value=">>" onClick="submitlast();"/>
        </td>
        <td class='width_per5'></td>
        <td  class='title_bright1'>
            <script> document.write(static_route_language['bbsp_goto']); </script> 
                <input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
            <script> document.write(static_route_language['bbsp_page']); </script>
        </td>
        <td class='title_bright1'>
            <button name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="submitjump();"> <script> document.write(static_route_language['bbsp_jump']); </script></button>
        </td>
    </tr>
    </table>
    </div>

    <form id="TableConfigInfo" style="display:none">
        <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
            <li id="domain" RealType="TextBox" DescRef="bbsp_instancemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.domain" Elementclass="width_150px" InitValue="Empty" MaxLength="255"/>
            <li id="DestIPPrefix" RealType="TextBox" DescRef="bbsp_destprefixmh" RemarkRef="bbsp_staticroutenotel" ErrorMsgRef="Empty" Require="TRUE" BindField="x.domain" Elementclass="width_254px restrict_dir_ltr" InitValue="Empty" MaxLength="255"/>
            <li id="NextHop" RealType="TextBox" DescRef="bbsp_nexthopmh" RemarkRef="bbsp_staticroutenote2" ErrorMsgRef="Empty" Require="FALSE" BindField="x.domain" Elementclass="width_254px restrict_dir_ltr" InitValue="Empty" MaxLength="255"/>
            <li id="WanNameList" RealType="DropDownList" DescRef="bbsp_wannamemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.domain" Elementclass="width_260px restrict_dir_ltr" InitValue="Empty"/>
            <script language="JavaScript" type="text/javascript">
                var TableClass = new stTableClass("width_per20", "width_per80", "ltr");
                var StaticRouteFormList = new Array();
                StaticRouteFormList = HWGetLiIdListByForm("TableConfigInfo", null);
                HWParsePageControlByID("TableConfigInfo", TableClass, static_route_language, null);
            </script>
        </table>
        <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
            <tr>
                <td class='width_per20'> </td>
                <td class="table_submit pad_left5p"> <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(static_route_language['bbsp_app']);</script> </button>
                    <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" >
                        <script>document.write(static_route_language['bbsp_cancel']);</script>
                    </button>
                </td>
            </tr>
        </table>
    </form>
<script>
    function IsIPv6RouteWan(Wan) {
        if (Wan.IPv6Enable == "1" && Wan.Mode =="IP_Routed") {
          return true;
        } 
        return false;
    }

    InitWanNameListControl("WanNameList", IsIPv6RouteWan, true);

    if (page == firstpage) {
        setDisable('first',1);
        setDisable('prv',1);
    }
    if (page == lastpage) {
        setDisable('next',1);
        setDisable('last',1);
    }
</script> 
</body>
</html>

