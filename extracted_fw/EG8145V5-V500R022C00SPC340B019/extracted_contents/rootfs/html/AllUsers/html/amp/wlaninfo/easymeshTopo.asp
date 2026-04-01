<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlaninfo_easymesh_language, cfg_wlancfgother_language);%>"></script>
<script>
var staInfo = '<%WLAN_GetEasymeshTopoInfo();%>';

if(staInfo !== '') {
  staInfo = dealDataWithStr(staInfo);
  var tmp = staInfo;
  staInfo = {};
  staInfo.mac_address = '000000000000';
  staInfo.child_devices = tmp;
}
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var SecondLastDiv ='';
var SecondLastDivIndex = 0;
var thirdLastDivIndex = 0;
var fourthLastDivIndex = 0;
var LastIndexDiv = '';
var emEnableValue = 0;
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var TypeWord='<%HW_WEB_GetTypeWordMode();%>';
var easymeshInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.EasyMesh, Enable, StEasymeshInfo, EXTEND);%>;
var easymeshInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.EasyMesh, Em2GRssiThreshold|Em5GRssiThreshold, EasymeshInfo);%>;
var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    isFitAp = 1;
}

function FitApDisable() {

    setDisable('easyMeshEnable', 1);
}

function EasymeshInfo(domain, Em2GRssiThreshold, Em5GRssiThreshold) {
    this.domain = domain;
    this.Em2GRssiThreshold = Em2GRssiThreshold;
    this.Em5GRssiThreshold = Em5GRssiThreshold;
}

function StEasymeshInfo(domain, enable) {
    this.domain = domain;
    this.enable = enable;
}

function SubmitEasymesh() {
    var enable = getCheckVal('easyMeshEnable');
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "./EasyMeshEnable.asp?&1=1",
        data :"Stats="+enable,
        success : function(data) {
            window.location.reload();
        }
    });
}

function GetMacByNum(mac) {
    return mac[0] + mac[1] + ":" + mac[2] + mac[3] + ":" + mac[4] + mac[5] + ":" + mac[6] + mac[7] + ":" + mac[8] + mac[9] + ":" + mac[10] + mac[11];
}

function ControlHeight(){
    var TranverseLineHeight = $('#secondOntStructId').height() - 100 + 2;
    var ApContralHei = $('#secondOntStructId').height();
    if (SecondLastDiv != '' && LastIndexDiv != '') {
        var secondTop = $('#'+ SecondLastDiv).offset().top;
        var nextTop = $('#'+ LastIndexDiv).offset().top;
        if (secondTop < nextTop) {
            TranverseLineHeight = TranverseLineHeight - (nextTop - secondTop);
        }
    }
    $('#secondStructLine').css("height",TranverseLineHeight+"px");
    $('.ApContralScrool').css("height",ApContralHei+"px");
    if (0 == $('#secondStructLine').height()){
        $('#secondStructLine').css("width","0px");
    } else {
        $('#secondStructLine').css("width","2px");
    }
}

function adjustParentHeight() {
    var h = $("body").outerHeight(true);
    window.parent.document.getElementById("functioncontent").style.height = h + 'px';
}

function LoadFrame() {
    if (easymeshInfo[0] != null) {
        emEnableValue = easymeshInfo[0].enable;
    }
    setCheck("easyMeshEnable", emEnableValue);
    if ((emEnableValue == 1) && (staInfo != "") && (staInfo != undefined)) {
        setEasymeshRoaming();
        setDisplay('easymeshRoaming', 1);
        setDisplay("userdevicetopo", 1);
        setDisplay('devicetopoTitle', 1);
        showMainPage();
        var setHeightTime= setInterval("ControlHeight();",500);
    }
    if ((curWebFrame == 'frame_UNICOM') && ((TypeWord == 'SMART') || (TypeWord == 'V8XXC'))) {
        $(".ApContralScrool").css({ 
            "width": "165%"
        });
        $(".ApLevelStruct div").css("color", "black");
    }
    if (isFitAp == 1) {
        FitApDisable();
    }
}

function showMainPage() {
    AppendFirstDevInfoFunc(staInfo);
}

