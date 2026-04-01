<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!–[if IE 8]>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<![endif]–>
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_check.asp"></script>
<script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>
<script language="javascript" src="../../bbsp/common/qosinfoe8c.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<title>qos</title>
<script language="JavaScript" src="./<%HW_WEB_CleanCache_Resource(muljsdiff.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, qos_language);%>"></script>
<script language="JavaScript" type="text/javascript">

var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var E8CQoSMode = "<% HW_WEB_GetFeatureSupport(BBSP_FT_UPLINKQOS);%>";
var STBPort = '<%HW_WEB_GetSTBPort();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var QueueNum = 8;
var AppListMax = 2;
var ClassListMax = 16;
var ClassTypeItemMax = 4;
var TotoalTypeListMax = ClassTypeItemMax * ClassListMax;
var appIdx = -1;
var classIdx = -1;
var classtypeIdx = -1;
var dataclassIdx = -1;
var DataClassListMax = 3;
var Customz_CMCC_RMS = "<% HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>";
var TianYiFlag = "<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>";

function isPortInAttrName()
{
    if ((TianYiFlag == 1) && (CurrentBin.toUpperCase() == 'E8C')) {
        return true;
    }
    return false;
}

function stWlan(Domain, name, enable, freq)
{
    this.Domain = Domain;
    this.name = name;
    this.enable = enable;
    this.freq = freq;
}

function QosClassificationInfoAdaptor(rawList)
{
    var newList = new Array();

    for (var i = 0; i < rawList.length - 1; i++)
    {
        if (rawList[i].Type == "WANInterface") {
                var macId = WanPath2WanMacId(rawList[i].Min.toUpperCase());
                if (macId) {
                    rawList[i].MinShow = "WAN" + macId;
                    rawList[i].MaxShow = "WAN" + macId;
                } else {
                    continue;
                }
        }
        newList.push(rawList[i]);
    }
    newList.push(null);
    return newList;
}
var QosBasicInfoList = GetQosBasicInfoList();
var QosMode = "";
if (QosBasicInfoList[0] == null) {
    QosMode = 'OTHER';
} else {
    QosMode = QosBasicInfoList[0].X_HW_Mode;
}
var AppInfoList = GetAppInfoList();
var ClassificationInfoList = GetClassificationInfoList();
var ClassificationTypeInfoList = GetClassificationTypeInfoList();
ClassificationTypeInfoList = QosClassificationInfoAdaptor(ClassificationTypeInfoList);

var PriorityQueueInfoList = GetPriorityQueueInfoList();
var SortAppIdList = new Array();
SortAppIdList = GetSortAppInfoList();
var SortClassIdList = new Array();
SortClassIdList = GetSortClassInfoList();
var TopoInfo = GetTopoInfo();
var wlanList = '<%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|X_HW_RFBand,stWlan);%>';
if (wlanList !== '') {
    wlanList = dealDataWithStr(wlanList);
}
var IsSupportWLAN = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var isDoubleFreq = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
if (IsSupportWLAN == 0) {
    var WlanInfoList = new Array(null);
} else {
    var WlanInfoList = wlanList;
    if (isDoubleFreq != 1) {
        WlanInfoList = new Array();
        for (var i = 0; i < wlanList.length - 1; i++) {
            if (wlanList[i].freq == '2.4GHz') {
                WlanInfoList.push(wlanList[i]);
            }
        }
        WlanInfoList.push(null);
    }
}

function selectRemoveCnt(curCheck)
{

}
 
function setCtlDisplayApp(record)
{
    if (record.Domain == '') {
        setDisplay('AppDataFlowIdTr', 0);
        setSelect("App_select", "");
        setSelect("AppQueue_select", "1");
        setSelect("DataFlow_select", "");
    } else {
        setDisplay('AppDataFlowIdTr', 1);
        setSelect("App_select", record.AppName);
        setSelect("AppQueue_select", record.ClassQueue);
        setSelect("DataFlow_select", record.AppId);
    }
}

function getFindIndexByClassTypeId(ClassTypeId,DataClasslist)
{
    var Index = -1;
    for (var i = 0; i < DataClasslist.length; i++) {
        if (ClassTypeId == DataClasslist[i].ClassificationTypeId) {
            Index = i;
            return Index;
        }
    }
    return Index;
}

function setCtlDisplayDataClass(record)
{
    var className = "";
    var minName = "";
    var maxName = "";
    var protocolName = "";
    var minRow = "";
    var maxRow = "";
    var LANstartSelect = "";
    var LANendSelect = "";
    LANstartPort = "";
    LANendPort = "";
    if (record.Domain == '') {
        setDisplay('DataClassIdListTr', 0);
        if (ClassificationInfoList.length - 1 > 0) {
            setSelect("DataClassIdList", SortClassIdList[0]);
        } else if (ClassificationInfoList.length == 1) {
            setSelect("DataClassIdList", "");
        }
        setSelect("ClassificationQueue_select", "1");
        if ((QosBasicInfoList[0] != null) && (QosBasicInfoList[0].X_HW_EnableDSCPMark == 1)) {
            setDisplay('DSCPMarkValueTr', 1);
        } else {
            setDisplay('DSCPMarkValueTr', 0);
        }
        setText("DSCPMarkValue_text", "");
        if ((QosBasicInfoList[0] != null) && (QosBasicInfoList[0].X_HW_Enable8021p == 2)) {
            setDisplay('8021_PMarkValueTr', 1);
        } else {
            setDisplay('8021_PMarkValueTr', 0);
        }
        setText("8021_PMarkValue_text", "");
        for (var i = 1; i <= DataClassListMax; i++) {
            className = "Type" + i + "_select";
            protocolName = "Type"+ i +"Protocol_select";
            minRow = "Type" + i + "_trMin";
            maxRow = "Type" + i + "_trMax";
            minName = "Type" + i + "MinValue_text";
            maxName = "Type" + i + "MaxValue_text";
            LANstartPort = "Type" + i + "_LANstart";
            LANendPort = "Type" + i + "_LANend";
            setDisplay(LANstartPort, 0);
            setDisplay(LANendPort, 0);
            setDisplay(minRow, 1);
            setDisplay(maxRow, 1);
            setSelect(className, "FIRST_TYPE");
            setText(minName, "");
            setText(maxName, "");
            getElById(minName).title = "";
            getElById(maxName).title = "";
            setSelect(protocolName, "TCP");
        }
        setCheck("DSCPListEnable_checkbox", 1);
        changeEnableList();
    } else {
        setDisplay('DataClassIdListTr', 1);
        setSelect("DataClassIdList", record.ClassificationId);
        setSelect("ClassificationQueue_select", record.ClassQueue);
        if ((QosBasicInfoList[0] != null) && (QosBasicInfoList[0].X_HW_EnableDSCPMark == 1)) {
            setDisplay('DSCPMarkValueTr', 1);
        } else {
            setDisplay('DSCPMarkValueTr', 0);
        }
        setText("DSCPMarkValue_text", record.DSCPMarkValue);

        if ((QosBasicInfoList[0] != null) && (QosBasicInfoList[0].X_HW_Enable8021p == 2)) {
            setDisplay('8021_PMarkValueTr', 1);
        } else {
            setDisplay('8021_PMarkValueTr', 0);
        }
        setText("8021_PMarkValue_text", record.PriorityValue);
        var DataClasslist = getDataClassByClassificationId(record.ClassificationId);
        for (var i = 1; i <= DataClassListMax; i++) {
            protocolName = "Type" + i + "Protocol_select";
            className = "Type" + i + "_select";
            minName = "Type" + i + "MinValue_text";
            maxName = "Type" + i + "MaxValue_text";
            minRow = "Type" + i + "_trMin";
            maxRow = "Type" + i + "_trMax";
            LANstartPort = "Type" + i + "_LANstart";
            LANendPort = "Type" + i + "_LANend";
            LANstartSelect = "Type" + i + "LANstart_select";
            LANendSelect = "Type" + i + "LANend_select";
            var Index = getFindIndexByClassTypeId(i,DataClasslist);
            if (Index == -1) {
                setSelect(className, "FIRST_TYPE");
                setDisplay(LANstartPort, 0);
                setDisplay(LANendPort, 0);
                setDisplay(minRow, 1);
                setDisplay(maxRow, 1);
                setText(minName, "");
                setText(maxName, "");
                getElById(minName).title = "";
                getElById(maxName).title = "";
                setSelect(protocolName, "TCP");
                continue;
            }
            setSelect(className, DataClasslist[Index].Type);
            if ((getSelectVal(className) == "LANInterface") && (isPortInAttrName())) {
                setDisplay(LANstartPort, 1);
                setDisplay(LANendPort, 1);
                setDisplay(minRow, 0);
                setDisplay(maxRow, 0);
            } else {
                setDisplay(LANstartPort, 0);
                setDisplay(LANendPort, 0);
                setDisplay(minRow, 1);
                setDisplay(maxRow, 1);
            }
            LanTopoRangeInfo = getLanTopoRange();
            if (DataClasslist[Index].Type == "LANInterface") {
                setQosClassType(className);
                if (isPortInAttrName()) {
                    setSelect(LANstartSelect, DataClasslist[Index].MinShow);
                    setSelect(LANendSelect, DataClasslist[Index].MaxShow);
                } else {
                    setText(minName, DataClasslist[Index].MinShow);
                    setText(maxName, DataClasslist[Index].MaxShow);
                    getElById(minName).title = qos_language['bbsp_startlanrange'] + LanTopoRangeInfo + qos_language['bbsp_classtypelantitle'];
                    getElById(maxName).title = qos_language['bbsp_endlanrange'] + LanTopoRangeInfo + qos_language['bbsp_classtypelantitle'];
                }
            } else if (DataClasslist[Index].Type == "WANInterface") {
                setText(minName, DataClasslist[Index].MinShow);
                setText(maxName, DataClasslist[Index].MaxShow);
                getElById(minName).title = qos_language['bbsp_classtypewantitle'];
                getElById(maxName).title = qos_language['bbsp_classtypewantitle'];
            } else if ((getSelectVal(className) == "FL") || (getSelectVal(className) == "TC")) {
                setQosClassType(className);
                if (getSelectVal(className) == "FL") {
                    setText(minName, DataClasslist[Index].Min);
                    setText(maxName, DataClasslist[Index].Max);
                    getElById(minName).title = qos_language['bbsp_flprnote'];
                    getElById(maxName).title = qos_language['bbsp_flprnote'];
                } else if (getSelectVal(className) == "TC") {
                    setText(minName, DataClasslist[Index].Min);
                    setText(maxName, DataClasslist[Index].Max);
                    getElById(minName).title = "";
                    getElById(maxName).title = "";
                }
            } else {
                setText(minName, DataClasslist[Index].Min);
                setText(maxName, DataClasslist[Index].Max);
                getElById(minName).title = "";
                getElById(maxName).title = "";
            }
            setSelect(protocolName, DataClasslist[Index].ProtocolList);
        }
        setCheck("DSCPListEnable_checkbox", record.ClassQueueEnable);
        changeEnableList();
    }
}

function setControlApp(index)
{
    var record;
    appIdx = index;

    if (index == -1) {
        if (AppInfoList.length - 1 >= AppListMax) {
            setDisplay('QosAppConfigForm', 0);
            AlertEx(qos_language['bbsp_AppFull']);
            return;
        } else {
            record = new AppInfo('','','','');
            setQosAppDisplay(1);
            setCtlDisplayApp(record);
        }
    } else if (index == -2) {
        setQosAppDisplay(0);
    } else {
        record = AppInfoList[index];
        setQosAppDisplay(1);
        setCtlDisplayApp(record);
    }
}
function LaninterfaceNotDispaly()
{
    setDisplay("Type1_LANstart",0);
    setDisplay("Type1_LANend",0);
    setDisplay("Type2_LANstart",0);
    setDisplay("Type2_LANend",0);
    setDisplay("Type3_LANstart",0);
    setDisplay("Type3_LANend",0);
}
function setControlDataClass(index)
{
    var record;
    dataclassIdx = index;

    if (index == -1) {
        if (ClassificationInfoList.length - 1 >= ClassListMax) {
            setQosDataClassDisplay(0);
            AlertEx(qos_language['bbsp_ClassFull']);
            return;
        } else {
            record = new ClassificationInfo('','','','','', 1);
            setQosDataClassDisplay(1);
            setCtlDisplayDataClass(record);
        }
    } else if (index == -2) {
        setQosDataClassDisplay(0);
        LaninterfaceNotDispaly();
    } else {
        record = ClassificationInfoList[index];
        setQosDataClassDisplay(1);
        setCtlDisplayDataClass(record);
    }
}

function IsClassIdBind(idx)
{
    var classId = ClassificationInfoList[idx].ClassificationId;
    if (ClassificationTypeInfoList.length == 1) {
        return false;
    } else if (ClassificationTypeInfoList.length > 1) {
        for (var i = 0; i < ClassificationTypeInfoList.length - 1; i++) {
            if (ClassificationTypeInfoList[i].ClassificationId == classId) {
                return true;
            }
        }
    }
    return false;
}

function clickRemoveApp() 
{
    if ((AppInfoList.length - 1) == 0) {
        AlertEx(qos_language['bbsp_noApp']);
        document.getElementById("QosApp_DeleteButton").disabled = false;
        return;
    }

    var QosApprm1 = getElement('QosApp_rml');
    var noChooseFlag = true;
    if (QosApprm1.length > 0) {
        for (var i = 0; i < QosApprm1.length; i++) {
            if (QosApprm1[i].checked == true) {
                noChooseFlag = false;
            }
        }
    } else if (QosApprm1.checked == true) {
        noChooseFlag = false;
    }
    if (noChooseFlag) {
        AlertEx(qos_language['bbsp_selecApp']);
        document.getElementById("QosApp_DeleteButton").disabled = false;
        return ;
    }

    if (ConfirmEx(qos_language['bbsp_confirmApp']) == false) {
        document.getElementById("QosApp_DeleteButton").disabled = false;
        return;
    }
    setDisable('btnAppApply', 1);
    setDisable('btnAppCancel', 1);
    removeInst('QosApp', 'html/application/qos.asp');
}

function clickRemove(tabTitle) 
{
    switch(tabTitle) {
        case "QosApp":
            clickRemoveApp();
            break;
        default:
            break;
    }
}

