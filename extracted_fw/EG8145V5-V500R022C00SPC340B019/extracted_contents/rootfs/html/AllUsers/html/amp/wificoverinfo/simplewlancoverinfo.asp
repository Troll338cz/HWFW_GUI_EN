<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1" /><!-IE7 mode->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wificoverinfo_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>

<title>Simple Smart WiFi Coverage</title>
<style type="text/css">
.tabal_01,
.head_title {
    font-size: 12px;
}

.ontIcon {
    width: 30px;
    height: 30px;
    vertical-align: middle;
}
</style>
<script language="JavaScript" type="text/javascript">
'<%HW_WEB_UserDevSendArp();%>';

function LoadResource() {
    var all = document.getElementsByTagName("td");
    for (var i = 0; i < all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }

        if (cfg_wificoverinfo_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wificoverinfo_language[b.getAttribute("BindText")];
        }
    }
}

function LoadFrame() {
    LoadResource();
}

function ShowMainPage(menuJsonData) {
    setDisplay('DivWifiCoverText', 0);
    setDisplay('DivWifiCoverMain', 1);
    AppendDevInfoFunc(menuJsonData, 0);
}

function stMenuData(APInst, DevType, Level, AccessType, MAC, DuplexMode, SpeedInfo, TX, RX, IP) {
    this.APInst = APInst;
    this.DevType = DevType;
    this.Level = Level;
    this.AccessType = AccessType;
    this.MAC = MAC;
    this.DuplexMode = DuplexMode;
    this.SpeedInfo = SpeedInfo;
    this.TX = TX;
    this.RX = RX;
    this.IP = IP;
}

function GetTopoInfoList() {
    $.ajax({
            type : "POST",
            async : true,
            cache : false,
            url : "./getTopoInfo.asp",
            success : function(data) {
            if(data !== '') {
              menuJsonData = dealDataWithStr(data);
            }
            setTimeout('ShowMainPage(menuJsonData)', 500);
            }
    });
}

function AppendDevInfoFunc(menuJsonData, level) {
    for (var menuindex in menuJsonData) {
        var DevType = menuJsonData[menuindex].DevType;
        var MAC = menuJsonData[menuindex].MAC.toUpperCase();
        var IP = menuJsonData[menuindex].IP;
        
        var trHtml = '<tr class="tabal_01">' + 
                     '<td class="align_left">';
                     
        for (var i = 0; i < level; i++) {
            trHtml += '&nbsp;&nbsp;';
        }
        
        var imgHtml = '<img src="../../../images/wifiseticon.png" class="ontIcon">';
        if (level != 0) {
            imgHtml = '<img src="../../../images/linedev.png" class="ontIcon">';
        }
        
        trHtml += imgHtml + DevType + '</td>' + 
                     '<td class="align_center">' + MAC + '</td>' + 
                     '<td class="align_center">' + IP + '</td>' + 
                     '</tr>';
                     
        $("#topoTable").append(trHtml);
        
        if(menuJsonData[menuindex].sub != undefined) {
            var nextLevelDevArray = menuJsonData[menuindex].sub;
            AppendDevInfoFunc(nextLevelDevArray, level + 1);				
        }
        
        if (level == 0) {
            break;
        }
    }
}

</script>

</head>
<body onLoad="LoadFrame();" scrolling ="auto">

<div id='DivWifiCoverText' style='font-size:14px;'>
<script>document.write(cfg_wificoverinfo_language['amp_wificover_loading_text']);</script>
</div>

<div id='DivWifiCoverMain' style='display:none;'>
    <table id='topoTable' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style='overflow:auto;'>
    <tbody>
                <tr class="head_title"> 
                    <td BindText='amp_wificover_config_devtype'></td>
                    <td BindText='amp_wificover_ap_sta_mac'></td>
                    <td BindText='amp_wificover_config_ipaddr'></td>
                </tr>
                <script language="JavaScript" type="text/JavaScript">
                    GetTopoInfoList();			
                </script>
            </tbody>
    </table>
</div>
</body>
</html>
