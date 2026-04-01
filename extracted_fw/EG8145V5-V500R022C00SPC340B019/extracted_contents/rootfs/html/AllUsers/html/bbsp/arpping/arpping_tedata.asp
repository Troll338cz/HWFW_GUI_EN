<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="Javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_staticinfo.asp"></script>
<title>ARP Ping</title>
</head>
<body class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("arppingtitle", GetDescFormArrayById(arpping_language, "bbsp_mune"), GetDescFormArrayById(arpping_language, "bbsp_arpping_title"), false);
</script> 
<div class="title_spread"></div>
<table border="0" cellpadding="0" cellspacing="0" id="Table1" width="100%"> </table> 
<script language="javascript">
var selIndex = -1;
var MaxRouteWan = GetRouteWanMax();
var TableName = "ArppingConfigList";

function loadlanguage() {
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = arpping_language[b.getAttribute("BindText")];
    }
}

function ArpPingItem(_Domain, _Enable, _Interface, _Interval, _Repeat) {
    this.Domain = _Domain;
    this.Enable = _Enable;
    this.Interface = _Interface;
    this.Interval = _Interval;
    this.Repeat = _Repeat;
}

var ArpPingList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_ARPPingDiagnostics.{i},ARPPingEnable|WanName|ARPPingInterval|ARPPingNumberOfRepetitions,ArpPingItem);%>;

function GetEnableString(Enable) {
    if (Enable == 1 || Enable == "1") {
        return arpping_language['bbsp_enable'];
    }
    return arpping_language['bbsp_disable'];
}

function InitTableData() {
    var ColumnNum = 4;
    var ShowButtonFlag = true;
    var TableDataInfo = new Array();
    var Listlen = 0;
    var i = 0;
    var RecordCount = ArpPingList.length - 1;
     
    if (RecordCount == 0) {
        TableDataInfo[Listlen] = new ArpPingItem();
        TableDataInfo[Listlen].domain = '--';
        TableDataInfo[Listlen].Interface = '--';
        TableDataInfo[Listlen].Interval = '--';
        TableDataInfo[Listlen].Repeat = '--';
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, ArppingConfiglistInfo, arpping_language, null);
        return;
    }

    for (i = 0; i < RecordCount; i++) {
        TableDataInfo[Listlen] = new ArpPingItem();
        TableDataInfo[Listlen].domain = ArpPingList[i].Domain;
        TableDataInfo[Listlen].Interface = GetWanFullName(ArpPingList[i].Interface);
        TableDataInfo[Listlen].Interval = ArpPingList[i].Interval;
        TableDataInfo[Listlen].Repeat = ArpPingList[i].Repeat;
        Listlen++;
    }
    TableDataInfo.push(null);
    HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, ArppingConfiglistInfo, arpping_language, null);
}

function CheckWanOkFunction(item) {
    if (item.IPv4AddressMode != "DHCP") {
        return false;
    }

    if (item.Tr069Flag == "1") {
        return false;
    }

    if (item.Mode != "IP_Routed") {
        return false;
    }

    if (item.IPv4Enable == 0) {
        return false;
    }

    return true;
}

window.onload = function() {
    InitWanNameListControl("WanNameList", CheckWanOkFunction, false);
    loadlanguage();
}

</script>
<script language="JavaScript" type="text/javascript">
var OperatorFlag = 0;
var OperatorIndex = 0;

function GetInputRouteInfo() {
    return new ArpPingItem("",getCheckVal("EnableControl"), getSelectVal("WanNameList"), getValue("IntervalControl"), getValue("RepeateControl"));
}

function SetInputRouteInfo(ArpPingItem) {
    setCheck("EnableControl", ArpPingItem.Enable);
    setSelect("WanNameList", ArpPingItem.Interface);
    setText("IntervalControl", ArpPingItem.Interval);
    setText("RepeateControl", ArpPingItem.Repeat); 
}

function IsRepeateConfig(RouteInfo) {
    var i = 0;
    for (i = 0; i < ArpPingList.length-1; i++) {
        if (RouteInfo.Interface == ArpPingList[i].Interface) {
            return true;
        }
    }
    return false;
}

function OnNewInstance(index) {
   OperatorFlag = 1;
   var pingitem = new ArpPingItem("", "0", "", "60", "3");
   document.getElementById("TableConfigInfo").style.display = "block";
   SetInputRouteInfo(pingitem);
}

function onSumbitCheck(RouteInfo) {
    if (RouteInfo.Interface.length == 0) {
        AlertEx(arpping_language['bbsp_msg1']);
        return false; 
    }

    RouteInfo.Interval = removeSpaceTrim(RouteInfo.Interval);
    if(RouteInfo.Interval!="") {
       if ( false == CheckNumber(RouteInfo.Interval,1, 3600) ) {
         AlertEx(arpping_language['bbsp_msg2']);
         return false;
       }
    } else {
        AlertEx(arpping_language['bbsp_msg2']);
        return false;
    }

    RouteInfo.Repeat = removeSpaceTrim(RouteInfo.Repeat);
    if(RouteInfo.Repeat!="") {
       if ( false == CheckNumber(RouteInfo.Repeat,1, 255) ) {
         AlertEx(arpping_language['bbsp_msg3']);
         return false;
       }
    } else {
        AlertEx(arpping_language['bbsp_msg3']);
        return false;
    }
    return true;
}