function QosBasicBindPageData()
{
    if (QosBasicInfoList[0] == null) {
        if (E8CQoSMode == 1) {
            setText("Bandwidth", 0);
            setSelect("QoSPlan_select", "priority");
            getElement('DSCPMarkEnable_checkbox').checked = false;
            setCheck('EnableForceWeight',0);
            setSelect("8021_PMarkType_select", "0");
        }
    } else {
        if (E8CQoSMode == 1) {
            setText("Bandwidth", parseInt(QosBasicInfoList[0].X_HW_Bandwidth,10));
            setSelect("QoSPlan_select", QosBasicInfoList[0].X_HW_Plan);
            if (QosBasicInfoList[0].X_HW_EnableDSCPMark == 1) {
                getElement('DSCPMarkEnable_checkbox').checked = true;
            } else {
                getElement('DSCPMarkEnable_checkbox').checked = false;
            }
            if (QosBasicInfoList[0].X_HW_Plan == "weight") {
                setCheck('EnableForceWeight',QosBasicInfoList[0].X_HW_EnableForceWeight);
            }
            setSelect("8021_PMarkType_select", QosBasicInfoList[0].X_HW_Enable8021p);
        }
    }
}

function getQueueIndex(index)
{
    var QueueIndex = '';
    if (PriorityQueueInfoList[index].Domain.length == 0) {
        QueueIndex = PriorityQueueInfoList[index].Priority;
    } else {
        QueueIndex = PriorityQueueInfoList[index].Domain.charAt(PriorityQueueInfoList[index].Domain.length - 1);
    }
    return QueueIndex;
}

function DisplayQueueEnable(plan)
{
    var QueueId = "";
    var WeightId = "";

    for (var i = 0; i < PriorityQueueInfoList.length; i++) {
        if (plan == "weight") {
            QueueId = 'WRRRecord' + i;
            var QueueIndex = getQueueIndex(i);
            WeightId = 'Q' + QueueIndex + 'Weight_text';
            setCheck(QueueId,PriorityQueueInfoList[i].Enable);
            setText(WeightId, PriorityQueueInfoList[i].Weight);
        } else {
            QueueId = 'SPRecord' + i;
            setCheck(QueueId,PriorityQueueInfoList[i].Enable);
        }
    }
}

function QMBindPageData()
{
    if (PriorityQueueInfoList != null) {
        for (var i = 0; i < PriorityQueueInfoList.length; i++) {
            var QueueId = "";
            var WeightId = "";
            if (QosBasicInfoList[0] == null) {
                QueueId = 'SPRecord' + i;
                setCheck(QueueId,PriorityQueueInfoList[i].Enable);
            } else {
                DisplayQueueEnable(QosBasicInfoList[0].X_HW_Plan);
            }
        }
    }
}

function setQosAppDisplay(flag)
{
    if (flag == 0) {
        setDisplay('QosAppConfigForm', 0);
        setDisable('AppModifySubmit_button', 1);
        setDisable('AppAddSubmit_button', 0);
        setDisable('AppDeleteSubmit_button', 1);
        setDisable('AppCancelSubmit_button', 1);
    } else if (flag == 1) {
        setDisplay('QosAppConfigForm', 1);
        setDisable('AppModifySubmit_button', 0);
        setDisable('AppAddSubmit_button', 0);
        setDisable('AppDeleteSubmit_button', 0);
        setDisable('AppCancelSubmit_button', 0);
    }
}

function AppBindPageData()
{
    if (AppInfoList.length - 1 == 0) {
        selectLine('QosApp_record_no');
        setQosAppDisplay(0);
    } else {
        selectLine('QosApp_record_0');
        setQosAppDisplay(1);
    }
}

function setQosDataClassDisplay(flag)
{
    if (flag == 0) {
        setDisable('ClassificationModifySubmit_button', 1);
        setDisable('ClassificationAddSubmit_button', 0);
        setDisable('ClassificationDeleteSubmit_button', 1);
        setDisable('btnQosDataClassCancel', 1);
    } else if (flag == 1) {
        setDisable('ClassificationModifySubmit_button', 0);
        setDisable('ClassificationAddSubmit_button', 0);
        setDisable('ClassificationDeleteSubmit_button', 0);
        if ((ClassificationInfoList.length > 1) && (dataclassIdx != -1))
        {
            setDisable('btnQosDataClassCancel',1);
        }
        else
        {
            setDisable('btnQosDataClassCancel',0);
        }
    }

    if ((null != QosBasicInfoList[0]) && (1 == QosBasicInfoList[0].X_HW_EnableDSCPMark)) {
        setDisplay('DSCPMarkValueTr',1);
    } else {
        setDisplay('DSCPMarkValueTr',0);
    }
    if ((null != QosBasicInfoList[0]) && (2 == QosBasicInfoList[0].X_HW_Enable8021p)) {
        setDisplay('8021_PMarkValueTr',1);
    } else {
        setDisplay('8021_PMarkValueTr',0);
    }
}

function DataClassBindPageData()
{
    if (ClassificationInfoList.length - 1 == 0)
    {
        QosDataselectLine('QosDataClass_N0_record_no');
        setQosDataClassDisplay(0);
    }
    else
    {
        var DataClasslist = new Array();
        DataClasslist = getDataClassByClassificationId(ClassificationInfoList[0].ClassificationId);
        var ClassNum = DataClasslist.length;
        var id = "";
        if (ClassNum == 0)
        {
            id = 'QosDataClass_' + 'N1' + '_' + 'record_' + 0 + '_0';
        }
        else
        {
            id = 'QosDataClass_' + 'N' + ClassNum + '_' + 'record_' + 0 + '_0';
        }
        QosDataselectLine(id);
        setQosDataClassDisplay(1);
    }
}

function setQosBasicDisplay(enableFlag)
{
    if (enableFlag == 0)
    {
        document.getElementById("PlanRow").style.display = "none";
        document.getElementById("EnableDSCPMarkRow").style.display = "none";
        document.getElementById("EnableForceWeightRow").style.display = "none";
        document.getElementById("Enable8021pRow").style.display = "none";
    }
    else if (enableFlag == 1)
    {
        document.getElementById("PlanRow").style.display = "";
        document.getElementById("EnableDSCPMarkRow").style.display = "";
        document.getElementById("EnableForceWeightRow").style.display = "";
        document.getElementById("Enable8021pRow").style.display = "";
    }
}

function AddPriorityQueueInstance(Id)
{
    var InstanceId = Id + 1;
    if (PriorityQueueInfoList[Id].Domain != '')
    {
        return ;
    }

    $.ajax({
    type : "POST",
    async : false,
    cache : false,
    data : 'o.Enable=' + PriorityQueueInfoList[Id].Enable + '&o.Priority=' + PriorityQueueInfoList[Id].Priority 
           + '&o.Weight=' + PriorityQueueInfoList[Id].Weight + '&x.X_HW_Token=' + getValue('onttoken'),
    url :  'add.cgi?o=InternetGatewayDevice.X_HW_UplinkQos.PriorityQueue'
      + '&RequestFile=html/application/not_find_file.asp',
    error:function(XMLHttpRequest, textStatus, errorThrown) 
    {
        if (XMLHttpRequest.status == 404)
        {
            PriorityQueueInfoList[Id].Domain = 'InternetGatewayDevice.X_HW_UplinkQos.PriorityQueue'+ InstanceId;
        }
    }
    });
}

function setQosWebDisplay()
{
    setQosBasicDisplay(1);
    setDisplay("DivApp",1);
    setDisplay("DivQueueManagement",1);
    setDisplay("DivQosDataClass",1);

    QMBindPageData();
    AppBindPageData();
    DataClassBindPageData();

}

function LoadFrame()
{
    if (QosBasicInfoList[0] == null) {
        if (E8CQoSMode == 1) {
            setDisplay("EnableForceWeightRow",0);
        }
    } else {
        if ((E8CQoSMode == 1) && (QosBasicInfoList[0].X_HW_Mode == "OTHER"))
        {
            if (QosBasicInfoList[0].X_HW_Plan == "weight")
            {
                setDisplay("EnableForceWeightRow", 1);
            }
            else
            {
                setDisplay("EnableForceWeightRow", 0);
            }
        }
    }
    setQosWebDisplay();
    QosBasicBindPageData();
    setDisplay('QosApp_Newbutton', 0);
    setDisplay('QosApp_DeleteButton', 0);
    setDisplay('QosDataClass_Newbutton', 0);
    setDisplay('QosDataClass_DeleteButton', 0);
}

function setQosPlan()
{
    var Plan = getSelectVal('QoSPlan_select');
    if (Plan == "weight")
    {
        setDisplay("DivSP", 0);
        setDisplay("DivWRR", 1);
        setDisplay("EnableForceWeightRow", 1);
    }
    else
    {
        setDisplay("DivSP", 1);
        setDisplay("DivWRR", 0);
        setDisplay("EnableForceWeightRow", 0);
    }
    DisplayQueueEnable(Plan);
}

function setprotocolListDisplay(id,type)
{
    var ClassId = id.charAt(4);
    var protocolName = "Type" + ClassId + "Protocol_select";
    var protocolList = getElementById(protocolName);
    
    if ((type == "FL") || (type == "TC"))
    {
        RemoveItemFromSelect(protocolList , qos_language['bbsp_ICMP']);
        RemoveItemFromSelect(protocolList , qos_language['bbsp_ICMPv6']);
    }
    else
    {
        protocolList.options.length = 0;
        protocolList.options.add(new Option(qos_language['bbsp_TCP'],"TCP"));
        protocolList.options.add(new Option(qos_language['bbsp_UDP'],"UDP"));
        protocolList.options.add(new Option(qos_language['bbsp_ICMP'],"ICMP"));
        protocolList.options.add(new Option(qos_language['bbsp_ICMPv6'],"ICMPv6"));
        protocolList.options.add(new Option(qos_language['bbsp_RTP'],"RTP"));
        protocolList.options.add(new Option(qos_language['bbsp_TCPUDP'],"TCP,UDP"));
        protocolList.options.add(new Option(qos_language['bbsp_ALL'],""));
    }
}
function Insertoptions(startid,endid)
{
    var LANPortStartList = getElementById(startid);
    var LANPortEndList = getElementById(endid);
    if (LANPortStartList.length > 0)
    {
        return;
    }
    var portNum = 0;
    var LANInst;
    var acEthType = '<%HW_WEB_GetEthTypeList();%>';
    portNum = parseInt(acEthType.charAt(0), 10);

    for (var i=1; i <= portNum; i++)
    {
        LANInst= getTianYilandesc(i);
        if ((2 == i) && (0 == STBPort) && CfgMode.toUpperCase() != 'GZGD')
        {
            LANInst = "iTV";
        }
        if ((5 == i) && ('1' == IponlyFlg))
        {
            LANInst = "EXT1";
        }
        if (i == STBPort)
        {
            LANInst = "STB"; 
        }
        LANPortStartList.options.add(new Option(LANInst, LANInst));
        LANPortEndList.options.add(new Option(LANInst, LANInst));
    }
    var ArrWlan = [];
    for (var i =0; i < WlanInfoList.length -1; i++)
    {
        ArrWlan.push(parseInt(WlanInfoList[i].Domain.charAt(WlanInfoList[i].Domain.length -1),10));
    }
    ArrWlan.sort();
    for (var j = 0; j < ArrWlan.length; j++)
    {
        ssidins = "SSID" + ArrWlan[j];
        LANPortStartList.options.add(new Option(ssidins, ssidins));
        LANPortEndList.options.add(new Option(ssidins, ssidins));
    }
}
function setQosClassType(id)
{
    var ClassId = id.charAt(4);
    var className = "Type" + ClassId + "_select";
    var minName = "Type" + ClassId + "MinValue_text";
    var maxName = "Type" + ClassId + "MaxValue_text";

    var minRow = "Type" + ClassId + "_trMin";
    var maxRow = "Type" + ClassId + "_trMax";
    var LANstartPort = "Type" + ClassId + "_LANstart";
    var LANendPort = "Type" + ClassId + "_LANend";
    var LANstartSelect = "Type" + ClassId + "LANstart_select";
    var LANendSelect = "Type" + ClassId + "LANend_select";
    setText(minName,'');
    setText(maxName,'');
    var LanTopoRangeInfo = "";
    LanTopoRangeInfo = getLanTopoRange();

    setDisplay(LANstartPort,0);
    setDisplay(LANendPort,0);
    setDisplay(minRow,1);
    setDisplay(maxRow,1);
    if (getSelectVal(className) == "LANInterface")
    {
        if (isPortInAttrName())
        {
            setDisplay(LANstartPort, 1);
            setDisplay(LANendPort, 1);
            setDisplay(minRow, 0);
            setDisplay(maxRow, 0);
            Insertoptions(LANstartSelect,LANendSelect);
        }
        else
        {
            getElById(minName).title = qos_language['bbsp_startlanrange'] + LanTopoRangeInfo + qos_language['bbsp_classtypelantitle'];
            getElById(maxName).title = qos_language['bbsp_endlanrange'] + LanTopoRangeInfo + qos_language['bbsp_classtypelantitle'];
            setprotocolListDisplay(id,getSelectVal(className));
        }
    }
    else if (getSelectVal(className) == "WANInterface")
    {
        getElById(minName).title = qos_language['bbsp_classtypewantitle'];
        getElById(maxName).title = qos_language['bbsp_classtypewantitle'];
        setprotocolListDisplay(id,getSelectVal(className));
    }
    else if (getSelectVal(className) == "FL")
    {
        getElById(minName).title = qos_language['bbsp_flprnote'];
        getElById(maxName).title = qos_language['bbsp_flprnote'];
        setprotocolListDisplay(id,getSelectVal(className));
    }
    else
    {
        getElById(minName).title = "";
        getElById(maxName).title = "";
        setprotocolListDisplay(id,getSelectVal(className));
    }
}

function IsQosModeOther()
{
    if (QosBasicInfoList[0] == null)
    {
        AlertEx(qos_language['bbsp_qosmodenull']);
        return false;
    }
    return true;
}