function ChangeAccessType(AccessType) {
    if (AccessType == "ethernet") {
        return "LAN";
    }

    return "Wi-Fi " + AccessType;
}

function AppendFirstDevInfoFunc(MenuJsonData) {
    var AccessType = MenuJsonData.mac_address.link;
    var MAC = GetMacByNum(MenuJsonData.mac_address.toUpperCase());
    var FirstDevTypeStr = "";
    var FirstMacStr = "";
    FirstDevTypeStr += '<div class="FirstDevTypeStr" id="firstDevType_' + AccessType + '">Role : Controller</div>';
    FirstMacStr += '<div class="FirstMacStr" id="firstMAC_' + MAC + '">'+ "MAC : " + MAC +'</div>';

    $("#firstMountDevInfo").append(FirstDevTypeStr);
    $("#firstMountDevInfo").append(FirstMacStr);

    var firstAgentList = MenuJsonData.child_devices;
    if (firstAgentList.length === 0) {
        $("#ConnectLineShow").css('display','none');
    }
    
    getElementById("gatewayAgentMac").innerHTML = GetMacByNum(firstAgentList[0].mac_address.toUpperCase());

    if ((firstAgentList[0].child_devices && firstAgentList[0].child_devices.length != 0) ||
        (firstAgentList[0].station_info && firstAgentList[0].station_info.length != 0)) {
        var ParentId = "firstOntStruct";
        if (firstAgentList[0].child_devices && firstAgentList[0].child_devices.length != 0)  {
            SecondLevelDevArray = firstAgentList[0].child_devices;
            AppendSecondDevInfoFunc(ParentId, SecondLevelDevArray);
        }
        
        if (firstAgentList[0].station_info && firstAgentList[0].station_info.length != 0)  {
            SecondLevelDevArray = firstAgentList[0].station_info;
            AppendSecondDevInfoStaFunc(ParentId, SecondLevelDevArray);
        }

        setDisplay('ConnectLineShow', 1);
    } else {
        $("#ConnectLineShow").css('display','none');
    }

    setDisplay('firstConnect', 0);
}

var apinst = 0;

