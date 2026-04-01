<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<style>
.sntpselectdefcss{
	width:110px;
}
</style>
<script language="JavaScript" type="text/javascript">
var MainUpportConfigDetailList = new Array();
var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
var CurrentIPTVUpInfo = "";
var CurrentLANPortList = new Array();
var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
var LANPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.MultiSrvPortList.PhyPortName);%>'.toUpperCase();
var PortConfigInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,X_HW_MainUpPort|X_HW_UpPortMode|X_HW_UpPortID,stConfigPort);%>;
var PortConfigInfo = PortConfigInfos[0];
var MainUpportModeArray = [];
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum,TopoInfo);%>;
var TopoInfo = TopoInfoList[0];
var portlen = TopoInfoList[0].EthNum;
var OriUpPortMode ='<%HW_WEB_GetOriUpPortMode();%>';
var IsSupportOptic ='<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_OPTIC);%>';
var portalAPType = '<%HW_WEB_GetApMode();%>';
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var IsSHCTA8C = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCTA8C);%>';
var IsFttrEdge = '<%HW_WEB_GetFeatureSupport(FT_FTTR_EDGE_ONT);%>';
var RegNewPageFlag = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT_NEW);%>";
var RegPageFlag = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var fttoFlag = '<%HW_WEB_GetFeatureSupport(FT_CMCC_FTTO);%>';
var xrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_XR);%>';
var isFttrApEbg = '<%HW_WEB_GetFeatureSupport(FT_FTTR_AP_EBG);%>';
var isZqUnicom = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQCU);%>';
var isZq = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';

function stResultInfo(domain, Result, Status)
{
    this.domain = domain;
    this.Result = Result;
    this.Status = Status;
}
var submitUserInfo = 0;
var userInfo = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, Result|Status, stResultInfo);%>';
if ((userInfo != null) && (userInfo[0] != null) && (xrFlag == '1')) {
    submitUserInfo = 1;
}

GetLANPortListInfo();
function GetLANPortListInfo() {
    var tempLANPortValue = "";
    var tempLANPortList = LANPortInfo.split(",");
    var CurLANPortList = new Array();
    for (var i = 0; i < tempLANPortList.length; i++) {		
        if (tempLANPortList[i].indexOf(LANPath.toUpperCase()) != -1) {
            tempLANPortValue = tempLANPortList[i].replace(LANPath.toUpperCase(), "LAN");
        } else {
            tempLANPortValue = tempLANPortList[i].replace(SSIDPath.toUpperCase(), "SSID");
        }

        var tempLANPortInfoList = tempLANPortValue.split(".");
        CurLANPortList[i] = tempLANPortInfoList[0];
    }
    CurrentLANPortList = CurLANPortList;
}

function stConfigPort(domain, X_HW_MainUpPort, X_HW_UpPortMode, X_HW_UpPortID) {
    this.domain = domain;
    this.X_HW_MainUpPort = X_HW_MainUpPort;
    this.X_HW_UpPortMode = X_HW_UpPortMode;
    this.X_HW_UpPortID = X_HW_UpPortID;
}

function TopoInfo(Domain, EthNum, SSIDNum) {   
    this.Domain = Domain;
    this.EthNum = EthNum;
}

if ((IsSHCTA8C == 1) || (isZqUnicom == 1) || (curCfgModeWord.toUpperCase() == "SDCCENTER")) {
    TopoInfo.EthNum = 1;
}
else {
    TopoInfo.EthNum = parseInt(TopoInfo.EthNum);
}

if(TopoInfo.EthNum != "" && TopoInfo.EthNum != undefined) {	
    if ((IsSupportOptic == 1) && (portalAPType == 0)) {
        MainUpportModeArray[0] = "Optical";
        if (curCfgModeWord.toUpperCase() == "AISAP") {
            MainUpportModeArray[1] = "LAN4";
        } else if (curCfgModeWord.toUpperCase() == "SDCCENTER") {
            MainUpportModeArray[1] = "LAN";
            MainUpportModeArray[2] = "SFP GE";
        } else if ((fttoFlag == '1') || (curCfgModeWord.toUpperCase() == "MDSTARNET")) {
            MainUpportModeArray[1] = "LAN1";
        } else {
            MainUpportModeArray[0] = GetDescFormArrayById(ConfigMainUpportDes, "sCMU007");
        for(var i = 1; i <= TopoInfo.EthNum; i++) {
            MainUpportModeArray[i] = "LAN"+i;
            }
        }
    } else {
        if (IsFttrEdge == '1') {
            MainUpportModeArray[0] = "Optical";
            if (isFttrApEbg == '1') {
                for(var i = 1; i <= TopoInfo.EthNum; i++) {
                    MainUpportModeArray[i] = "LAN" + i;
                }
            } else {
                MainUpportModeArray[1] = "LAN4";
            }
        } else if ((curCfgModeWord.toUpperCase() == "SDCREMOTEOUT") || (curCfgModeWord.toUpperCase() == "SDCREMOTEOUTIN")) {
            MainUpportModeArray[0] = "Wi-Fi";
            MainUpportModeArray[1] = "LAN";
        } else {
            for(var i = 0; i < TopoInfo.EthNum; i++) {
                MainUpportModeArray[i] = "LAN"+(i+1);
            }
        }
    }
}