function OnAddNewSubmit() {
    var RouteInfo = GetInputRouteInfo();
    if(false == onSumbitCheck(RouteInfo)) {
        return false;
    }

    if (true == IsRepeateConfig(RouteInfo)) {
        AlertEx(arpping_language['bbsp_wanexist']);
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.ARPPingEnable', RouteInfo.Enable);
    Form.addParameter('x.WanName',RouteInfo.Interface);
    Form.addParameter('x.ARPPingInterval',RouteInfo.Interval);
    Form.addParameter('x.ARPPingNumberOfRepetitions',RouteInfo.Repeat);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_ARPPingDiagnostics' + '&RequestFile=html/bbsp/arpping/arpping_tedata.asp');
    Form.submit();
    DisableRepeatSubmit();
}

function ModifyInstance(index) {
    OperatorFlag = 2;
    OperatorIndex = index;

    document.getElementById("TableConfigInfo").style.display = "block";
    SetInputRouteInfo(ArpPingList[index]);
}
 
function OnModifySubmit() {
    var RouteInfo = GetInputRouteInfo();

    if(false == onSumbitCheck(RouteInfo)) {
        return false;
    }
  
    if (RouteInfo.Interface != ArpPingList[OperatorIndex].Interface) {
        if (true == IsRepeateConfig(RouteInfo))
        {
            AlertEx(arpping_language['bbsp_wanexist']);
            return false;
        }
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.ARPPingEnable', RouteInfo.Enable);
    Form.addParameter('x.WanName',RouteInfo.Interface);
    Form.addParameter('x.ARPPingInterval',RouteInfo.Interval);
    Form.addParameter('x.ARPPingNumberOfRepetitions',RouteInfo.Repeat);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?' +'x='+ ArpPingList[OperatorIndex].Domain + '&RequestFile=html/bbsp/arpping/arpping_tedata.asp');
    Form.submit();
    DisableRepeatSubmit();
}

function setControl(index) {
    if (index == -1) {
        if (ArpPingList.length-1 == MaxRouteWan) {
            var tableRow = getElementById(TableName);
            tableRow.deleteRow(tableRow.rows.length-1);
            AlertEx(arpping_language['bbsp_arppingfull']);
            return false;
        }
    }

    selIndex = index;
    if (index < -1) {
        return;
    }

    OperatorIndex = index;   

    if (-1 == index) {
        return OnNewInstance(index);
    } else {
        return ModifyInstance(index);
    }
}

function ArppingConfigListselectRemoveCnt(val) {

}

function OnDeleteButtonClick(TableID) {
    var CheckBoxList = document.getElementsByName(TableName + 'rml');
    var Count = 0;
    var i;
    for (i = 0; i < CheckBoxList.length; i++) {
        if (CheckBoxList[i].checked == true) {
            Count++;
        }
    }

    if (Count == 0) {
        return false;
    }

    var Form = new webSubmitForm();
    for (i = 0; i < CheckBoxList.length; i++) {
        if (CheckBoxList[i].checked != true) {
            continue;
        }
        Form.addParameter(CheckBoxList[i].value,'');
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_ARPPingDiagnostics' + '&RequestFile=html/bbsp/arpping/arpping_tedata.asp');
    Form.submit();
}

function OnApply() {
    if (OperatorFlag == 1) {
        return OnAddNewSubmit();
    } else {
        return OnModifySubmit();
    }
}

function OnCancel() {
    getElById('TableConfigInfo').style.display = 'none';
    getElById('TableConfigInfo').style.display = 'none';

    if (selIndex == -1) {
         var tableRow = getElementById(TableName);
         if (tableRow.rows.length > 2)
         tableRow.deleteRow(tableRow.rows.length-1);
         return false;
     }
}
</script> 
<script language="JavaScript" type="text/javascript">
    var TableClass = new stTableClass("width_per15", "width_per85", "ltr");
    var ArppingConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
                                          new stTableTileInfo("bbsp_wanname","align_center restrict_dir_ltr","Interface"),
                                          new stTableTileInfo("bbsp_interval","align_center","Interval"),
                                          new stTableTileInfo("bbsp_num","align_center","Repeat"),null);
    InitTableData();
</script>
<form id="TableConfigInfo" style="display:none;">
    <div class="list_table_spread"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li id="EnableControl" RealType="CheckBox" DescRef="bbsp_enablemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ARPPingEnable" InitValue="Empty"/>
        <li id="WanNameList" RealType="DropDownList" DescRef="bbsp_wannamemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.WanName" Elementclass="width_260px restrict_dir_ltr" InitValue="Empty"/>
        <li id="IntervalControl" RealType="TextBox" DescRef="bbsp_intervalmh" RemarkRef="bbsp_Intervalrange" ErrorMsgRef="Empty" Require="TRUE" BindField="x.ARPPingInterval" Elementclass="width_254px" InitValue="60"/>
        <li id="RepeateControl" RealType="TextBox" DescRef="bbsp_nummh" RemarkRef="bbsp_Repeaterange" ErrorMsgRef="Empty" Require="TRUE" BindField="x.ARPPingNumberOfRepetitions" Elementclass="width_254px" InitValue="3"/>
    </table>
    <script language="JavaScript" type="text/javascript">
        var ArppingConfigFormList = new Array();
        ArppingConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
        var formid_hide_id = null;
        HWParsePageControlByID("TableConfigInfo", TableClass, arpping_language, formid_hide_id);
    </script>
    <table width="100%"  cellspacing="1" class="table_button">
        <tr>
        <td class="width_per15"></td>
        <td class="table_submit pad_left5p">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id='Apply' type=button onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(arpping_language['bbsp_app']);</script></button>
            <button id='Cancel' type=button onclick="javascript:OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(arpping_language['bbsp_cancel']);</script></button>
        </td>
      </tr>
    </table>
</form>
<script>
    InitControlDataType();
</script>
</body>
</html>