function AppendSecondDevInfoFunc(ParentId, DevDateArray) {
    for(var SecondIndex in DevDateArray) {
        apinst++;
        var AccessType = DevDateArray[SecondIndex].link;
        AccessType = ChangeAccessType(AccessType);
        var SecondChildId="";
        
        var i = 0;
        SecondLastDivIndex++;
        var SecondIndexID = "Second_" + SecondLastDivIndex;
        if (SecondIndex == DevDateArray.length -1) {
            SecondLastDiv = SecondIndexID;
        }
        var secondControlHei = "Second_" + SecondLastDivIndex + "_Child";
        var secondContentHeiLine = "Second_" + SecondLastDivIndex + "_Line" + i;
        i++;
        var MAC = GetMacByNum(DevDateArray[SecondIndex].mac_address.toUpperCase());
        var APInst = apinst;
        var SecondSpeedInfoStr = "";
        var secondChildLen = "";
        SecondSpeedInfoStr += '<div class="ssss ssss_'+apinst+'" id="' + SecondIndexID + '" style="position: relative;">'
                           + '<div class="firstConnectLine"  style="float:left;"></div>'
                           + '<div class="secondAccessType_' + apinst + '" style="float:left; text-align: center; margin-top: 23px; width:75px; padding: 0px 6px;">'
                           + '<div id="AccessType_' + DevDateArray[SecondIndex].link + '">'+ AccessType +'</div>'
        SecondSpeedInfoStr += '</div>'
                           + '<div class="firstConnectLine" id="connectLine" style="float:left;"></div>'
                           + '<div  style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">'
                           + '<div class="AccessTypeLine" id="apsecondType_'+ MAC +'"  style="float:left; cursor: pointer; width: 60px;height: 60px;background-position: center center;background-size: 60px 60px;background-repeat: no-repeat;"></div>'
                           + '<table class="topuMsg tabal_02" border="0" cellpadding="0" cellspacing="0" id="topuMsg_'+MAC+'"></table>'
                           + '</div>'
                           + '<div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px;">'
                           + '<div id="secondDevType_' + apinst + '">Role : Agent</div>'
                           + '<div id="secondDevType_' + MAC + '">'+ "MAC : "+ MAC +'</div>'
                           + '</div>';

        if ((DevDateArray[SecondIndex].child_devices.length != 0) || (DevDateArray[SecondIndex].station_info.length != 0)) {
            SecondChildId = SecondIndexID + "_Child";
            SecondSpeedInfoStr +='<div class="firstConnectLine" id="thirdConnectLine"></div>'
                               + '<div style="float:left; left:388px; top:0px;" class="divPosition">'
                               + '<div class="secondStructLine StructLineClass" id="'+secondContentHeiLine+'" style="width:2px; background-color:#d3d3d3; float: left; margin-top: 35px;"></div>'
                               + '<div class="getSecondLineHei" id="' + SecondChildId + '" style="float:left; position: absolute;min-width: 370px;"></div>'
                               + '</div>'
        }
        SecondSpeedInfoStr +='</div>';
        $("#secondOntStruct").append(SecondSpeedInfoStr);
        var lineLarge = 0;
        if ((DevDateArray[SecondIndex].child_devices.length != 0) || (DevDateArray[SecondIndex].station_info.length != 0)) {
            if (DevDateArray[SecondIndex].child_devices.length != 0) {
                ThirdLevelDevArray = DevDateArray[SecondIndex].child_devices;
                lineLarge = AppendThirdDevInfoFunc(SecondChildId, ThirdLevelDevArray);
            }

            if (DevDateArray[SecondIndex].station_info.length != 0) {
                ThirdLevelDevArray = DevDateArray[SecondIndex].station_info;
                lineLarge = AppendThirdDevInfoStaFunc(SecondChildId, ThirdLevelDevArray);
            }
        }
        var ControlHei = $('#' + secondControlHei).height()-100;
        var secondControlMar = $('#' + secondControlHei).height();
        ControlHei  = ControlHei - lineLarge;
        $('#' + secondContentHeiLine).css("height",ControlHei + "px");
        $('#' + secondControlHei).parents('.ssss').css("height",secondControlMar + "px");
    }
}

var staInst = 0;
function AppendSecondDevInfoStaFunc(ParentId, DevDateArray) {
    for(var SecondIndex in DevDateArray) {
        staInst++;
        var AccessType = DevDateArray[SecondIndex].link;
        AccessType = ChangeAccessType(AccessType);
        var SecondChildId="";
        
        var i = 0;
        
        SecondLastDivIndex++;
        var SecondIndexID = "Second_" + SecondLastDivIndex;
        if (SecondIndex == DevDateArray.length -1) {
            SecondLastDiv = SecondIndexID;
        }

        i++;
        var MAC = GetMacByNum(DevDateArray[SecondIndex].station_mac.toUpperCase());
        var SecondSpeedInfoStr = "";
        var secondChildLen = "";
        SecondSpeedInfoStr += '<div class="ssss ssss_' + staInst + '" id="' + SecondIndexID + '" style="position: relative;">'
                           + '<div class="firstConnectLine"  style="float:left;"></div>'
                           + '<div class="secondAccessType_' + staInst + '" style="float:left; text-align: center; margin-top: 23px; width:75px; padding: 0px 6px;">'
                           + '<div id="AccessType_' + DevDateArray[SecondIndex].link + '">'+ AccessType +'</div>'
        SecondSpeedInfoStr += '</div>'
                           + '<div class="firstConnectLine" id="connectLine" style="float:left;"></div>'
                           + '<div  style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">'
                           + '<div class="AccessTypeLine_0" id="stasecondType_'+ MAC +'"></div>'
                           + '<table class="topuMsg tabal_02" border="0" cellpadding="0" cellspacing="0" id="topuMsg_' + MAC+'"></table>'
                           + '</div>'
                           + '<div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px;">'
                           + '<div>Type : Station</div>'
                           + '<div id="secondDevType_' + MAC + '">'+ "MAC : "+ MAC +'</div>'
                           + '</div>';
        SecondSpeedInfoStr +='</div>';
        $("#secondOntStruct").append(SecondSpeedInfoStr);
    }
}