if (curCfgModeWord.toUpperCase() == "T672EPCHINAEBG5") {
    MainUpportModeArray.splice(0);
    MainUpportModeArray.push("GE(SFP)");
    MainUpportModeArray.push("GPON/EPON");
}

GetIPTVPortInfo();
function GetIPTVPortInfo() {
    if (IPTVUpPortInfo.length != 0) {
        var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
        var tempIPTVUpList = tempIPTVUpValue.split(".");
        CurrentIPTVUpInfo = tempIPTVUpList[0];
    }
}

function InitIPTVUpSelectValue() {
    var MainUpPort = getSelectVal('X_HW_MainUpPort');
    if(MainUpPort.toUpperCase() == "OPTICAL") {
        setDisable('IPTVUpPortID',1);
        setSelect("IPTVUpPortID", "");
        return;
    } else {
        setDisable('IPTVUpPortID',0);
    }
    var isNeedAdd = 1;
    var Option = document.createElement("Option");
    Option.value = "";
    Option.innerText = "";
    Option.text = "";
    removeAllOption("IPTVUpPortID");
    getElById("IPTVUpPortID").appendChild(Option);
    for (var i = 1; i <= TopoInfo.EthNum; i++) {
        isNeedAdd = 1;
        lanoption = "LAN" + i;
        for (var j = 0; j < CurrentLANPortList.length; j++) {
            if (lanoption == CurrentLANPortList[j]) {
                isNeedAdd = 0;
                break;
            }
        }
        
        if (isNeedAdd == 1) {
            if(MainUpPort != lanoption) {
                Option = document.createElement("Option");
                Option.value = lanoption;
                Option.innerText = lanoption;
                Option.text = lanoption;
                getElById("IPTVUpPortID").appendChild(Option);
            }
        }
    }
    if (CurrentIPTVUpInfo != "") {
        setSelect("IPTVUpPortID", CurrentIPTVUpInfo);
    }
    return;
}



function LoadFrame() {
    setDisable('X_HW_MainUpPort',0);
    if ((CfgMode.toUpperCase() == "SDCCENTER") && (PortConfigInfo.X_HW_MainUpPort == "LAN2")) {
        setSelect("X_HW_MainUpPort", "LAN");
    } else if (curCfgModeWord.toUpperCase() == "T672EPCHINAEBG5") {
        if(PortConfigInfo.X_HW_UpPortMode == 4) {
            setSelect("X_HW_MainUpPort", "GPON/EPON");
        } else {
            setSelect("X_HW_MainUpPort", "GE(SFP)");
        }
    } else {
        setSelect("X_HW_MainUpPort", PortConfigInfo.X_HW_MainUpPort);
    }
    setDisplay('IPTVUpPortConfigForm', 0);
    if ((RegPageFlag != 0) && (RegNewPageFlag == 1) && (xrFlag != 1)) {
        setDisplay('IPTVUpPortConfigForm', 1);
        InitIPTVUpSelectValue();
    }

    if (CfgMode.toUpperCase() == "SDCCENTER") {
        if (PortConfigInfo.X_HW_UpPortMode == 1) {
            setSelect("X_HW_MainUpPort", "Optical");
        } else if (PortConfigInfo.X_HW_UpPortMode == 3) {
            if (PortConfigInfo.X_HW_UpPortID == 1056769) {
                setSelect("X_HW_MainUpPort", "SFP GE");
            } else if (PortConfigInfo.X_HW_UpPortID == 2) {
                setSelect("X_HW_MainUpPort", "LAN");
            }
        }
    }

    if (CfgMode.toUpperCase() == "SDCREMOTEOUT") {
        if (PortConfigInfo.X_HW_UpPortMode == 8) {
            setSelect("X_HW_MainUpPort", "Wi-Fi");
        } else {
            setSelect("X_HW_MainUpPort", "LAN");
        }
    }
}
								
function CreateMainUpportSelect(list, selectarray) {
    var select = document.getElementById(list);
    for (var i in selectarray) {	
        var isNeedAdd = 1;
        for (var j = 0; j < CurrentLANPortList.length; j++) {
            if (selectarray[i].toUpperCase() == CurrentLANPortList[j].toUpperCase()) {
                isNeedAdd = 0;
                break;
            }
        }
        if(isNeedAdd == 0) {
            continue;
        }
        var opt = document.createElement('option');
        var optShow = selectarray[i];
        var html = document.createTextNode(optShow);
        opt.value = selectarray[i];
        opt.appendChild(html);
        select.appendChild(opt);
    }
}