function OnQMApply()
{
    if (IsQosModeOther() == false)
    {
        return false;
    }

    var Plan = getSelectVal('QoSPlan_select');
    var DSCPMarkEnable = (true == getElement('DSCPMarkEnable_checkbox').checked) ? 1 : 0;
    var url = "";
    var weightSum = 0;
    var weightVal = "";
    var QueueId = "";
    var queuewightId = "";
    var i;
    var Form = new webSubmitForm();
    
    if (E8CQoSMode ==1)
    {
        var Bandwidth = getValue("Bandwidth");
        Bandwidth = removeSpaceTrim(Bandwidth);
        if (Bandwidth!="")
        {
           if (false == CheckNumber(Bandwidth, 0, 1048576))
           {
             AlertEx(qos_language['bbsp_bandwidthinvaild']);
             return false;
           }
        }
        else
        {
           Bandwidth = 0;
        }
        Bandwidth = parseInt(Bandwidth,10);
    }

    Form.addParameter('x.X_HW_Plan',Plan);
    if (Plan == "weight")
    {
        Form.addParameter('x.X_HW_EnableForceWeight',getCheckVal('EnableForceWeight'));
    }
    Form.addParameter('x.X_HW_Bandwidth',Bandwidth);
    Form.addParameter('x.X_HW_EnableDSCPMark',DSCPMarkEnable);
    Form.addParameter('x.X_HW_Enable8021p',getSelectVal('8021_PMarkType_select'));

    if (Plan == "weight")
    {
        var SelectedQueueNr = 0;

        for (var j = 0; j < QueueNum; j++) 
        {
            QueueId = 'WRRRecord' + j;

            var QueueIndex = getQueueIndex(j);
            queuewightId = 'Q' + QueueIndex + 'Weight_text';
            if (getCheckVal(QueueId) == 1)
            {
                weightVal = getValue(queuewightId);
                weightVal = removeSpaceTrim(weightVal);
                if (weightVal!="")
                {
                   if (false == CheckNumber(weightVal, 0, 100))
                   {
                     AlertEx(qos_language['bbsp_weightRange']);
                     return false;
                   }
                }
                else
                {
                   weightVal = 0;
                }

                SelectedQueueNr++;
                weightSum += parseInt(weightVal, 10);
            }
        }

        if (weightSum != 100 && SelectedQueueNr > 0)
        {
            AlertEx(qos_language['bbsp_weightsummsg']);
            return false;
        }
    }

    for (i = 0; i < QueueNum; i++) 
    {
        if (Plan == "weight")
        {
            QueueId = 'WRRRecord' + i;
            var QueueIndex = getQueueIndex(i);
            queuewightId = 'Q' + QueueIndex + 'Weight_text';
            weightVal = getValue(queuewightId);
            if (weightVal == "")
            {
                weightVal = 0;
            }
            else
            {
                weightVal = parseInt(weightVal, 10);
            }
            Form.addParameter('y'+i+'.Weight', weightVal);
        }
        else
        {
            QueueId = 'SPRecord' + i;
        }
        Form.addParameter('y'+i+'.Enable', getCheckVal(QueueId));
        Form.addParameter('y'+i+'.Priority', i+1);
        url += "&y" + i + "=InternetGatewayDevice.X_HW_UplinkQos.PriorityQueue." + (i+1);
    }
    
    for (i = 0; i < QueueNum; i++)
    {
        AddPriorityQueueInstance(i);
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('complex.cgi?' + '&x=InternetGatewayDevice.QueueManagement' + url + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    setDisable('btnQMApply',1);
    Form.submit();
}

function IsRepeateAppConfig()
{
    for (var i = 0; i < AppInfoList.length - 1; i++)
    {
        if (i != appIdx)
        {
            if (getSelectVal('App_select') == "")
            {
                if ((AppInfoList[i].AppName == getSelectVal('App_select'))
                    && (AppInfoList[i].ClassQueue == getSelectVal('AppQueue_select')))
                {
                    AlertEx(qos_language['bbsp_appruleexist']);
                    return true;
                }
            }
            else
            {
                if (AppInfoList[i].AppName == getSelectVal('App_select'))
                {
                    AlertEx(qos_language['bbsp_appnameexist'] + AppInfoList[i].AppName + qos_language['bbsp_appruleexist1']);
                    return true;
                }
            }
        }
    }
    return false;
}

function IsRepeateClassConfig(ClassDhcp)
{
    for (var i = 0; i < ClassificationInfoList.length - 1; i++)
    {
        if (i != classIdx)
        {
            if ((ClassificationInfoList[i].ClassQueue == getSelectVal('ClassQueueList'))
                && (ClassificationInfoList[i].DSCPMarkValue == ClassDhcp)
                && (ClassificationInfoList[i].PriorityValue == getSelectVal('Class8021pList')))
            {
                return true;
            }
        }
    }
    return false;
}

function OnClassApply()
{
    if (IsQosModeOther() == false)
    {
        return false;
    }

    var ClassDhcp = getValue("ClassDhcp");
    ClassDhcp = removeSpaceTrim(ClassDhcp);

    if (ClassDhcp!="")
    {
       if (false == CheckNumber(ClassDhcp, 0, 63))
       {
         AlertEx(qos_language['bbsp_classdhcpinvaild']);
         return false;
       }
    }
    else
    {
       ClassDhcp = 0;
    }
    ClassDhcp = parseInt(ClassDhcp, 10);

    if (true == IsRepeateClassConfig(ClassDhcp))
    {
        AlertEx(qos_language['bbsp_classruleexist']);
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.ClassQueue',getSelectVal('ClassQueueList'));
    Form.addParameter('x.DSCPMarkValue',ClassDhcp);
    Form.addParameter('x.PriorityValue',getSelectVal('Class8021pList'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    if (classIdx == -1)
    {
        Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_UplinkQos.Classification' + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }
    else
    {
        Form.setAction('set.cgi?x=' + ClassificationInfoList[classIdx].Domain + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }

    Form.submit();
    DisableRepeatSubmit();
    setDisable('btnClassApply',1);
    setDisable('btnClassCancel',1);
}

function CancelConfig(tableID)
{
    var Index;
    var record;
    switch (tableID)
    {
        case "QosApp":
            Index = appIdx;
            setQosAppDisplay(0);
            break;
        case "QosDataClass":
            Index = dataclassIdx;
            setQosDataClassDisplay(0);
            break;
        default:
            break;
    }

    if (Index == -1)
    {
        var tableRow = getElement(tableID+"Inst");
        if (tableRow.rows.length == 1)
        {
        
        }
        else if (tableRow.rows.length == 2)
        {
            if ("QosApp" == tableID)
            {
                addNullInst(tableID);
            }
            else if ("QosDataClass" == tableID)
            {
                addNullInstQos(tableID);
            }
        }
        else
        {
            if ("QosApp" == tableID)
            {
                tableRow.deleteRow(tableRow.rows.length-1);
                  selectLine(tableID+'_record_0');
            }
            else if ("QosDataClass" == tableID)
            {
                tableRow.deleteRow(tableRow.rows.length-1);
                var DataClasslist = new Array();
                DataClasslist = getDataClassByClassificationId(ClassificationInfoList[0].ClassificationId);
                var ClassNum = DataClasslist.length;
                var id = "";
                if (ClassNum == 0)
                {
                    id = 'QosDataClass_' + 'N1' + '_' + 'record_' + 0 + '_0';
                }
                else
                {
                    id = 'QosDataClass_' + 'N' + ClassNum + '_' + 'record_' + 0 + '_0';
                }
                QosDataselectLine(id);
            }
        }
    }
    else
    {
        switch (tableID)
        {
            case "QosApp":
            {
                record = AppInfoList[Index];
                setCtlDisplayApp(record);
                break;
            }
            case "QosDataClass":
            {
                record = ClassificationInfoList[Index];
                setCtlDisplayDataClass(record);
                break;
            }
            default:
                break;
        }
    }
}

function CheckSMAC(MacStart, MacEnd)
{
    if (MacEnd != "" 
        && (MacAddress2DecNum(MacStart) > MacAddress2DecNum(MacEnd)))
    {
        AlertEx(qos_language['bbsp_startsmacinvalid']);
        return false; 
    }
    if (MacStart == "" && MacEnd != "") 
    {
        AlertEx(qos_language['bbsp_startsmacisreq']);
        return false;
    }
    return true;
}

function CheckDMAC(MacStart, MacEnd)
{
    if (MacEnd != "" 
        && (MacAddress2DecNum(MacStart) > MacAddress2DecNum(MacEnd)))
    {
        AlertEx(qos_language['bbsp_startdmacinvalid']);
        return false; 
    }
    if (MacStart == "" && MacEnd != "") 
    {
        AlertEx(qos_language['bbsp_startdmacisreq']);
        return false;
    }
    return true;
}
function Check8021P(PriStart, PriEnd)
{
    if ((PriStart != "") && (false == CheckNumber(PriStart, 0, 7)))
    {
        AlertEx(qos_language['bbsp_start8021Prange']);
        return false;
    }

    if ((PriEnd != "") && (false == CheckNumber(PriEnd, 0, 7)))
    {
        AlertEx(qos_language['bbsp_end8021Prange']);
        return false;
    }
    if (PriEnd != "" 
        && parseInt(PriStart, 10) > parseInt(PriEnd, 10))
    {
        AlertEx(qos_language['bbsp_start8021Pinvalid']);
        return false; 
    }
    if (PriStart == "" && PriEnd != "") 
    {
        AlertEx(qos_language['bbsp_start8021Pisreq']);
        return false;
    }
    return true;
}

function CheckIpv6Parameter(IPv6Address)
{
    if (IsIPv6AddressValid(IPv6Address) == false)
    {
        return false;
    }

    if (IsIPv6MulticastAddress(IPv6Address) == true)
    {
        return false;
    } 

    if (IsIPv6ZeroAddress(IPv6Address) == true) 
    {
        return false;
    }

    if (IsIPv6LoopBackAddress(IPv6Address) == true)
    {
        return false;
    }
    return true; 
}

function CheckSIP(IPStart, IPEnd)
{
    if (IPStart != "" && (isAbcIpAddress(IPStart) == false && CheckIpv6Parameter(IPStart) == false))
    {
        AlertEx(qos_language['bbsp_startsip'] + IPStart + qos_language['bbsp_isvalid']);
        return false;
    }
    if (IPEnd != "" && (isAbcIpAddress(IPEnd) == false && CheckIpv6Parameter(IPEnd) == false))
    {
        AlertEx(qos_language['bbsp_endsip'] + IPEnd + qos_language['bbsp_isvalid']);
        return false;
    }
    if ((isAbcIpAddress(IPStart) == true && CheckIpv6Parameter(IPEnd) == true)
        || (isAbcIpAddress(IPEnd) == true && CheckIpv6Parameter(IPStart) == true))
    {
        AlertEx(qos_language['bbsp_ipcollide']);
        return false;
    }
    if (IPEnd != "" 
        && (isAbcIpAddress(IPStart) == true)
        &&(IpAddress2DecNum(IPStart) > IpAddress2DecNum(IPEnd)))
    {
        AlertEx(qos_language['bbsp_startsipinvalid']);
        return false; 
    }
    if (IPEnd != ""
        && (CheckIpv6Parameter(IPStart) == true)
        && (isStartIpbigerEndIp(IPStart,IPEnd) == true))
    {
        AlertEx(qos_language['bbsp_startsipinvalid']);
        return false; 
    }
    if (IPStart == "" && IPEnd != "") 
    {
        AlertEx(qos_language['bbsp_startsipisreq']);
        return false;
    }
    return true;
}

function CheckDIP(IPStart, IPEnd)
{
    if (IPStart != "" && (isAbcIpAddress(IPStart) == false && CheckIpv6Parameter(IPStart) == false))
    {
        AlertEx(qos_language['bbsp_startdip'] + IPStart + qos_language['bbsp_isvalid']);
        return false;
    }
    if (IPEnd != "" && (isAbcIpAddress(IPEnd) == false && CheckIpv6Parameter(IPEnd) == false))
    {
        AlertEx(qos_language['bbsp_enddip'] + IPEnd + qos_language['bbsp_isvalid']);
        return false;
    }
    if ((isAbcIpAddress(IPStart) == true && CheckIpv6Parameter(IPEnd) == true)
        || (isAbcIpAddress(IPEnd) == true && CheckIpv6Parameter(IPStart) == true))
    {
        AlertEx(qos_language['bbsp_ipcollide']);
        return false;
    }
    if (IPEnd != "" 
        && (isAbcIpAddress(IPStart) == true)
        &&(IpAddress2DecNum(IPStart) > IpAddress2DecNum(IPEnd)))
    {
        AlertEx(qos_language['bbsp_startdipinvalid']);
        return false; 
    }    
    if (IPEnd != ""
        && (CheckIpv6Parameter(IPStart) == true)
        && (isStartIpbigerEndIp(IPStart,IPEnd) == true))
    {
        AlertEx(qos_language['bbsp_startdipinvalid']);
        return false; 
    }

    if (IPStart == "" && IPEnd != "") 
    {
        AlertEx(qos_language['bbsp_startdipisreq']);
        return false;
    }
    return true;
}

function CheckSPORT(PortStart, PortEnd)
{
    if ((PortStart != "") && (false == CheckNumber(PortStart, 1, 65535)))
    {
        AlertEx(qos_language['bbsp_startsportrange']);
        return false;
    }

    if ((PortEnd != "") && (false == CheckNumber(PortEnd, 1, 65535)))
    {
        AlertEx(qos_language['bbsp_endsportrange']);
        return false;
    }

     if (PortEnd != "" 
        && parseInt(PortStart, 10) > parseInt(PortEnd, 10))
    {
        AlertEx(qos_language['bbsp_startsportinvalid']);
        return false; 
    }    
    if (PortStart == "" && PortEnd != "") 
    {
        AlertEx(qos_language['bbsp_startsportisreq']);
        return false;
    }
    return true;
}

function CheckDPORT(PortStart, PortEnd)
{
    if ((PortStart != "") && (false == CheckNumber(PortStart, 1, 65535)))
    {
        AlertEx(qos_language['bbsp_startdportrange']);
        return false;
    }

    if ((PortEnd != "") && (false == CheckNumber(PortEnd, 1, 65535)))
    {
        AlertEx(qos_language['bbsp_enddportrange']);
        return false;
    }
    if (PortEnd != "" 
        && parseInt(PortStart, 10) > parseInt(PortEnd, 10))
    {
        AlertEx(qos_language['bbsp_startdportinvalid']);
        return false; 
    }
    if (PortStart == "" && PortEnd != "") 
    {
        AlertEx(qos_language['bbsp_startdportisreq']);
        return false;
    }
    return true;
}

function CheckTOS(TosStart, TosEnd)
{
    if ((TosStart != "") && (false == CheckNumber(TosStart, 0, 7)))
    {
        AlertEx(qos_language['bbsp_starttosrange']);
        return false;
    }

    if ((TosEnd != "") && (false == CheckNumber(TosEnd, 0, 7)))
    {
        AlertEx(qos_language['bbsp_endtosrange']);
        return false;
    }
    if (TosEnd != "" 
        && parseInt(TosStart, 10) > parseInt(TosEnd, 10))
    {
        AlertEx(qos_language['bbsp_starttosinvalid']);
        return false; 
    }
    if (TosStart == "" && TosEnd != "") 
    {
        AlertEx(qos_language['bbsp_starttosisreq']);
        return false;
    }
    return true;
}

function CheckDSCP(DhcpStart, DhcpEnd)
{
    if ((DhcpStart != "") && (false == CheckNumber(DhcpStart, 0, 63)))
    {
        AlertEx(qos_language['bbsp_startdhcprange']);
        return false;
    }

    if ((DhcpEnd != "") && (false == CheckNumber(DhcpEnd, 0, 63)))
    {
        AlertEx(qos_language['bbsp_enddhcprange']);
        return false;
    }
    if (DhcpEnd != "" 
        && parseInt(DhcpStart, 10) > parseInt(DhcpEnd, 10))
    {
        AlertEx(qos_language['bbsp_startdhcpinvalid']);
        return false; 
    }    
    if (DhcpStart == "" && DhcpEnd != "") 
    {
        AlertEx(qos_language['bbsp_startdhcpisreq']);
        return false;
    }
    return true;
}

function CheckTC(TCStart, TCEnd)
{
    if ((TCStart != "") && (false == CheckNumber(TCStart, 0, 7)))
    {
        AlertEx(qos_language['bbsp_starttcrange']);
        return false;
    }

    if ((TCEnd != "") && (false == CheckNumber(TCEnd, 0, 7)))
    {
        AlertEx(qos_language['bbsp_endtcrange']);
        return false;
    }
    if (TCEnd != "" 
        && parseInt(TCStart, 10) > parseInt(TCEnd, 10))
    {
        AlertEx(qos_language['bbsp_starttcinvalid']);
        return false; 
    }
    if (TCStart == "" && TCEnd != "") 
    {
        AlertEx(qos_language['bbsp_starttcisreq']);
        return false;
    }
    return true;
}

function CheckFL(FLStart, FLEnd)
{
    if ((FLStart != "") && (false == CheckNumberHex(FLStart, 0, 'fffff')))
    {
        AlertEx(qos_language['bbsp_startflrange']);
        return false;
    }

    if ((FLEnd != "") && (false == CheckNumberHex(FLEnd, 0, 'fffff')))
    {
        AlertEx(qos_language['bbsp_endflrange']);
        return false;
    }
    if (FLEnd != "" 
        && parseInt(FLStart, 16) > parseInt(FLEnd, 16))
    {
        AlertEx(qos_language['bbsp_startflinvalid']);
        return false; 
    }
    if (FLStart == "" && FLEnd != "") 
    {
        AlertEx(qos_language['bbsp_startflisreq']);
        return false;
    }
    return true;
}
function CheckIPVER(IPVERStart, IPVEREnd)
{
    if (IPVERStart != "") 
    {
        if (IPVERStart == '4'||IPVERStart == '6')
        {
        }
        else
        {
            AlertEx(qos_language['bbsp_startipverrange']);
            return false;
        }
    }

    if (IPVEREnd != "")
    {
        if (IPVEREnd == '4'||IPVEREnd == '6')
        {
        }
        else
        {
            AlertEx(qos_language['bbsp_endipverrange']);
            return false;
        }

    }
    if (IPVERStart != "" &&IPVEREnd != ""
        && (parseInt(IPVERStart, 10) != parseInt(IPVEREnd, 10)))
    {
        AlertEx(qos_language['bbsp_startipverinvalid']);
        return false; 
    }
    if (IPVERStart == "" && IPVEREnd != "") 
    {
        AlertEx(qos_language['bbsp_startipverisreq']);
        return false;
    }
    return true;
}

function CheckWanInterfaceVaild(WanInterface)
{
  var reg = new RegExp("^(WAN)[1-8]$"); 
  return reg.test(WanInterface.toUpperCase());
}
function CheckWANInterface(WanStart, WanEnd)
{
    if ('' == WanStart){
        AlertEx("请配置网络接口!");
        return false;
    }

    if ('' != WanStart && '' == WanEnd) {
        WanEnd = WanStart;
    }

    if (WanStart.toUpperCase() != WanEnd.toUpperCase()) {
        AlertEx("网络接口最小值和最大值应该相同!");
        return false;
    }

    if (false == CheckWanInterfaceVaild(WanStart)) {
        AlertEx("网络接口设置无效!");
        return false;
    }

    return true;
}

function IsBindISPPort(Idx)
{
    var ret = false;

    try
    {
        var ISPPortList = Instance_IspWlan.GetISPPortList();
        if (ISPPortList.length > 0)
        {
            var pos = ArrayIndexOf(ISPPortList, 'SSID'+Idx);
            if (pos >= 0)
            {
                ret = true;
            }
        }
    }
    catch(e)
    {
        ret = false;
    }

    return ret;
}

function findSSIDIndexValid(CurIndex)
{
    var index;
    if (WlanInfoList.length -1 > 0)
    {
        for (var i = 0; i < WlanInfoList.length -1; i++)
        {
            index = parseInt(WlanInfoList[i].Domain.charAt(WlanInfoList[i].Domain.length - 1), 10);
            if (CurIndex == index)
            {
                if (IsBindISPPort(index) == false)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
    }
    return false;
}

function getLanTopoRange()
{
    var EthNum = TopoInfo.EthNum;
    var SSIDNum = TopoInfo.SSIDNum;
    var LanTopoRange = "";
    var i;

    if (EthNum > 0)
    {
        if (EthNum == 1)
        {
            LanTopoRange += "LAN" + EthNum;
        }
        else
        {
            LanTopoRange += "LAN1-LAN" + EthNum;
        }
    }

    if (WlanInfoList.length -1 > 0)
    {
        for (i = 0; i < WlanInfoList.length -1; i++)
        {
            var idex = parseInt(WlanInfoList[i].name.charAt(WlanInfoList[i].name.length - 1), 10) + 1;
            if (IsBindISPPort(idex) == false)
            {
                LanTopoRange += qos_language['bbsp_comma'] + "SSID" + idex;
            }
        }
    }

    LanTopoRange += qos_language['bbsp_point'];
    return LanTopoRange;
}

function setLanInterfaceVaildMsg(errorfalg)
{
    var errormsg = "";
    var LanTopoRangeInfo = "";
    LanTopoRangeInfo = getLanTopoRange();

    if (errorfalg == "start")
    {
        errormsg = qos_language['bbsp_startlanrange'] + LanTopoRangeInfo;
    }
    else if (errorfalg == "end")
    {
        errormsg = qos_language['bbsp_endlanrange'] + LanTopoRangeInfo;
    }
    return errormsg;
}

function CheckLanInterfaceVaild(LanInterfaceValue)
{
    var EthNum = TopoInfo.EthNum;
    var SSIDNum = TopoInfo.SSIDNum;

    if (LanInterfaceValue != "")
    {
        var lanIdex = LanInterfaceValue.substring(3,LanInterfaceValue.length);
        var ssidIdex = LanInterfaceValue.substring(4,LanInterfaceValue.length);

        if ((LanInterfaceValue.toUpperCase().substr(0,3) != "LAN") && (LanInterfaceValue.toUpperCase().substr(0,4) != "SSID"))
        {
            return false;
        }

        if (LanInterfaceValue.toUpperCase().substr(0,3) == "LAN")
        {
            if (!isInteger(lanIdex))
            {
                return false;
            }

            lanIdex = parseInt(lanIdex, 10);
            if (EthNum > 0)
            {
                if (lanIdex < 0 || lanIdex > EthNum)
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
        else if (LanInterfaceValue.toUpperCase().substr(0,4) == "SSID")
        {
            if (!isInteger(ssidIdex))
            {
                return false;
            }

            ssidIdex = parseInt(ssidIdex, 10);
            if ((ssidIdex < 0) || (findSSIDIndexValid(ssidIdex) == false))
            {
                return false;
            }
        }
    }
    return true;
}

function CheckLANInterface(LanStart, LanEnd)
{
    LanStart = removeSpaceTrim(LanStart);
    LanEnd = removeSpaceTrim(LanEnd);
    var lanStartIdex = "";
    var lanEndIdex = "";
    var ssidStartIdex = "";
    var ssidEndIdex = "";

    if (CheckLanInterfaceVaild(LanStart) == false)
    {
        AlertEx(setLanInterfaceVaildMsg("start"));
        return false;
    }

    if (CheckLanInterfaceVaild(LanEnd) == false)
    {
        AlertEx(setLanInterfaceVaildMsg("end"));
        return false;
    }

    if (LanStart != "" && LanEnd != "")
    {
        lanStartIdex = LanStart.substring(3,LanStart.length);
        lanEndIdex = LanEnd.substring(3,LanEnd.length);
        lanStartIdex = parseInt(lanStartIdex, 10);
        lanEndIdex = parseInt(lanEndIdex, 10);
        if (LanStart.toUpperCase().substr(0,3) == "LAN")
        {
            if (LanEnd.toUpperCase().substr(0,3) == "LAN")
            {
                if (lanStartIdex > lanEndIdex)
                {
                    AlertEx(qos_language['bbsp_startlaninvalid']);
                    return false; 
                }
            }
            else if (LanEnd.toUpperCase().substr(0,4) == "SSID")
            {
                AlertEx(qos_language['bbsp_laninterfacediff']);
                return false;
            }
        }
        else if (LanStart.toUpperCase().substr(0,4) == "SSID")
        {
            if (LanEnd.toUpperCase().substr(0,3) == "LAN")
            {
                AlertEx(qos_language['bbsp_laninterfacediff']);
                return false;
            }
            else if (LanEnd.toUpperCase().substr(0,4) == "SSID")
            {
                if (lanStartIdex > lanEndIdex)
                {
                    AlertEx(qos_language['bbsp_startlaninvalid']);
                    return false; 
                }
            }
        }
    }

    if (LanStart == "" && LanEnd != "")
    {
        AlertEx(qos_language['bbsp_startlanisreq']);
        return false;
    }
    return true;
}
function GetLanId(val)
{
    if (isPortInAttrName() == false) {
        return 0;
    }

    var ethType = '<%HW_WEB_GetEthTypeList();%>';
    var portNum = parseInt(ethType.charAt(0), 10);

    for (var i = 1; i <= portNum; i++) {
        if (val == getTianYilandesc(i)) {
            return i;
        }
    }

    return 0;
}
function CheckTianYiLANInterface(LanportStart, LanportEnd)
{
    var lanStartIndex = "";
    var lanEndIndex = "";
    var ssidStartIndex = "";
    var ssidEndIndex = "";
    lanStartIndex = LanportStart.charAt(LanportStart.length-1);
    lanEndIndex = LanportEnd.charAt(LanportEnd.length-1);
    if (LanportStart.toUpperCase() == "ITV") {
        lanStartIndex = 2;
    } else if (LanportStart.toUpperCase() == "STB") {
        lanStartIndex = 3;
    } else {
        var instId = GetLanId(LanportStart);
        if (instId != 0) {
            lanStartIndex = instId;
        }
    }

    if (LanportEnd.toUpperCase() == "ITV") {
        lanEndIndex = 2;
    } else if(LanportEnd.toUpperCase() == "STB") {
        lanEndIndex = 3;
    } else {
        var instId = GetLanId(LanportEnd);
        if (instId != 0) {
            lanEndIndex = instId;
        }
    }

    if (LanportStart.indexOf("千兆口") >= 0 || LanportStart.indexOf("百兆口") >= 0)
    {
        if (LanportEnd.toUpperCase().substr(0,4) == "SSID")
        {
            AlertEx(qos_language['bbsp_laninterfacediff']);
            return false;
        }
        else if (lanStartIndex > lanEndIndex)
        {
            AlertEx(qos_language['bbsp_startlaninvalid']);
            return false; 
        }
    }
    else if (LanportStart.toUpperCase() == "ITV")
    {
        if (LanportEnd.toUpperCase().substr(0,4) == "SSID")
        {
            AlertEx(qos_language['bbsp_laninterfacediff']);
            return false;
        }
        else if (lanEndIndex < 2)
        {
            AlertEx(qos_language['bbsp_startlaninvalid']);
            return false;
        }
    }
    else if (LanportStart.toUpperCase() == "STB")
    {
        if (LanportEnd.toUpperCase().substr(0,4) == "SSID")
        {
            AlertEx(qos_language['bbsp_laninterfacediff']);
            return false;
        }
        else if (lanEndIndex < 3)
        {
            AlertEx(qos_language['bbsp_startlaninvalid']);
            return false;
        }
    }
    else
    {
        if (LanportEnd.indexOf("千兆口") >= 0 || LanportEnd.indexOf("百兆口") >= 0 
        || LanportEnd.toUpperCase().substr(0,3) == "ITV" || LanportEnd.toUpperCase().substr(0,3) == "STB")
        {
            AlertEx(qos_language['bbsp_laninterfacediff']);
            return false;
        }
        else if (LanportEnd.toUpperCase().substr(0,4) == "SSID")
        {
            if (lanStartIndex > lanEndIndex)
            {
                AlertEx(qos_language['bbsp_startlaninvalid']);
                return false; 
            }
        }
    }
    return true;
}

function getSelectProtocol()
{
    var EnableList = new Array();
    var ProtocolList = "";
    
    EnableList[0] = (1 == getCheckVal('cb_Tcp')) ? "TCP" : "";
    EnableList[1] = (1 == getCheckVal('cb_Udp')) ? "UDP" : "";
    EnableList[2] = (1 == getCheckVal('cb_Icmp')) ? "ICMP" : "";
    EnableList[3] = (1 == getCheckVal('cb_Icmpv6')) ? "ICMPv6" : "";
    EnableList[4] = (1 == getCheckVal('cb_Rtp')) ? "RTP" : "";

    for (var i=0; i<EnableList.length; i++)
    {
        if (EnableList[i] != "")
        {
            ProtocolList += EnableList[i] + ",";
        }
    }

    if (ProtocolList.length)
        ProtocolList = ProtocolList.substr(0,ProtocolList.length-1);

    return ProtocolList;
}

function IsRepeateClassTypeConfig(ClassId, Min, Max, ProtocolList)
{
    var TypeInfo = getSelectVal('TypeList');

    for (var i = 0; i < ClassificationTypeInfoList.length - 1; i++)
    {
        if (i != classtypeIdx)
        {
            if ((ClassificationTypeInfoList[i].ClassificationId == ClassId)
                && (ClassificationTypeInfoList[i].Type == TypeInfo)
                && (ClassificationTypeInfoList[i].Min == Min)
                && (ClassificationTypeInfoList[i].Max == Max)
                && (ClassificationTypeInfoList[i].ProtocolList == ProtocolList))
            {
                return true;
            }
        }
    }
    return false;
}

function GetClsTypeItemNum(ClassId)
{
    var Num = 0;

    for (var i = 0; i < ClassificationTypeInfoList.length - 1; i++)
    {
        if (ClassificationTypeInfoList[i].ClassificationId == ClassId)
        {
            Num ++;
        }
    }

    return Num;
}

function findClassIdValid(classId)
{
    var id;
    if (ClassificationInfoList.length - 1 > 0)
    {
        for (var i = 0; i < ClassificationInfoList.length - 1; i++)
        {
            id = parseInt(ClassificationInfoList[i].Domain.charAt(ClassificationInfoList[i].Domain.length - 1), 10);
            if (classId == id)
            {
                return true;
            }
        }
    }
    return false;
}

function checkClassId(classId)
{
    var id;
    classId = removeSpaceTrim(classId);
    if (classId != "")
    {
        if (!isInteger(classId))
        {
            AlertEx(qos_language['bbsp_classidinvalid']);
            return false;
        } 
        classId = parseInt(classId, 10);
        if (ClassificationInfoList.length == 1)
        {
            AlertEx(qos_language['bbsp_createclassid']);
            return false;
        }
        if (findClassIdValid(classId) == false)
        {
            AlertEx(qos_language['bbsp_classidreq']);
            return false;
        }
    }
    else
    {
        AlertEx(qos_language['bbsp_classidnull']);
        return false;
    }
    return false;
}

function IsRepeateDataClassConfig(newDataClassList)
{
    var DataClasslist = new Array();

    for (var i = 0; i < ClassificationInfoList.length - 1; i++)
    {
        if (i != dataclassIdx)
        {
            if ((ClassificationInfoList[i].ClassQueue == newDataClassList.Queue)
                && (ClassificationInfoList[i].DSCPMarkValue == newDataClassList.DSCPMarkValue)
                && (ClassificationInfoList[i].PriorityValue == newDataClassList.PriorityValue))
            {
                return true;
            }

            DataClasslist = getDataClassByClassificationId(ClassificationInfoList[i].ClassificationId);
            for (var j = 0; j < DataClasslist.length - 1; j++)
            {
                if ((DataClasslist[j].ClassificationId == newDataClassList.ClassificationId)
                && (DataClasslist[j].Type == newDataClassList.Type)
                && (DataClasslist[j].Min == newDataClassList.Min)
                && (DataClasslist[j].Max == newDataClassList.Max)
                && (DataClasslist[j].ProtocolList == newDataClassList.ProtocolList))
                {
                    return true;
                }
            }
        }
    }
    return false;
}

function getDataClassByClassificationId(ClassificationId)
{
    var DataClassArrayTemp = new Array();
    var DataClassArraySort = new Array();
    for (var i = 0; i < ClassificationTypeInfoList.length - 1; i++)
    {
        if (ClassificationId == ClassificationTypeInfoList[i].ClassificationId)
        {
            DataClassArrayTemp.push(ClassificationTypeInfoList[i]);
        }
    }
    for (var j = 1; j <=DataClassListMax; j++)
    {
        for (var k = 0; k < DataClassArrayTemp.length; k++)
        {
            if (j == DataClassArrayTemp[k].ClassificationTypeId)
            {
                DataClassArraySort.push(DataClassArrayTemp[k]);
            }
        }
    }
    return DataClassArraySort;
}

function getDataClassId(tableID,classID,colID)
{
    var DataClassID = "Classification_" + tableID + "-" + classID + "_" + colID + "_table";
    return DataClassID;
}

function QosDataselectLine(id)
{
    var str = id.split('_')[1];
    var classNum = str.substring(1,str.length);
    selectMulLine(id,classNum);
}

function QosDataselectLine1(id)
{
    var str = id.split('_');
    var NewId = str[0]+'_'+str[1]+'_'+str[2]+'_'+str[3]+'_'+'0';
    QosDataselectLine(NewId);
}
function setControlDispatch(tableID, index)
{
    switch(tableID)
    {
        case "QosApp":
            setControlApp(index);
            break;
        case "QosDataClass":
            setControlDataClass(index);
            break;
        default:
            break;
    }
}

function OnClickAppModify()
{
    if (IsQosModeOther() == false)
    {
        return false;
    }

    if (true == IsRepeateAppConfig())
    {
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.AppName',getSelectVal('App_select'));
    Form.addParameter('x.ClassQueue',getSelectVal('AppQueue_select'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    if (appIdx == -1)
    {
        Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_UplinkQos.App' + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }
    else
    {
        Form.setAction('set.cgi?x=' + AppInfoList[appIdx].Domain + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }

    Form.submit();
    DisableRepeatSubmit();
    setDisable('btnAppApply',1);
    setDisable('btnAppCancel',1);
}

function OnClickAppAdd()
{
    clickAdd('QosApp');
}

function OnClickAppDel()
{
    if (IsQosModeOther() == false)
    {
        return false;
    }

    var noChooseFlag = true;
    var SubmitForm = new webSubmitForm();
    
    if ((AppInfoList.length - 1) == 0)
    {
        AlertEx(qos_language['bbsp_noApp']);
        document.getElementById("AppDeleteSubmit_button").disabled = false;
        return;
    }

    for (var i = 0; i < AppInfoList.length - 1; i++)
    {
        var rmId = "AppName"+i+1+"_checkbox";
        var rm = getElement(rmId);
        if (rm.checked == true)
        {
            noChooseFlag = false;
            SubmitForm.addParameter(AppInfoList[i].Domain,'');
        }
    }
    if (noChooseFlag)
    {
        AlertEx(qos_language['bbsp_selecApp']);
        document.getElementById("AppDeleteSubmit_button").disabled = false;
        return ;
    }
    if (ConfirmEx(qos_language['bbsp_confirmApp']) == false)
    {
        document.getElementById("AppDeleteSubmit_button").disabled = false;
        return;
    }
    SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));

    setDisable('AppModifySubmit_button',1);
    setDisable('AppAddSubmit_button',1);
    setDisable('AppDeleteSubmit_button',1);
    setDisable('AppCancelSubmit_button',1);
    SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/qos/qosadvancedup.asp'); 
    SubmitForm.submit();
    DisableRepeatSubmit();
}

function IsFindClassTypeDomain(Domain)
{
    for (var i = 0; i < ClassificationTypeInfoList.length - 1; i++)
    {
        if (Domain == ClassificationTypeInfoList[i].Domain)
        {
            return true;
        }
    }
    return false;
}

function OnClickDataClassModify()
{
    if (IsQosModeOther() == false)
    {
        return false;
    }

    var className = "";
    var minName = "";
    var maxName = "";
    var protocolName = "";
    var TypeList = "";
    var ClassTypeMin = "";
    var ClassTypeMax = "";
    var ProtocolList = "";
    var ClassUrl = "";
    var ClassTypeUrl = "";
    var NewDataClassList = new Array(new DataClassInfo("","","","","","","",""));
    var Form = new webSubmitForm();

    var CurClassificationId = getSelectVal('DataClassIdList');
    var CurClassIndex = getIndexByClassificationId(CurClassificationId);

    var ClassDhcp = getValue("DSCPMarkValue_text");
    ClassDhcp = removeSpaceTrim(ClassDhcp);
    if (ClassDhcp != "")
    {
       if (false == CheckNumber(ClassDhcp, 0, 63))
       {
         AlertEx(qos_language['bbsp_classdhcpinvaild']);
         return false;
       }
    }
    else
    {
       ClassDhcp = 0;
    }
    ClassDhcp = parseInt(ClassDhcp, 10);

    var Class8021p = getValue("8021_PMarkValue_text");
    Class8021p = removeSpaceTrim(Class8021p);
    if (Class8021p != "")
    {
       if (false == CheckNumber(Class8021p, 0, 7))
       {
         AlertEx(qos_language['bbsp_class8021pinvaild']);
         return false;
       }
    }
    else
    {
       Class8021p = 0;
    }
    Class8021p = parseInt(Class8021p, 10);

    Form.addParameter('x.DSCPMarkValue',ClassDhcp);
    Form.addParameter('x.PriorityValue',Class8021p);

    var enableQueue = getCheckVal("DSCPListEnable_checkbox");
    Form.addParameter('x.ClassQueueEnable', enableQueue);
    if (enableQueue == 1) {
        Form.addParameter('x.ClassQueue',getSelectVal('ClassificationQueue_select'));
    }

    if (dataclassIdx == -1)
    {
        ClassUrl = 'x=InternetGatewayDevice.X_HW_UplinkQos.Classification';
    }
    else
    {
        ClassUrl = 'x='+ClassificationInfoList[CurClassIndex].Domain;
    }

    for (var i = 1; i <= DataClassListMax; i++)
    {
        className = "Type"+i+"_select";
        minName = "Type"+i+"MinValue_text";
        maxName = "Type"+i+"MaxValue_text";
        protocolName = "Type"+i+"Protocol_select";
        
        TypeList = getSelectVal(className);
        ClassTypeMin = getValue(minName);
        ClassTypeMin = removeSpaceTrim(ClassTypeMin);
        ClassTypeMax = getValue(maxName);
        ClassTypeMax = removeSpaceTrim(ClassTypeMax);
        if ((TypeList ==  "LANInterface") && (isPortInAttrName()))
        {
            minName = "Type"+i+"LANstart_select";
            maxName = "Type"+i+"LANend_select";
            ClassTypeMin = getSelectVal(minName);
            ClassTypeMin = removeSpaceTrim(ClassTypeMin);
            ClassTypeMax = getSelectVal(maxName);
            ClassTypeMax = removeSpaceTrim(ClassTypeMax);
        }

        if ((TypeList == "SMAC") && (CheckSMAC(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "DMAC") && (CheckDMAC(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "8021P") && (Check8021P(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "SIP") && (CheckSIP(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "DIP") && (CheckDIP(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "SPORT") && (CheckSPORT(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "DPORT") && (CheckDPORT(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "TOS") && (CheckTOS(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList == "DSCP") && (CheckDSCP(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList ==  "WANInterface") && (CheckWANInterface(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if (TypeList ==  "LANInterface")
        {
            if (isPortInAttrName())
            {
                if (CheckTianYiLANInterface(ClassTypeMin, ClassTypeMax) == false)
                {
                    return false;
                }
            }
            else 
            {
                if (CheckLANInterface(ClassTypeMin, ClassTypeMax) == false)
                  {
                    return false;
                }
            }
        }
        else if ((TypeList ==  "TC") && (CheckTC(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList ==  "FL") && (CheckFL(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        else if ((TypeList ==  "IPVER") && (CheckIPVER(ClassTypeMin, ClassTypeMax) == false))
        {
            return false;
        }
        if ((TypeList == "8021P") || (TypeList == "SPORT") || (TypeList == "DPORT") || (TypeList == "TOS") || (TypeList == "DSCP"))
        {
            ClassTypeMin = ClassTypeMin.length?parseInt(ClassTypeMin, 10):"";
            ClassTypeMax = ClassTypeMax.length?parseInt(ClassTypeMax, 10):"";
        }
        else if (TypeList ==  "LANInterface")
        {
            var lanminindex = ClassTypeMin.charAt(ClassTypeMin.length-1);
            var lanmaxindex = ClassTypeMax.charAt(ClassTypeMax.length-1);
            var lanurl = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
            var ssidurl = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
            if (ClassTypeMin.toUpperCase().indexOf("ITV") != -1)
            {
                ClassTypeMin = lanurl + '2';
            }
            else if (ClassTypeMin.toUpperCase().indexOf("STB") != -1)
            {
                ClassTypeMin = lanurl + '3';
            }
            else if (ClassTypeMin.toUpperCase().indexOf("SSID") != -1)
            {
                ClassTypeMin = ssidurl + lanminindex;
            }
            else
            {
                var instId = GetLanId(ClassTypeMin);
                if (instId == 0) {
                    ClassTypeMin = lanurl + lanminindex;
                } else {
                    ClassTypeMin = lanurl + instId;
                }
            }
            
            if (ClassTypeMax.toUpperCase().indexOf("ITV") != -1)
            {
                ClassTypeMax = lanurl + "2";
            }
            else if (ClassTypeMax.toUpperCase().indexOf("STB") != -1)
            {
                ClassTypeMax = lanurl + "3";
            }
            else if (ClassTypeMax.toUpperCase().indexOf("SSID") != -1)
            {
                ClassTypeMax = ssidurl + lanmaxindex;
            }
            else
            {
                var instId = GetLanId(ClassTypeMax);
                if (instId == 0) {
                    ClassTypeMax = lanurl + lanmaxindex;
                } else {
                    ClassTypeMax = lanurl + instId;
                }
            }
        }
        else if (TypeList ==  "WANInterface")
        {
            var wanMacId = parseInt(ClassTypeMin.substr(3),10);
            var wanPath = WanMacId2WanPath(wanMacId);
            if ("" == wanPath) {
                AlertEx(ClassTypeMin+"不存在,请先配置！");
                return false;
            }
            ClassTypeMin = ClassTypeMax = wanPath;
        }
        ProtocolList = getSelectVal(protocolName);

        NewDataClassList[0].ClassificationId = CurClassificationId;
        NewDataClassList[0].Queue = getSelectVal('ClassificationQueue_select');
        NewDataClassList[0].DSCPMarkValue = ClassDhcp;
        NewDataClassList[0].PriorityValue = Class8021p;
        NewDataClassList[0].Type = TypeList;
        NewDataClassList[0].Max = ClassTypeMax;
        NewDataClassList[0].Min = ClassTypeMin;
        NewDataClassList[0].ProtocolList = ProtocolList;

        if (true == IsRepeateDataClassConfig(NewDataClassList[0]))
        {
            AlertEx(qos_language['bbsp_dataclassruleexist']);
            return false;
        }

        if (dataclassIdx == -1)
        {
            if (TypeList != "FIRST_TYPE")
            {
                Form.addParameter('Add_y'+i+'.Type',TypeList);
                Form.addParameter('Add_y'+i+'.Min',ClassTypeMin);
                Form.addParameter('Add_y'+i+'.Max',ClassTypeMax);
                Form.addParameter('Add_y'+i+'.ProtocolList',ProtocolList);
                ClassTypeUrl += "&Add_y" + i + "=x.type";
            }
        }
        else
        {
            var ClassTypeDomain = ClassificationInfoList[CurClassIndex].Domain+".type." + i;
            if (TypeList != "FIRST_TYPE")
            {
                if (false == IsFindClassTypeDomain(ClassTypeDomain))
                {
                    Form.addParameter('Add_y'+i+'.Type',TypeList);
                    Form.addParameter('Add_y'+i+'.Min',ClassTypeMin);
                    Form.addParameter('Add_y'+i+'.Max',ClassTypeMax);
                    Form.addParameter('Add_y'+i+'.ProtocolList',ProtocolList);
                    ClassTypeUrl += "&Add_y" + i + "="+ClassificationInfoList[CurClassIndex].Domain+".type";
                }
                else
                {
                    Form.addParameter('y'+i+'.Type',TypeList);
                    Form.addParameter('y'+i+'.Min',ClassTypeMin);
                    Form.addParameter('y'+i+'.Max',ClassTypeMax);
                    Form.addParameter('y'+i+'.ProtocolList',ProtocolList);
                    ClassTypeUrl += "&y" + i + "="+ClassificationInfoList[CurClassIndex].Domain+".type." + i;
                }
            }
            else
            {
                if (true == IsFindClassTypeDomain(ClassTypeDomain))
                {
                    Form.addParameter('Del_y'+i+'.Type','');
                    Form.addParameter('Del_y'+i+'.Min','');
                    Form.addParameter('Del_y'+i+'.Max','');
                    Form.addParameter('Del_y'+i+'.ProtocolList','');
                    ClassTypeUrl += "&Del_y" + i + "="+ClassificationInfoList[CurClassIndex].Domain+".type." + i;
                }
            }
        }
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    if (dataclassIdx == -1)
    {
        Form.setAction('addcfg.cgi?' + ClassUrl + ClassTypeUrl + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }
    else
    {
        Form.setAction('complex.cgi?' + ClassUrl +  ClassTypeUrl + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }
    Form.submit();
    DisableRepeatSubmit();
}

function OnClickDataClassAdd()
{
    clickAddQos('QosDataClass');
}

function OnClickDataClassDel() 
{
    if (IsQosModeOther() == false)
    {
        return false;
    }

    var noChooseFlag = true;
    if (ClassificationInfoList.length - 1== 0)
    {
        AlertEx(qos_language['bbsp_noClass']);
        document.getElementById("ClassificationDeleteSubmit_button").disabled = false;
        return;
    }
    var ClassificationId = getSelectVal('DataClassIdList');
    var idx = getIndexByClassificationId(ClassificationId);
    if (idx == -1)
    {
        return;
    }
    var Form = new webSubmitForm();

    var DataClasslist = new Array();
    DataClasslist = getDataClassByClassificationId(ClassificationId);
    var ClassNum = DataClasslist.length;
    var ClassUrl = "";
    var ClassTypeUrl = "";
    if (0 == ClassNum)
    {
        Form.addParameter(ClassificationInfoList[idx].Domain,'');
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' + '&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }
    else if (ClassNum > 0)
    {
        for (var i = 1; i <= ClassNum; i++)
        {
            Form.addParameter('Del_y'+i+'.Type',"");
            Form.addParameter('Del_y'+i+'.Min',"");
            Form.addParameter('Del_y'+i+'.Max',"");
            Form.addParameter('Del_y'+i+'.ProtocolList',"");
            if (i > 1)
            {
                ClassTypeUrl += "&Del_y" + i + "=" +DataClasslist[i-1].Domain;
            }
            else
            {
                ClassTypeUrl += "Del_y" + i + "=" +DataClasslist[i-1].Domain;
            }
        }
        Form.addParameter('Del_z.ClassQueue','');
        Form.addParameter('Del_z.DSCPMarkValue','');
        Form.addParameter('Del_z.PriorityValue','');
        ClassUrl = "&Del_z="+ClassificationInfoList[idx].Domain;
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('complex.cgi?' +ClassTypeUrl+ ClassUrl+'&RequestFile=html/bbsp/qos/qosadvancedup.asp');
    }
    setDisable('ClassificationModifySubmit_button',1);
    setDisable('ClassificationAddSubmit_button',1);
    setDisable('ClassificationDeleteSubmit_button',1);
    setDisable('btnQosDataClassCancel',1);
    Form.submit();
    DisableRepeatSubmit();
}

function setAppDataFlow()
{
    var AppId = getSelectVal('DataFlow_select');
    var idx = -1;
    var selectId = "";
    for (var i = 0; i < AppInfoList.length - 1; i++)
    {
        if (AppId == AppInfoList[i].AppId)
        {
            idx = i;
            break;
        }
    }
    if (idx != -1)
    {
        selectId = 'QosApp_record_' + idx;
        selectLine(selectId);
    }
}

function getIndexByClassificationId(ClassificationId)
{
    var idx = -1;
    for (var i = 0; i < ClassificationInfoList.length - 1; i++) {
        if (ClassificationId == ClassificationInfoList[i].ClassificationId) {
            idx = i;
            break;
        }
    }
    return idx;
}
function setQosDataClassId()
{
    var ClassificationId = getSelectVal('DataClassIdList');
    var DataClasslist = new Array();
    DataClasslist = getDataClassByClassificationId(ClassificationId);
    var ClassNum = DataClasslist.length;
    var selectId = "";
    var idx = getIndexByClassificationId(ClassificationId);
    if (idx != -1) {
        if (ClassNum == 0) {
            selectId = 'QosDataClass_' + 'N1' + '_' + 'record_' + idx + '_0';
        } else {
            selectId = 'QosDataClass_' + 'N' + ClassNum + '_' + 'record_' + idx + '_0';
        }
    }
    QosDataselectLine(selectId);
}

function getProtocolName(Protocol)
{
    var ProtocolName = "";
    if (Protocol == "") {
        ProtocolName = 'ALL';
    } else if (DataClasslist[j].ProtocolList == "TCP,UDP") {
        ProtocolName = 'TCP/UDP';
    } else {
        ProtocolName = Protocol;
    }
    return ProtocolName;
}

function changeEnableList() {
    setDisable("ClassificationQueue_select", 1 - getCheckVal("DSCPListEnable_checkbox"))
}
</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">

<form id="ConfigForm" action="../application/set.cgi">

    <div id="DivQueueManagement" style="display:none">
        <div class="func_title" BindText='bbsp_QueueManage1'></div>
        <div id="DivQosBasic">
            <table cellpadding="0" cellspacing="0" width="100%" border="0" >
                <tr id="BandwidthRow">
                  <td  class="table_title width_25p" BindText='bbsp_Bandwidth1'></td>
                  <td  class="table_right width_75p"> <input type='text' id='Bandwidth' name='Bandwidth'/>
                  <script>document.write(qos_language['bbsp_kbps']);</script></td> 
                </tr>
                <script>
                getElById("Bandwidth").title = qos_language['bbsp_Bandwidthtitle'];
                </script>
                <tr id="PlanRow">
                    <td  class="table_title width_25p" BindText='bbsp_Plan1'></td>
                    <td  class="table_right width_75p"> <select name='QoSPlan_select'  id="QoSPlan_select" size="1" onChange="setQosPlan();">
                        <option value="priority"><script>document.write(qos_language['bbsp_priority1']);</script></option>
                        <option value="weight"><script>document.write(qos_language['bbsp_weight1']);</script></option>
                    </select></td>
                </tr>
                <tr id="EnableForceWeightRow">
                  <td class="table_title width_25p" BindText='bbsp_EnableForceWeight1'></td>
                  <td class="table_right width_75p"> <input  id='EnableForceWeight' name='EnableForceWeight' type='checkbox'> </td>
                </tr>
                <tr id="EnableDSCPMarkRow">
                    <td class="table_title width_25p" BindText='bbsp_EnableDSCPMark1'></td>
                    <td class="table_right width_75p"> <input id='DSCPMarkEnable_checkbox' name='DSCPMarkEnable_checkbox' value="True" type='checkbox'></td>
                </tr>
                <tr id="Enable8021pRow">
                    <td  class="table_title width_25p" BindText='bbsp_Enable8021p1'></td> 
                    <td  class="table_right width_75p"> <select name='8021_PMarkType_select'  id="8021_PMarkType_select" size="1">
                        <option value="0"><script>document.write(qos_language['bbsp_Disable1']);</script></option>
                        <option value="2"><script>document.write(qos_language['bbsp_Modify1']);</script></option>
                        <option value="1"><script>document.write(qos_language['bbsp_Transparent1']);</script></option>
                    </select></td>
                </tr>
            </table>
        </div>
        <div id="DivSP" style="display:none">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="priQueueInst">
                <tr class="head_title">
                    <td>&nbsp;</td>
                    <td ><div class="align_center"><script>document.write(qos_language['bbsp_QueueNumber1']);</script></div></td>
                    <td ><div class="align_center"><script>document.write(qos_language['bbsp_QueuePri']);</script></div></td>
                </tr>  
                <script language="JavaScript" type="text/javascript">
                    if (PriorityQueueInfoList.length == 0) {
                        document.write('<TR id="SPrecord_no"' + ' class="tabal_01">');
                        document.write('<TD align="center" width="5%">--</TD>');
                        document.write('<TD align="center" width="35%">--</TD>');
                        document.write('<TD align="center" width="60%">--</TD>');
                        document.write('</TR>');
                    } else {
                        for (i = 0; i < PriorityQueueInfoList.length; i++) {
                            document.write('<TR id="SPrecord_' + i + '" class="tabal_01">');
                            document.write('<TD align="center" width="5%">' + '<input type="checkbox" name="SPrml" id="SPRecord' + i + '"+ value="'+ PriorityQueueInfoList[i].Enable+'">' + '</TD>');
                            document.write('<TD align="center" width="40%">' + 'Q' + PriorityQueueInfoList[i].Priority + '</TD>');
                            document.write('<TD align="center" width="60%">' + PriorityQueueInfoList[i].Priority + '</TD>');
                            document.write('</TR>');
                        }
                    }
                </script>
            </table> 
        </div>
        <div id="DivWRR" style="display:none">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="priQueueInst">
                <tr class="head_title">
                    <td>&nbsp;</td>
                    <td ><div class="align_center"><script>document.write(qos_language['bbsp_QueueNumber1']);</script></div></td>
                        <script language="JavaScript" type="text/javascript">
                            document.write('<td ><div class="align_center">'+qos_language["bbsp_Weight1"]+'</div></td>');
                        </script>
                </tr>
                <script language="JavaScript" type="text/javascript">
                    if (PriorityQueueInfoList.length == 0) {
                        document.write('<TR id="WRRrecord_no"' + ' class="tabal_01">');
                        document.write('<TD align="center" width="5%">--</TD>');
                        document.write('<TD align="center" width="35%">--</TD>');
                        document.write('<TD align="center" width="60%">--</TD>');
                        document.write('</TR>');
                    } else {
                        for (i = 0; i < PriorityQueueInfoList.length; i++) {
                            var QueueIndex = '';

                            if (PriorityQueueInfoList[i].Domain.length == 0) {
                                QueueIndex = PriorityQueueInfoList[i].Priority;
                            } else {
                                QueueIndex = PriorityQueueInfoList[i].Domain.charAt(PriorityQueueInfoList[i].Domain.length - 1);
                            }

                            document.write('<TR id="WRRrecord_' + i + '" class="tabal_01">');
                            document.write('<TD align="center" width="5%">' + '<input type="checkbox" name="WRRrml" id="WRRRecord' + i + '"+ value="'+ PriorityQueueInfoList[i].Enable+'">' + '</TD>');
                            document.write('<TD align="center" width="40%">' + 'Q' + QueueIndex + '</TD>');
                            document.write('<TD align="center" width="60%">' + '<input type="text" id="Q' + QueueIndex +'Weight_text" size="3" maxlength="3" ' + 'value="' + PriorityQueueInfoList[i].Weight + '"/>'+'</TD>');
                            document.write('</TR>');
                        }
                    }
                </script>
            </table> 
        </div>
        <script language="JavaScript" type="text/javascript">
            if (QosBasicInfoList[0] == null) {
                setDisplay("DivSP", 1);
            } else {
                if (QosBasicInfoList[0].X_HW_Plan == "weight") {
                    setDisplay("DivWRR", 1);
                } else {
                    setDisplay("DivSP", 1);
                }
            }
        </script>
        <div class="button_spread"></div>
        <table cellpadding="0" cellspacing="1" width="100%" class="table_button">
            <tr align="right">
                <td class="table_submit">
                    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                    <button id="btnQMApply" name="btnQMApply" type="button" class="submit" onClick="OnQMApply();"><script>document.write(qos_language['bbsp_app']);</script></button>
                </td> 
            </tr>
        </table>
    </div>
  
    <div id="DivApp" style="display:none">
        <div class="func_spread"></div>
        <script language="JavaScript" type="text/javascript">
            writeTabCfgHeader('QosApp',qos_language['bbsp_AppManage1'],"100%");
        </script>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="QosAppInst">
            <tr class="head_title">
                <td>&nbsp;</td>
                <td ><div class="align_center"><script>document.write(qos_language['bbsp_AppName']);</script></div></td>
                <td ><div class="align_center"><script>document.write(qos_language['bbsp_ClassQueue1']);</script></div></td>
            </tr>
            <script language="JavaScript" type="text/javascript">
                if (AppInfoList.length - 1 == 0) {
                    document.write('<TR id="QosApp_record_no"' + ' class="tabal_01" onclick="selectLine(this.id);">');
                    document.write('<TD align="center" width="5%">--</TD>');
                    document.write('<TD align="center" width="47%">--</TD>');
                    document.write('<TD align="center" width="47%">--</TD>');
                    document.write('</TR>');
                } else {
                    var AppList = 0;
                    if (AppInfoList.length - 1 > AppListMax) {
                        AppList = AppListMax;
                    } else {
                        AppList = AppInfoList.length - 1;
                    }
                    for (var i = 0; i < AppList; i++) {
                        var appname = AppInfoList[i].AppName;
                        var cbId = "AppName"+i+1+"_checkbox";
                        if (CurrentBin.toUpperCase() == 'E8C') {
                            appname = AppInfoList[i].AppName.replace(new RegExp(/(VOIP)/g),"VOICE");
                        }
                        document.write('<TR id="QosApp_record_' + i + '" class="tabal_01" onclick="selectLine(this.id);">');
                        document.write('<TD align="center" width="5%">' + '<input type="checkbox" id="'+ cbId +'"  name="'+ cbId +'" value="True" onclick="selectRemoveCnt(this);">' + '</TD>');
                        document.write('<TD align="center" width="47%">' + appname + '</TD>');
                        document.write('<TD align="center" width="47%">' + 'Q' + AppInfoList[i].ClassQueue + '</TD>');
                        document.write('</TR>');
                    }
                }
            </script>
        </table>
        <div id="QosAppConfigForm">
            <table cellpadding="0" cellspacing="0" border="0" id="app_cfg_table" width="100%">
                <tr>
                    <td  class="table_title width_25p" BindText='bbsp_AppName1'></td> 
                    <td  class="table_right"><select name='App_select'  id="App_select" size="1">
                        <option value=""><script>document.write("");</script></option> 
                            <script language="JavaScript" type="text/javascript">
                                if (CurrentBin.toUpperCase() == 'E8C') {
                                    document.write('<option value="VOIP">VOICE</option>');
                                }
                                else {
                                    document.write('<option value="VOIP">'+qos_language['bbsp_VOIP']+'</option>');
                                }
                            </script>  
                        <option value="TR069"><script>document.write(qos_language['bbsp_TR069']);</script></option>
                    </select></td>
                </tr>
                <tr id="AppDataFlowIdTr">
                    <td  class="table_title width_25p" BindText='bbsp_DataFlowId'></td>
                    <td  class="table_right"><select name='DataFlow_select'  id="DataFlow_select" onChange="setAppDataFlow();">
                        <script language="JavaScript" type="text/javascript">
                            if (AppInfoList.length == 1) {
                                document.write('<option value=""></option>');
                            } else {
                                var AppList = 0;
                                if (AppInfoList.length - 1 > AppListMax) {
                                    AppList = AppListMax;
                                } else {
                                    AppList = AppInfoList.length - 1;
                                }
                                for (var i = 0; i < AppList; i++) {
                                    document.write('<option value="'+SortAppIdList[i]+'">'+SortAppIdList[i]+'</option>');
                                }
                            }
                        </script>
                    </select></td> 
                </tr>
                <tr>
                    <td  class="table_title width_25p" BindText='bbsp_ClassQueuemh1'></td>
                    <td  class="table_right"><select name='AppQueue_select'  id="AppQueue_select" size='1'>
                        <script language="JavaScript" type="text/javascript">
                            for (var i = 1; i <= QueueNum; i++) {
                                document.write('<option value="'+i+'">'+'Q'+i+'</option>');
                            }
                        </script>
                    </select></td>
                </tr>
            </table>
        </div>
        <div class="button_spread"></div>
        <table cellpadding="0" cellspacing="1" width="100%" class="table_button">
            <tr align="right">
                <td class="table_submit">
                    <button id="AppModifySubmit_button" name="AppModifySubmit_button" type="button" class="submit" onClick="OnClickAppModify();"><script>document.write(qos_language['bbsp_modify']);</script></button> 
                    <button id="AppAddSubmit_button" name="AppAddSubmit_button" type="button" class="submit" onClick="OnClickAppAdd();"><script>document.write(qos_language['bbsp_add']);</script></button> 
                    <button id="AppDeleteSubmit_button" name="AppDeleteSubmit_button" class="submit" type="button" onClick="OnClickAppDel();"><script>document.write(qos_language['bbsp_del']);</script></button>
                    <button id="AppCancelSubmit_button" name="AppCancelSubmit_button" class="submit" type="button" onClick="CancelConfig('QosApp');"><script>document.write(qos_language['bbsp_cancel']);</script></button>
                </td>
            </tr>
        </table>
        <script language="JavaScript" type="text/javascript">
            writeTabTail();
        </script>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr> 
                <td class="height10p"></td>
            </tr>
        </table>
    </div>

    <div id="DivQosDataClass">
        <div class="func_spread"></div>
        <script language="JavaScript" type="text/javascript">
            writeTabQosHeader('QosDataClass',qos_language['bbsp_DataClassManage'],"100%");
        </script>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="QosDataClassInst">
            <tr class="head_title">
                <td id="Classification_1-1_1_table"><div class="align_center"><script>document.write(qos_language['bbsp_DataId']);</script></div></td>
                <td id="Classification_1-1_2_table"><div class="align_center"><script>document.write(qos_language['bbsp_SelectQueue']);</script></div></td>
                <td id="Classification_1-1_3_table"><div class="align_center"><script>document.write(qos_language['bbsp_DSCPorTCFlag']);</script></div></td>
                <td id="Classification_1-1_4_table"><div class="align_center"><script>document.write(qos_language['bbsp_8021pFlag']);</script></div></td>
                <td id="Classification_1-1_5_table"><div class="align_center"><script>document.write(qos_language['bbsp_class']);</script></div></td>
                <td id="Classification_1-1_6_table"><div class="align_center"><script>document.write(qos_language['bbsp_type']);</script></div></td>
                <td id="Classification_1-1_7_table"><div class="align_center"><script>document.write(qos_language['bbsp_Min']);</script></div></td>
                <td id="Classification_1-1_8_table"><div class="align_center"><script>document.write(qos_language['bbsp_Max']);</script></div></td>
                <td id="Classification_1-1_9_table"><div class="align_center"><script>document.write(qos_language['bbsp_Protocol']);</script></div></td>
            </tr>  
            <script language="JavaScript" type="text/javascript">
                if (ClassificationInfoList.length - 1 == 0) {
                    document.write('<TR id="QosDataClass_N0_record_no"' + ' class="tabal_01" onclick="QosDataselectLine(this.id);">');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('<TD align="center" width="11%">--</TD>');
                    document.write('</TR>');
                } else {
                    var ClassList = 0;
                    if (ClassificationInfoList.length - 1 > ClassListMax) {
                        ClassList = ClassListMax;
                    } else {
                        ClassList = ClassificationInfoList.length - 1;
                    }
        
                    var DataClasslist = new Array();
        
                    for (var i = 0; i < ClassList; i++) {
                        DataClasslist = getDataClassByClassificationId(ClassificationInfoList[i].ClassificationId);
                        var ClassNum = DataClasslist.length;
                        var tableID = i + 2;
                        var classID = "";
                        var id = "";
                        var classId = "";
                        var ProtocolShowName="";

                        if (ClassNum > 0) {
                            classID = 1;
                        }
                        if (ClassNum == 0) {
                            document.write('<TR id="QosDataClass_'+ 'N1' + '_' + 'record_' + i + '_0' + '" class="tabal_01" onclick="QosDataselectLine(this.id);">');
                            document.write('<TD align="center" width="11%" rowspan="' + 1 + '" id="'+getDataClassId(tableID,classID,1)+'">' + ClassificationInfoList[i].ClassificationId + '</TD>');
                            document.write('<TD align="center" width="11%" rowspan="' + 1 + '" id="'+getDataClassId(tableID,classID,2)+'">' + 'Q' + ClassificationInfoList[i].ClassQueue + '</TD>');
                            document.write('<TD align="center" width="11%" rowspan="' + 1 + '" id="'+getDataClassId(tableID,classID,3)+'">' + ClassificationInfoList[i].DSCPMarkValue + '</TD>');
                            document.write('<TD align="center" width="11%" rowspan="' + 1 + '" id="'+getDataClassId(tableID,classID,4)+'">' + ClassificationInfoList[i].PriorityValue + '</TD>');
                            document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,5)+'">' + '--' + '</TD>');
                            document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,6)+'">' + '--' + '</TD>');
                            document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,7)+'">' + '--' + '</TD>');
                            document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,8)+'">' + '--' + '</TD>');
                            document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,9)+'">' + '--' + '</TD>');
                            document.write('</TR>');
                        } else {
                            document.write('<TR id="QosDataClass_'+ 'N' + ClassNum + '_' + 'record_' + i + '_0' + '" class="tabal_01" onclick="QosDataselectLine(this.id);">');
                            document.write('<TD align="center" width="11%" rowspan="' + ClassNum + '" id="'+getDataClassId(tableID,classID,1)+'">' + ClassificationInfoList[i].ClassificationId + '</TD>');
                            document.write('<TD align="center" width="11%" rowspan="' + ClassNum + '" id="'+getDataClassId(tableID,classID,2)+'">' + 'Q' + ClassificationInfoList[i].ClassQueue + '</TD>');
                            document.write('<TD align="center" width="11%" rowspan="' + ClassNum + '" id="'+getDataClassId(tableID,classID,3)+'">' + ClassificationInfoList[i].DSCPMarkValue + '</TD>');
                            document.write('<TD align="center" width="11%" rowspan="' + ClassNum + '" id="'+getDataClassId(tableID,classID,4)+'">' + ClassificationInfoList[i].PriorityValue + '</TD>');

                            for (var j = 0; j < ClassNum; j++) {
                                if (j > 0) {
                                    classID = j + 1;
                                    document.write('<TR id="QosDataClass_' + 'N' + ClassNum + '_'+ 'record_' + i + '_' + j + '" class="tabal_01" onclick="QosDataselectLine1(this.id);">');
                                }
                                id = DataClasslist[j].ClassificationTypeId;
                                classId = qos_language['bbsp_class'] + id;
                                document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,5)+'">' + classId + '</TD>');
                                document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,6)+'">' + DataClasslist[j].Type + '</TD>');
                                if (DataClasslist[j].Type == "LANInterface") {
                                    if ((STBPort != 0) && (isPortInAttrName())) {
                                        if (DataClasslist[j].Min == "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.3") {
                                            DataClasslist[j].MinShow = "STB";
                                        }
                                        if (DataClasslist[j].Max == "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.3") {
                                            DataClasslist[j].MaxShow = "STB";
                                        }
                                    }
                                    document.write('<TD align="center" width="11%" title="' + DataClasslist[j].Min + '" id="'+getDataClassId(tableID,classID,7)+'">' +  DataClasslist[j].MinShow + '</TD>');
                                    document.write('<TD align="center" width="11%" title="' + DataClasslist[j].Max + '" id="'+getDataClassId(tableID,classID,8)+'">' +  DataClasslist[j].MaxShow + '</TD>');
                                } else if (DataClasslist[j].Type == "WANInterface") {
                                    document.write('<TD align="center" width="11%" title="' + DataClasslist[j].Min + '" id="'+getDataClassId(tableID,classID,7)+'">' +  DataClasslist[j].MinShow + '</TD>');
                                    document.write('<TD align="center" width="11%" title="' + DataClasslist[j].Max + '" id="'+getDataClassId(tableID,classID,8)+'">' +  DataClasslist[j].MaxShow + '</TD>');
                                } else {
                                    document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,7)+'">' + DataClasslist[j].Min + '</TD>');
                                    document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,8)+'">' + DataClasslist[j].Max + '</TD>');
                                }

                                ProtocolShowName = getProtocolName(DataClasslist[j].ProtocolList);
                                document.write('<TD align="center" width="11%" id="'+getDataClassId(tableID,classID,9)+'">' + ProtocolShowName + '</TD>');
                                document.write('</TR>');
                            }
                        }
                    }
                }
            </script>
        </table>
        <tr>
            <td  class="align_left width_25p"><script>document.write(qos_language['bbsp_notes']);</script></td>
        </tr>
        <div id="QosDataClassConfigForm">
            <table cellpadding="0" cellspacing="0" border="0" id="Class_cfg_table" width="100%">
                <tr id="DataClassIdListTr">
                    <td  class="table_title width_25p" BindText='bbsp_DataClassIdmh'></td> 
                    <td  class="table_right"><select name='DataClassIdList'  id="DataClassIdList" size="1" onChange="setQosDataClassId();">
                        <script language="JavaScript" type="text/javascript">
                            if (ClassificationInfoList.length == 1) {
                                document.write('<option value=""></option>');
                            } else {
                                var ClassList = 0;
                                if (ClassificationInfoList.length - 1 > ClassListMax) {
                                    ClassList = ClassListMax;
                                } else {
                                    ClassList = ClassificationInfoList.length - 1;
                                }
                                for (var i = 0; i < ClassList; i++) {
                                    document.write('<option value="'+SortClassIdList[i]+'">'+SortClassIdList[i]+'</option>');
                                }
                            }
                        </script>
                        </select>
                    </td> 
                </tr>
                
                <tr id="EnableQueueList">
                    <td class="table_title width_25p" BindText='bbsp_DataClassQueueEnable'></td>
                    <td class="table_right width_75p">
                        <input id='DSCPListEnable_checkbox' name='DSCPListEnable_checkbox' value="True" type='checkbox' onClick="changeEnableList()">
                    </td>
                </tr>
                
                <tr>
                    <td  class="table_title width_25p" BindText='bbsp_DataClassQueuemh'></td> 
                    <td  class="table_right">
                        <select name='ClassificationQueue_select' id="ClassificationQueue_select" size="1"> 
                            <script language="JavaScript" type="text/javascript">
                                for (var i = 1; i <= QueueNum; i++)
                                {
                                    document.write('<option value="'+i+'">'+'Q'+i+'</option>');
                                }
                            </script>
                        </select>
                    </td> 
                </tr>

                <tr id="DSCPMarkValueTr">
                <script language="JavaScript" type="text/javascript">
                document.write("<td class='table_title width_25p'  BindText='bbsp_DSCPTC'>  </td>");
                </script>                    
                    <td  class="table_right width_75p"> <input type='text' id='DSCPMarkValue_text' name='DSCPMarkValue_text' sixe='2' maxlength="2"/>
                    <script>document.write(qos_language['bbsp_DSCPRange1']);</script>
                    </td> 
                </tr>

                <tr id="8021_PMarkValueTr">
                    <td  class="table_title width_25p" BindText='bbsp_8021pmh1'></td> 
                    <td  class="table_right width_75p"> <input type='text' id='8021_PMarkValue_text' name='8021_PMarkValue_text' sixe='1' maxlength="1"/>
                        <script>document.write(qos_language['bbsp_8021pRange']);</script>
                    </td>
                </tr>
            </table>
            <div id="DivDataClass1" style="display:block">
                <table cellpadding="0" cellspacing="0" border="0" id="DataClass1_table" width="100%"> 
                    <tr>
                        <td  class="table_title width_25p" BindText='bbsp_DataClass1mh'></td> 
                        <td  class="table_right"><select name='Type1_select'  id="Type1_select" size='1' onChange="setQosClassType(this.id);">
                            <option value="FIRST_TYPE"><script>document.write(qos_language['bbsp_selectType']);</script></option> 
                            <option value="SMAC"><script>document.write(qos_language['bbsp_SMAC1']);</script></option> 
                            <script language="JavaScript" type="text/javascript">
                            if (Customz_CMCC_RMS == 1) {
                                document.write('<option value="DMAC">'+qos_language['bbsp_DMAC1']+'</option>');
                            }
                            </script>
                            <option value="8021P"><script>document.write(qos_language['bbsp_Type_8021P']);</script></option>
                            <option value="SIP"><script>document.write(qos_language['bbsp_SIP1']);</script></option> 
                            <option value="DIP"><script>document.write(qos_language['bbsp_DIP1']);</script></option> 
                            <option value="SPORT"><script>document.write(qos_language['bbsp_SPORT1']);</script></option> 
                            <option value="DPORT"><script>document.write(qos_language['bbsp_DPORT1']);</script></option> 
                            <option value="TOS"><script>document.write(qos_language['bbsp_TOS']);</script></option> 
                            <option value="DSCP"><script>document.write(qos_language['bbsp_Type_DSCP']);</script></option> 
                            <option value="LANInterface"><script>document.write(qos_language['bbsp_LANInterface1']);</script></option>
                            <script language="JavaScript" type="text/javascript">
                                document.write('<option value="WANInterface">'+qos_language['bbsp_WANInterface1']+'</option>');
                            </script>
                            <option value="TC"><script>document.write(qos_language['bbsp_TC']);</script></option> 
                            <option value="FL"><script>document.write(qos_language['bbsp_FL']);</script></option>
                            <script language="JavaScript" type="text/javascript">
                            if (Customz_CMCC_RMS == 1) {
                                document.write('<option value="IPVER">'+qos_language['bbsp_IPVER']+'</option>');
                            }
                            </script>
                        </select></td>
                    </tr>
                    <tr id="Type1_trMin">
                        <td  class="table_title width_25p" BindText='bbsp_Min'></td> 
                        <td  class="table_right width_75p"> <input type='text' id='Type1MinValue_text' name='Type1MinValue_text' maxlength="256"/></td> 
                    </tr>
                    <tr id="Type1_trMax">
                        <td  class="table_title width_25p" BindText='bbsp_Max'></td> 
                        <td  class="table_right width_75p"> <input type='text' id='Type1MaxValue_text' name='Type1MaxValue_text' maxlength="256" /></td> 
                    </tr>
                    <tr id="Type1_LANstart">
                        <td  class="table_title width_25p" BindText='bbsp_LANstartedPort'></td> 
                        <td  class="table_right"><select name='Type1LANstart_select'  id="Type1LANstart_select" size='1'/></td>
                    </tr>
                    <tr id="Type1_LANend">
                        <td  class="table_title width_25p" BindText='bbsp_LANendedPort'></td>
                        <td  class="table_right"><select name='Type1LANend_select'  id="Type1LANend_select" size='1'/></td>
                    </tr>
                    <tr> 
                        <td  class="table_title width_25p" BindText='bbsp_Protocolmh1'></td> 
                        <td  class="table_right width_75p"><select name='Type1Protocol_select'  id="Type1Protocol_select" size='1'> 
                            <option value="TCP"><script>document.write(qos_language['bbsp_TCP']);</script></option> 
                            <option value="UDP"><script>document.write(qos_language['bbsp_UDP']);</script></option> 
                            <option value="ICMP"><script>document.write(qos_language['bbsp_ICMP']);</script></option> 
                            <option value="ICMPv6"><script>document.write(qos_language['bbsp_ICMPv6']);</script></option>
                            <option value="RTP"><script>document.write(qos_language['bbsp_RTP']);</script></option> 
                            <option value="TCP,UDP"><script>document.write(qos_language['bbsp_TCPUDP']);</script></option> 
                            <option value=""><script>document.write(qos_language['bbsp_ALL']);</script></option> 
                            </select>
                        </td>
                    </tr>
                </table>
            <div id="DivDataClass2" style="display:block">
                <table cellpadding="0" cellspacing="0" border="0" id="DataClass2_table" width="100%">
                    <tr>
                        <td  class="table_title width_25p" BindText='bbsp_DataClass2mh'></td> 
                        <td  class="table_right"><select name='Type2_select'  id="Type2_select" size='1' onChange="setQosClassType(this.id);">
                            <option value="FIRST_TYPE"><script>document.write(qos_language['bbsp_selectType']);</script></option> 
                            <option value="SMAC"><script>document.write(qos_language['bbsp_SMAC1']);</script></option> 
                            <script language="JavaScript" type="text/javascript">
                                if (Customz_CMCC_RMS == 1) {
                                    document.write('<option value="DMAC">'+qos_language['bbsp_DMAC1']+'</option>');
                                }
                            </script>
                            <option value="8021P"><script>document.write(qos_language['bbsp_Type_8021P']);</script></option> 
                            <option value="SIP"><script>document.write(qos_language['bbsp_SIP1']);</script></option> 
                            <option value="DIP"><script>document.write(qos_language['bbsp_DIP1']);</script></option> 
                            <option value="SPORT"><script>document.write(qos_language['bbsp_SPORT1']);</script></option> 
                            <option value="DPORT"><script>document.write(qos_language['bbsp_DPORT1']);</script></option> 
                            <option value="TOS"><script>document.write(qos_language['bbsp_TOS']);</script></option> 
                            <option value="DSCP"><script>document.write(qos_language['bbsp_Type_DSCP']);</script></option> 
                            <option value="LANInterface"><script>document.write(qos_language['bbsp_LANInterface1']);</script></option>
                            <script language="JavaScript" type="text/javascript">
                                document.write('<option value="WANInterface">'+qos_language['bbsp_WANInterface1']+'</option>');
                            </script>
                            <option value="TC"><script>document.write(qos_language['bbsp_TC']);</script></option> 
                            <option value="FL"><script>document.write(qos_language['bbsp_FL']);</script></option>
                            <script language="JavaScript" type="text/javascript">
                            if (Customz_CMCC_RMS == 1) {
                                document.write('<option value="IPVER">'+qos_language['bbsp_IPVER']+'</option>');
                            }
                            </script>
                            </select></td>        
                    </tr>
                    <tr id="Type2_trMin">
                        <td  class="table_title width_25p" BindText='bbsp_Min'></td> 
                        <td  class="table_right width_75p"> <input type='text' id='Type2MinValue_text' name='Type2MinValue_text' maxlength="256" /></td> 
                    </tr>
                    <tr id="Type2_trMax">
                        <td  class="table_title width_25p" BindText='bbsp_Max'></td> 
                        <td  class="table_right width_75p"> <input type='text' id='Type2MaxValue_text' name='Type2MaxValue_text' maxlength="256" /></td> 
                    </tr>
                    <tr id="Type2_LANstart">
                        <td  class="table_title width_25p" BindText='bbsp_LANstartedPort'></td> 
                        <td  class="table_right"><select name='Type2LANstart_select'  id="Type2LANstart_select" size='1'/></td>
                    </tr>
                    <tr id="Type2_LANend">
                        <td  class="table_title width_25p" BindText='bbsp_LANendedPort'></td>
                        <td  class="table_right"><select name='Type2LANend_select'  id="Type2LANend_select" size='1'/> </td>
                    </tr>
                    <tr> 
                        <td  class="table_title width_25p" BindText='bbsp_Protocolmh1'></td> 
                        <td  class="table_right width_75p"><select name='Type1Protoco2_select'  id="Type2Protocol_select" size='1'> 
                            <option value="TCP"><script>document.write(qos_language['bbsp_TCP']);</script></option> 
                            <option value="UDP"><script>document.write(qos_language['bbsp_UDP']);</script></option> 
                            <option value="ICMP"><script>document.write(qos_language['bbsp_ICMP']);</script></option> 
                            <option value="ICMPv6"><script>document.write(qos_language['bbsp_ICMPv6']);</script></option>
                            <option value="RTP"><script>document.write(qos_language['bbsp_RTP']);</script></option> 
                            <option value="TCP,UDP"><script>document.write(qos_language['bbsp_TCPUDP']);</script></option> 
                            <option value=""><script>document.write(qos_language['bbsp_ALL']);</script></option> 
                            </select>
                        </td>        
                    </tr>
                </table>
            </div>
            <div id="DivDataClass3" style="display:block">
                <table cellpadding="0" cellspacing="0" border="0" id="DataClass3_table" width="100%">
                    <tr>
                        <td  class="table_title width_25p" BindText='bbsp_DataClass3mh'></td> 
                        <td  class="table_right"><select name='Type3_select'  id="Type3_select" size='1' onChange="setQosClassType(this.id);"> 
                            <option value="FIRST_TYPE"><script>document.write(qos_language['bbsp_selectType']);</script></option> 
                            <option value="SMAC"><script>document.write(qos_language['bbsp_SMAC1']);</script></option> 
                            <option value="DMAC"><script>document.write(qos_language['bbsp_DMAC1']);</script></option> 
                            <option value="8021P"><script>document.write(qos_language['bbsp_Type_8021P']);</script></option> 
                            <option value="SIP"><script>document.write(qos_language['bbsp_SIP1']);</script></option> 
                            <option value="DIP"><script>document.write(qos_language['bbsp_DIP1']);</script></option> 
                            <option value="SPORT"><script>document.write(qos_language['bbsp_SPORT1']);</script></option> 
                            <option value="DPORT"><script>document.write(qos_language['bbsp_DPORT1']);</script></option> 
                            <option value="TOS"><script>document.write(qos_language['bbsp_TOS']);</script></option> 
                            <option value="DSCP"><script>document.write(qos_language['bbsp_Type_DSCP']);</script></option> 
                            <option value="LANInterface"><script>document.write(qos_language['bbsp_LANInterface1']);</script></option>
                            <script language="JavaScript" type="text/javascript">
                                document.write('<option value="WANInterface">'+qos_language['bbsp_WANInterface1']+'</option>');
                            </script>
                            <option value="TC"><script>document.write(qos_language['bbsp_TC']);</script></option> 
                            <option value="FL"><script>document.write(qos_language['bbsp_FL']);</script></option>
                            <script language="JavaScript" type="text/javascript">
                            if (Customz_CMCC_RMS == 1) {
                                document.write('<option value="IPVER">'+qos_language['bbsp_IPVER']+'</option>');
                            }
                            </script>
                        </select></td>
                    </tr>
                    <tr id="Type3_trMin">
                        <td  class="table_title width_25p" BindText='bbsp_Min'></td> 
                        <td  class="table_right width_75p"> <input type='text' id='Type3MinValue_text' name='Type3MinValue_text' maxlength="256" /></td> 
                    </tr>
                    <tr id="Type3_trMax">
                        <td  class="table_title width_25p" BindText='bbsp_Max'></td> 
                        <td  class="table_right width_75p"> <input type='text' id='Type3MaxValue_text' name='Type3MaxValue_text' maxlength="256" /></td> 
                    </tr>
                    <tr id="Type3_LANstart">
                        <td  class="table_title width_25p" BindText='bbsp_LANstartedPort'></td> 
                        <td  class="table_right"><select name='Type3LANstart_select'  id="Type3LANstart_select" size='1'/></td> 
                    </tr>
                    <tr id="Type3_LANend">
                        <td  class="table_title width_25p" BindText='bbsp_LANendedPort'></td>
                        <td  class="table_right"><select name='Type3LANend_select'  id="Type3LANend_select" size='1'/></td> 
                    </tr>
                    <tr> 
                        <td  class="table_title width_25p" BindText='bbsp_Protocolmh1'></td> 
                        <td  class="table_right width_75p"><select name='Type1Protoco3_select'  id="Type3Protocol_select" size='1'> 
                            <option value="TCP"><script>document.write(qos_language['bbsp_TCP']);</script></option> 
                            <option value="UDP"><script>document.write(qos_language['bbsp_UDP']);</script></option> 
                            <option value="ICMP"><script>document.write(qos_language['bbsp_ICMP']);</script></option> 
                            <option value="ICMPv6"><script>document.write(qos_language['bbsp_ICMPv6']);</script></option>
                            <option value="RTP"><script>document.write(qos_language['bbsp_RTP']);</script></option> 
                            <option value="TCP,UDP"><script>document.write(qos_language['bbsp_TCPUDP']);</script></option> 
                            <option value=""><script>document.write(qos_language['bbsp_ALL']);</script></option> 
                        </select>
                        </td>        
                    </tr>
                </table>
            </div>
        </div>
        <div class="button_spread"></div>
        <table cellpadding="0" width="100%" class="table_button"> 
            <tr align="right">
                <td class="width_25p" ></td> 
                <td > 
                    <button id="ClassificationModifySubmit_button" name="ClassificationModifySubmit_button" type="button" class="submit" onClick="OnClickDataClassModify();"><script>document.write(qos_language['bbsp_modify']);</script></button> 
                    <button id="ClassificationAddSubmit_button" name="ClassificationAddSubmit_button" type="button" class="submit" onClick="OnClickDataClassAdd();"><script>document.write(qos_language['bbsp_add']);</script></button> 
                    <button id="ClassificationDeleteSubmit_button" name="ClassificationDeleteSubmit_button" class="submit" type="button" onClick="OnClickDataClassDel();"><script>document.write(qos_language['bbsp_del']);</script></button>
                    <button id="btnQosDataClassCancel" name="btnQosDataClassCancel" class="submit" type="button" onClick="CancelConfig('QosDataClass');"><script>document.write(qos_language['bbsp_cancel']);</script></button>
                </td> 
            </tr>     
        </table> 
        <script language="JavaScript" type="text/javascript">
            writeTabTail();
        </script>
        <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
            <tr> 
                <td class="height10p"></td> 
            </tr> 
        </table> 
    </div>
</form> 
<script>
ParseBindTextByTagName(qos_language, "td", 1);
ParseBindTextByTagName(qos_language, "div", 1);
</script>
</body>
</html>