function AppendThirdDevInfoFunc(ParentId, DevDateArray) {
    for (var ThirdIndex in DevDateArray) {
        apinst++;
        thirdLastDivIndex++;
        var APInst = apinst;
        var AccessType = DevDateArray[ThirdIndex].link;
        AccessType = ChangeAccessType(AccessType);
        var ThirdChildId="";
        var ThirdIndexID = "Third_" + thirdLastDivIndex;
        var thirdControlHei = "Third_" + thirdLastDivIndex + "_Child";
        var thirdCtrMar = "Third_" + thirdLastDivIndex + "_Mar";
        var i = 0;
        var thirdContentHeiLine = "Third_" + thirdLastDivIndex + "_Line_" + i;
        i++;
        var secondChildLen="";
        var thirdSpeedInfoStr="";
        var MAC = GetMacByNum(DevDateArray[ThirdIndex].mac_address.toUpperCase());

        LastIndexDiv = 'thirdLastDiv_' + thirdLastDivIndex;
        thirdSpeedInfoStr += '<div class="sssDDDDs ssss_'+APInst +'" id = thirdLastDiv_' + thirdLastDivIndex + '>';
        thirdSpeedInfoStr += '<div class="firstConnectLine"  style="float:left;"></div>'
                           + '<div class="secondAccessType_' + APInst + '" style="float:left; text-align: center; margin-top: 23px; width:75px; padding: 0px 6px;">'
                           + '<div id="AccessType_' + DevDateArray[ThirdIndex].link + '">'+ AccessType +'</div>'
        thirdSpeedInfoStr += '</div>'
                           + '<div class="firstConnectLine" id="connectLine" style="float:left;"></div>'
                           + '<div  style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">'
                           + '<div class="AccessTypeLine" id="apthirdType_'+ MAC +'" style="float:left; cursor: pointer; width: 60px;height: 60px;background-position: center center;background-size: 60px 60px;background-repeat: no-repeat;"></div>'
                           + '<table class="topuMsg tabal_02" border="0" cellpadding="0" cellspacing="0" id="topuMsg_'+MAC+'"></table>'
                           + '</div>'
                           + '<div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px; padding: 0px 5px;">'
                           + '<div id="thirdDevType_' + APInst + '">Role : Agent</div>'
                           + '<div id="thirdDevType_' + MAC + '">'+ "MAC : "+ MAC +'</div>';
        thirdSpeedInfoStr += '</div>';

       if ((DevDateArray[ThirdIndex].child_devices.length != 0) || (DevDateArray[ThirdIndex].station_info.length != 0)) {
            ThirdChildId = ThirdIndexID + "_Child";
            thirdSpeedInfoStr +='<div class="firstConnectLine" id="thirdConnectLine"></div>'
                + '<div style="float:left;left:388px; top:0px;" class="divPosition">'
                + '<div class="secondStructLine StructLineClass" id="'+ thirdContentHeiLine +'" style="width:2px; background-color:#d3d3d3; float: left; margin-top: 35px;"></div>'
                + '<div class="getSecondLineHei" id="' + ThirdChildId + '" style="float:left; position: absolute;min-width: 370px;"></div>'
                + '</div>'
       }
       thirdSpeedInfoStr +='</div>';

        $("#" +ParentId).append(thirdSpeedInfoStr);

        if ((DevDateArray[ThirdIndex].child_devices.length != 0) || (DevDateArray[ThirdIndex].station_info.length != 0)) {
            if (DevDateArray[ThirdIndex].child_devices.length != 0) {
                ThirdLevelDevArray = DevDateArray[ThirdIndex].child_devices;
                AppendFourthDevInfoFunc(ThirdChildId, ThirdLevelDevArray);
            }

            if (DevDateArray[ThirdIndex].station_info.length != 0) {
                ThirdLevelDevArray = DevDateArray[ThirdIndex].station_info;
                AppendFourthDevInfoStaFunc(ThirdChildId, ThirdLevelDevArray);
            }
        }
        var ControlHei = $('#' + thirdControlHei).height()-100;
        var thirdCtrMarHei = $('#' + thirdControlHei).height();
        
        $('#'+thirdContentHeiLine).css("height",ControlHei + "px");
        $('#' + thirdControlHei).parents('.sssDDDDs').css("height",thirdCtrMarHei + "px");
        if (ThirdIndex == DevDateArray.length - 1) {
            if (thirdLastDivIndex != 0 && fourthLastDivIndex != 0) {
                var thisTop = $('#thirdLastDiv_' + (thirdLastDivIndex)).offset().top;
                var nextTop = $('#fourthLastDiv_' + (fourthLastDivIndex)).offset().top;
                if (thisTop < nextTop) {
                    return nextTop - thisTop;
                }
            }
        }
    }
    return 0;
}