function updateUPSelect() {
    if ((RegPageFlag != 0) && (RegNewPageFlag == 1)) {
        InitIPTVUpSelectValue();
    }
}

function CommonSubmitForm() {
    var Form = new webSubmitForm();
    var MainUpPort = getSelectVal('X_HW_MainUpPort');
    if (MainUpPort == "Optical") {
        if ((CfgMode.toUpperCase() == "SHCT") && (isZq == 1)) {
            Form.addParameter('z.Status', 99);
            Form.addParameter('z.Result', 99);
        }
        Form.addParameter('x.X_HW_UpPortMode', OriUpPortMode);
        Form.addParameter('x.X_HW_UpPortID', 0x102001);
        if (submitUserInfo == 1) {
            Form.addParameter('z.Status', 99);
            Form.addParameter('z.Result', 99);
            Form.addParameter('c.HttpUnreachableRedirectEnable', 1);
        }
    } else if (MainUpPort == "Wi-Fi") {
        Form.addParameter('x.X_HW_UpPortMode', 8);
        Form.addParameter('x.X_HW_UpPortID', 0x00304008);
    } else if ((MainUpPort == "SFP GE") || (MainUpPort == "GE(SFP)")) {
        Form.addParameter('x.X_HW_UpPortMode', 3);
        Form.addParameter('x.X_HW_UpPortID', 0x102001);
        MainUpPort = "Optical";
    } else if (MainUpPort == "GPON/EPON") {
        Form.addParameter('x.X_HW_UpPortMode', 4);
        Form.addParameter('x.X_HW_UpPortID', 0x102001);
        MainUpPort ="Optical";
    } else {
        if ((CfgMode.toUpperCase() == "SHCT") && (isZq == 1)) {
            Form.addParameter('z.Status', 0);
            Form.addParameter('z.Result', 1);
        }
        Form.addParameter('x.X_HW_UpPortMode', 3);
        if ((CfgMode.toUpperCase() == "SDCCENTER") || (CfgMode.toUpperCase() == "SDCREMOTEOUT") || (CfgMode.toUpperCase() == "SDCREMOTEOUTIN")) {
            MainUpPort = "LAN2";
        }
        if ((CfgMode.toUpperCase() == "SDCREMOTEOUT") || (CfgMode.toUpperCase() == "SDCREMOTEOUTIN")) {
            Form.addParameter('x.X_HW_UpPortID', 2);
        }
        if (submitUserInfo == 1) {
            Form.addParameter('z.Status', 0);
            Form.addParameter('z.Result', 1);
            Form.addParameter('c.HttpUnreachableRedirectEnable', 0);
        }
    }

    if (MainUpPort != "Wi-Fi") {
        Form.addParameter('x.X_HW_MainUpPort', MainUpPort);
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    var paramUrl = 'set.cgi?';
    if (submitUserInfo == 1) {
        paramUrl += '&z=InternetGatewayDevice.X_HW_UserInfo&c=InternetGatewayDevice.LANDevice.1.X_HW_LanService';
    }
    if ((CfgMode.toUpperCase() == "SHCT") && (isZq == 1)) {
        paramUrl += '&z=InternetGatewayDevice.X_HW_UserInfo';
    }
    if ((CfgMode.toUpperCase() == "SDCREMOTEOUT") || (CfgMode.toUpperCase() == "SDCREMOTEOUTIN")) {
        paramUrl += '&x=InternetGatewayDevice.DeviceInfo';
    } else {
        paramUrl += '&x=InternetGatewayDevice.DeviceInfo&y=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard';
    }
    
    paramUrl += '&RequestFile=html/ssmp/mainupportcfg/mainupportconfig.asp';
    Form.setAction(paramUrl);
    if (CfgMode.toUpperCase() == "AHCT") {
        setDisplay('btnApply', 0);
        setDisplay('cancelValue', 0);
        setDisplay('MainUpportConfig', 0);
        setDisplay('UpportConfig', 0);
        setDisplay('resetinfo', 1);
    } else {
        setDisable('btnApply',     1);
        setDisable('cancelValue',  1);
    }
    Form.submit();
}

function ScschoolConfigForm()
{
    setDisable('btnApply', 1);
    setDisable('cancelValue', 1);
    var RequestFile = '&RequestFile=/html/ssmp/mainupportcfg/mainupportconfig.asp';
    var MainUpPort = getSelectVal('X_HW_MainUpPort');
    var parainfo = ""; 
    if(MainUpPort == "Optical") {
        parainfo = "x.X_HW_UpPortMode=" + OriUpPortMode;
        parainfo += "&x.X_HW_UpPortID=" + 0x102001;
    } else {
        parainfo = "x.X_HW_UpPortMode=" + 3;
    }

    parainfo += "&x.X_HW_MainUpPort=" + MainUpPort;
    parainfo += '&x.X_HW_Token=' + getValue('hwonttoken');
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : parainfo,
        url : 'set.cgi?x=InternetGatewayDevice.DeviceInfo' + RequestFile,
        success : function(data) {
        }
    });

    $.ajax({
     type : "POST",
     async : true,
     cache : false,
     data : 'UpModeType=' + MainUpPort + "&x.X_HW_Token=" + getValue('onttoken'),
     url : "ponlanswitch.cgi?" + RequestFile,
     success : function(data) {
     },
     complete: function (XHR, TS) {
        XHR=null;
     }
    });
}