function AppendThirdDevInfoStaFunc(ParentId, DevDateArray) {
    for (var ThirdIndex in DevDateArray) {
        staInst++;
        thirdLastDivIndex++;
        var AccessType = DevDateArray[ThirdIndex].link;
        AccessType = ChangeAccessType(AccessType);
        var i = 0;
        i++;
        var thirdSpeedInfoStr="";
        var MAC = GetMacByNum(DevDateArray[ThirdIndex].station_mac.toUpperCase());

        LastIndexDiv = 'thirdLastDiv_' + thirdLastDivIndex;
        thirdSpeedInfoStr += '<div class="sssDDDDs ssss_'+staInst +'" id = thirdLastDiv_' + thirdLastDivIndex + '>';
        thirdSpeedInfoStr += '<div class="firstConnectLine"  style="float:left;"></div>'
                           + '<div class="secondAccessType_' + staInst + '" style="float:left; text-align: center; margin-top: 23px; width:75px; padding: 0px 6px;">'
                           + '<div id="AccessType_' + DevDateArray[ThirdIndex].link + '">'+ AccessType +'</div>'
        thirdSpeedInfoStr += '</div>'
                           + '<div class="firstConnectLine" id="connectLine" style="float:left;"></div>'
                           + '<div  style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">'
                           + '<div class="AccessTypeLine_0" id="stathirdType_'+ MAC +'"></div>'
                           + '<table class="topuMsg tabal_02" border="0" cellpadding="0" cellspacing="0" id="topuMsg_'+MAC+'"></table>'
                           + '</div>'
                           + '<div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px; padding: 0px 5px;">'
                           + '<div>Type : Station</div>'
                           + '<div id="thirdDevType_' + MAC + '">'+ "MAC : "+ MAC +'</div>';
        thirdSpeedInfoStr += '</div>';
        thirdSpeedInfoStr +='</div>';

        $("#" +ParentId).append(thirdSpeedInfoStr);

        if (ThirdIndex == DevDateArray.length - 1) {
            if (thirdLastDivIndex != 0 && fourthLastDivIndex != 0) {
                var thisTop = $('#thirdLastDiv_' + (thirdLastDivIndex)).offset().top;
                var nextTop = $('#fourthLastDiv_' + (fourthLastDivIndex)).offset().top;
                if (thisTop < nextTop) {
                    return nextTop - thisTop;
                }
            }
        }
    }
    return 0;
}

function AppendFourthDevInfoFunc(ParentId, DevDateArray) {
    for (var FourthIndex in DevDateArray) {
        apinst++;
        fourthLastDivIndex++;
        var APInst = apinst;
        var AccessType = DevDateArray[FourthIndex].link;
        AccessType = ChangeAccessType(AccessType);
        var ThirdChildId="";
        var FourthIndexID = "fourth_" + fourthLastDivIndex;
        var secondChildLen="";
        var fourthSpeedInfoStr="";

        var MAC = GetMacByNum(DevDateArray[FourthIndex].mac_address.toUpperCase());
        LastIndexDiv = 'fourthLastDiv_' + fourthLastDivIndex;
        fourthSpeedInfoStr += '<div class="sssDDDDs4 ssss_'+apinst +'" id = fourthLastDiv_'+ fourthLastDivIndex + '>';
        fourthSpeedInfoStr += '<div class="firstConnectLine"  style="float:left;"></div>'
                           + '<div class="secondAccessType_' + apinst + '" style="float:left; text-align: center; margin-top: 23px; width:75px; padding: 0px 6px;">'
                           + '<div id="AccessType_' + DevDateArray[FourthIndex].link + '">'+ AccessType +'</div>'
        fourthSpeedInfoStr += '</div>'
                           + '<div class="firstConnectLine" id="connectLine" style="float:left;"></div>'
                           + '<div  style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">'
                           + '<div class="AccessTypeLine" id="apfoutType_'+ MAC +'" style="float:left; cursor: pointer; width: 60px;height: 60px;background-position: center center;background-size: 60px 60px;background-repeat: no-repeat;"></div>'
                           + '<table class="topuMsg tabal_02" border="0" cellpadding="0" cellspacing="0" id="topuMsg_'+MAC+'"></table>'
                           + '</div>'
                           
                           + '<div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px; padding: 0px 5px;">'
                           + '<div id="thirdDevType_' + apinst + '">Role : Agent</div>'
                           + '<div id="thirdDevType_' + MAC + '">'+ "MAC : "+ MAC +'</div>'
        fourthSpeedInfoStr += '</div>';

        $("#" +ParentId).append(fourthSpeedInfoStr);
    }
}

function AppendFourthDevInfoStaFunc(ParentId, DevDateArray) {
    for (var FourthIndex in DevDateArray) {
        staInst++;
        fourthLastDivIndex++;
        var AccessType = DevDateArray[FourthIndex].link;
        AccessType = ChangeAccessType(AccessType);
        var ThirdChildId="";
        var FourthIndexID = "fourth_" + fourthLastDivIndex;
        var secondChildLen="";
        var fourthSpeedInfoStr="";

        var MAC = GetMacByNum(DevDateArray[FourthIndex].station_mac.toUpperCase());
        LastIndexDiv = 'fourthLastDiv_' + fourthLastDivIndex;
        fourthSpeedInfoStr += '<div class="sssDDDDs4 ssss_'+staInst +'" id = fourthLastDiv_'+ fourthLastDivIndex + '>';
        fourthSpeedInfoStr += '<div class="firstConnectLine"  style="float:left;"></div>'
                           + '<div class="secondAccessType_' + staInst + '" style="float:left; text-align: center; margin-top: 23px; width:75px; padding: 0px 6px;">'
                           + '<div id="AccessType_' + DevDateArray[FourthIndex].link + '">'+ AccessType +'</div>'
        fourthSpeedInfoStr += '</div>'
                           + '<div class="firstConnectLine" id="connectLine" style="float:left;"></div>'
                           + '<div  style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">'
                           + '<div class="AccessTypeLine_0" id="stafoutType_'+ MAC +'"></div>'
                           + '<table class="topuMsg tabal_02" border="0" cellpadding="0" cellspacing="0" id="topuMsg_'+MAC+'"></table>'
                           + '</div>'
                           
                           + '<div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px; padding: 0px 5px;">'
                           + '<div>Type : Station</div>'
                           + '<div id="thirdDevType_' + MAC + '">'+ "MAC : "+ MAC +'</div>'
        fourthSpeedInfoStr += '</div>';

        $("#" +ParentId).append(fourthSpeedInfoStr);
    }
}

function GetIndexResultByMac(mac) {
    for (var i = 0; i < UserDevices.length -1; i++) {
        if (mac.toUpperCase() == UserDevices[i].MacAddr.toUpperCase()) {
            return i;
        }
    }
    return 0;
}

function changeDetialDev(id) {
    var mac = id.split("_")[1];
    var indexResult = GetIndexResultByMac(mac);

    window.top.open("http://" + UserDevices[indexResult].IpAddr, "_blank");
}

function checkDate() {
    var value = parseInt(getSelectVal('rssiThresholdOf2G'));
    if (value < -100 || value > -55) {
        AlertEx(cfg_wlaninfo_easymesh_language['amp_easymesh_threshold_invalid']);
        return false;
    }
    value = getSelectVal('rssiThresholdOf5G');
    if (value < -100 || value > -55) {
        AlertEx(cfg_wlaninfo_easymesh_language['amp_easymesh_threshold_invalid']);
        return false;
    }
    return true;
}