function SubmitUpportConfigForm()
{
    if (ConfirmEx(GetDescFormArrayById(ConfigMainUpportDes, "sCMU003"))) {
        if (CfgMode.toUpperCase() != "SDCREMOTEOUT") {
            $.ajax({
                    type : "POST",
                    async : true,
                    cache : false,
                    url : '/SynchOriUpPortMode.cgi?'+ '&RequestFile=html/ssmp/mainupportcfg/mainupportconfig.asp',
                    data :'x.X_HW_Token=' + getValue('hwonttoken'),
                    success : function(data) {				
                    }
                });

            var tempIPTVUPValue = getSelectVal("IPTVUpPortID").replace("LAN", LANPath);
            $.ajax({
                    type : "POST",
                    async : false,
                    cache : false,
                    data : "y.IPTVUpPort=" + tempIPTVUPValue + "&x.X_HW_Token="+getValue('onttoken'),
                    url : "setajax.cgi?y=InternetGatewayDevice.X_HW_APService&RequestFile=html/ssmp/mainupportcfg/mainupportconfig.asp",
                    success : function(data) {
                    }
                });
        }

        if ((CfgMode.toUpperCase() == "SCSCHOOL") || (CfgMode.toUpperCase() == "MDSTARNET")) {
            ScschoolConfigForm();
        } else {
            CommonSubmitForm();
        }
    } else {
        LoadFrame();
    }
}

function CancelUpportConfig() {
    LoadFrame();
    return;
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
    <script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("UpportConfig", GetDescFormArrayById(ConfigMainUpportDes, "sCMU001"), GetDescFormArrayById(ConfigMainUpportDes, "sCMU000"), false);
    </script>
    <div class="title_spread"></div>
    <div id="resetinfo" style="display:none">设备正在重启，请稍等…</div>
    <div id="MainUpportConfig">
    <form id="MainUpportConfigDetail">
    <table id="MainUpportConfigDetailTable"  cellpadding="0" cellspacing="0" width="100%">
    <li id="X_HW_MainUpPort" RealType="DropDownList" DescRef="sCMU002" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_MainUpPort" InitValue="Empty" Elementclass="sntpselectdefcss" ClickFuncApp="onChange=updateUPSelect"/>
    </table>
    <script>
        MainUpportConfigDetailList = HWGetLiIdListByForm("MainUpportConfigDetail", null);
        HWParsePageControlByID("MainUpportConfigDetail", TableClass, ConfigMainUpportDes, null);
        CreateMainUpportSelect("X_HW_MainUpPort", MainUpportModeArray);
    </script>
    </form>
    </div>
    <form id="IPTVUpPortConfigForm">
    <table id="MainIPTVUpportConfigDetailTable"  cellpadding="0" cellspacing="0" width="100%">
        <li id="IPTVUpPortID" RealType="DropDownList" DescRef="sCMU008" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" Elementclass="sntpselectdefcss" InitValue="Empty"/>
    </table>
    <script>
        var UsbConfigFormList = HWGetLiIdListByForm("IPTVUpPortConfigForm", null);
        HWParsePageControlByID("IPTVUpPortConfigForm", TableClass, ConfigMainUpportDes, null);
    </script>
    </form>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
        <tr>
            <td class="table_submit width_per30"></td>
            <td class="table_submit">
                <input type="button" name="btnApply" id="btnApply" class="ApplyButtoncss buttonwidth_100px"  BindText="sCMU005" onClick="SubmitUpportConfigForm();" />
                <input type="button" name="btnCancle" id="btnCancle" class="CancleButtonCss buttonwidth_100px" BindText="sCMU006" onClick="CancelUpportConfig();" />
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            </td>
        </tr>
    </table>
    <script>
        ParseBindTextByTagName(ConfigMainUpportDes, "td",     1);
        ParseBindTextByTagName(ConfigMainUpportDes, "span",   1);
        ParseBindTextByTagName(ConfigMainUpportDes, "input",  2);
    </script>
</body>
</html>