function btnApplySubmit() {
    if (!checkDate()) {
        return;
    }
    setDisable('btnApplySubmit', 0);
    var Form = new webSubmitForm();
    var url = 'set.cgi?x=InternetGatewayDevice.EasyMesh';
    Form.addParameter('x.Em2GRssiThreshold', getSelectVal('rssiThresholdOf2G'));
    Form.addParameter('x.Em5GRssiThreshold', getSelectVal('rssiThresholdOf5G'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction(url + '&RequestFile=html/amp/wlaninfo/easymeshTopo.asp');
    Form.submit();
    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
}

function cancelValue() {
    setEasymeshRoaming();
}

function setEasymeshRoaming() {
    setText('rssiThresholdOf2G', easymeshInfos[0].Em2GRssiThreshold);
    setText('rssiThresholdOf5G', easymeshInfos[0].Em5GRssiThreshold);
}
</script>
<style>
.firstOntIcon,.firstOntStruct,.firstConnectLine,.secondOntStruct,.firstMountDevType{
    float:left;
}
.firstMountDevType{
    margin-top: 25px;
    line-height: 14px;
}
.firstOntIcon {
    width: 60px;
    height: 60px;
    background-image:url(../../../images/wifiseticon.png);
    background-position: left center;
    background-size: 60px 60px;
    background-repeat: no-repeat;
    padding: 0px 5px;
    margin-top:8px;
}
.firstConnectLine {
    padding: 0px 5px;
    width: 22px;
    height:2px;
    background-color:#d3d3d3;
    margin-top: 35px;
}
.ssss {
    min-height:100px;
    background-position: 0px 35px;
    background-repeat: no-repeat;
}

.AccessTypeLine{
    color:#b60000;
    background-image:url(../../../images/wifiseticon.png);
}
.AccessTypeLine_0{
    color:#b60000;
    background-image:url(../../../images/wifiicon.png);
    margin-left: 10px;
    float:left; 
    cursor: pointer; 
    width: 40px;
    height: 60px;
    background-position: center center;
    background-size: 60px 60px;
    background-repeat: no-repeat;
}
.ApLevelStruct {
    width: auto;
    min-width: 100%;
    height:100%;
    color:black;
}
.sssDDDDs{
    min-height:100px;
    clear:both;
    width:780px;
}
.sssDDDDs4 {
    min-height:100px;
    clear:both;
    width:480px;
}
.topuMsg tbody{
    position: absolute;
    width: 320px;
    margin-top: 0px;
}
.topuMsg {
    position: relative;
    width: 350px;
    height: 130px;
    background-image: url(../../../images/topuMsg.png);
    margin-top: 65px;
    left: -130px;
    z-index: 222;
    display: none;
    background-size: 100%;
    color: #fff;
    background-repeat: round;
    padding-top: 15px;
    font-size: 13px;
}
.ethDisMsg div {
    float: left;
    margin: 0px 5px;
    line-height: 24px;
    font-size: 12px;
    color: #fff;
}
.ethDisMsg {
    clear: both;
    margin-left: 10px;
    margin-top: 20px;
}
.tabal_02 th{
    width:16%;
    padding-top: 14px;
}
.topoBlockDiv {
    font-size: 12px;
    width: 100%;
    overflow-x: auto;
    min-height:520px;
    background-color: #f6f6f6;
}
.easymeshRoaming {
    margin : 20px 0px 20px 0px;
}
.easymeshTitle {
    margin : 0px 0px 10px 0px;
}
</style>
</head>
<body onLoad="LoadFrame();"  class="mainbody">
<input type="hidden" id="onttoken"  name="onttoken" value="<%HW_WEB_GetToken();%>"/>
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
    <script language="JavaScript" type="text/javascript">
        HWCreatePageHeadInfo(cfg_wlaninfo_easymesh_language['amp_easymesh_multiap_title'], cfg_wlaninfo_easymesh_language['amp_easymesh_multiap_title'], cfg_wlaninfo_easymesh_language['amp_easymesh_title_note'], false);
    </script>
<div class="title_spread"></div>

<div>
    <form id="UpModeCfgForm" name="UpModeCfgForm">
        <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
            <tr border="1" id="easyMeshEnableTr">
                <td class="table_title width_per25" id="UpModeRadioColleft">
                    <script>
                        document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_enable']);
                    </script>
                </td>
                <td id="easyMeshEnableCol" class="table_right width_per75">
                    <input type="checkbox" id="easyMeshEnable" name="easyMeshEnable" value="ON" onClick="SubmitEasymesh();">
                    <span id="ssidLenTips" class="gray">
                        <script>
                            document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_enable_note']);
                        </script>
                    </span>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="easymeshRoaming" class='easymeshRoaming' style="display: none;">
    <div class='easymeshTitle'>
        <script>document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_setting']);</script>
    </div>
    <table height="50" cellspacing="1" cellpadding="0" width="100%" border="0" class="tabal_noborder_bg" id="tableOf2G">
        <tr class="tabal_01">
            <td class="table_submit width_per25"><script>document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_2Gthreshold']);</script></td>
            <td class="table_right width_per75">
                <label>
                    <input type="text" name="rssiThresholdOf2G" id="rssiThresholdOf2G" class="tb_input" maxlength="32"/>
                </label>
                <script>document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_threshold_tips'])</script>
            </td>
        </tr>
        <tr class="tabal_01">
            <td class="table_title width_per25"><script>document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_5Gthreshold']);</script></td>
            <td class="table_right" id="SSIDInst_2G">
                <label>
                    <input type="text" name="rssiThresholdOf5G" id="rssiThresholdOf5G" class="tb_input" maxlength="32"/>
                </label>
                <script>document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_threshold_tips'])</script>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
            <tr>
                <td class="table_submit width_per25"></td>
                <td class="table_submit">
                <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="btnApplySubmit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
                <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="cancelValue();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
                </td>
            </tr>
        </table>
    </table>
</div>

<div class='easymeshTitle' id='devicetopoTitle' style="display:none;">
    <script>document.write(cfg_wlaninfo_easymesh_language['amp_easymesh_title']);</script>
</div>
<div id="userdevicetopo" class="topoBlockDiv" style="display:none;">
    <div class="ApContralScrool" style="width:145%; min-height:460px;padding-top:40px;padding-bottom: 100px;">
        <div class="ApLevelStruct" id="ApLevelStructDiv">
            <div class="firstOntStruct" id="firstOntStruct" style="margin-left: 10px;">
                <span id='firstConnect' style="display:none;">
                    <div class="firstOntIcon" id="firstOntIcon"></div>
                    <div class="firstMountDevType" id="firstMountDevInfo"></div>
                    <div class="firstConnectLine" id='' style=""></div>
                    <div class="firstConnectLine" id="connectLine" style="float:left;"></div>
                </span>
                    <div style="float:left; cursor: pointer; width: 60px;height: 60px; padding: 5px 5px;">
                        <div class="AccessTypeLine" style="float:left; cursor: pointer; width: 60px;height: 60px;background-position: center center;background-size: 60px 60px;background-repeat: no-repeat;"></div>
                    </div>
                    <div class="secondDevType_Info" style="float:left;margin-top: 23px; width:145px;">
                        <div>Role : Controller</div>
                        <div>MAC : <span id="gatewayAgentMac"></span></div>
                    </div>
                
                <div class="firstConnectLine" id="ConnectLineShow" style="display:none;"></div>
            </div>

            <div class="secondOntStruct" id="secondOntStructId">
                <div class="secondStructLine" id="secondStructLine" style="width:2px; background-color:#d3d3d3; float:left; margin-top: 35px;"></div>
                <div id="secondOntStruct" style="float:left;"></div>
            </div>

            <div style="float:left;">
                <div id="secondOntStructTHIRD" style="float:left"></div>
            </div>
        </div>
    </div>
</div>



</body>
</html>
