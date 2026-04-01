<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_ptvdf.asp);%>"></script>
<script language="JavaScript" type="text/javascript"></script>
<script>
var DefaultRule;
var wanInfo = GetWanList();
function GetLanguage(name) {
    return wan_acl_language[name];
}
function WanAccessItemClass(domain, Enable, Protocol, WanName, SrcIPPrefix) {
    this.domain = domain;
    this.Enable = Enable;
    this.Protocol = Protocol;
    this.WanName =  WanName;
    this.SrcIPPrefix =  SrcIPPrefix;
}
 var WanAccessListTemp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.WanAccess.{i},Enable|Protocol|WanName|SrcIPPrefix,WanAccessItemClass);%>;
function GetInitIcmpWan() {
    for (var i = 0; i < truncate(WanAccessListTemp).length; i++) {
        wanName = GetWanFullName(truncate(WanAccessListTemp)[i].WanName);
        if ((wanName.toUpperCase().indexOf("INTERNET") >= 0) && (truncate(WanAccessListTemp)[i].SrcIPPrefix == "") && (truncate(WanAccessListTemp)[i].Protocol == "ICMP")) {
             return truncate(WanAccessListTemp)[i];
        }
    }
    return null;
}
DefaultRule = GetInitIcmpWan(); 
function GetInternetWan() {
    for (var i = 0; i < wanInfo.length; i++) {
        if (wanInfo[i].ServiceList.toUpperCase().indexOf("INTERNET") >= 0) {
            return wanInfo[i].domain;
        }
    }
    return null;
}
function SetInitIcmpWanEnable () {
    if ((DefaultRule != null) && (GetInternetWan() != null)) {
        if (DefaultRule.Enable == 0) {
            document.getElementById("icmpControlService").checked = false;
        } else {
            document.getElementById("icmpControlService").checked = true;
        }
    } else {
        document.getElementById("icmpControlService").checked = false;
    }
 } 

function SubmitIcmpWanStatus() {
    var SubmitData = "";
    if (document.getElementById("icmpControlService").checked == false) {
        SubmitData += "x.Enable=0";
    } else {
        SubmitData += "x.Enable=1";
    }
    var wanNewName = GetInternetWan();
    if (wanNewName != null) {
        if (DefaultRule != null) {
            $.ajax({
                type: "POST",
                async: false,
                cache: false,
                data: SubmitData + "&x.X_HW_Token=" + getValue('onttoken'),
                url: 'set.cgi?x=' + DefaultRule.domain + '&RequestFile=html/bbsp/wanacl/acl_ptvdfUser.asp',
                success: function() {}
            });
        } else {
            if (document.getElementById("icmpControlService").checked == false) {
                return;
            }
            SubmitData += "&x.WanName=" + domainToggle(wanNewName) + "&x.Protocol=ICMP";
            $.ajax({
                type: "POST",
                async: false,
                cache: false,
                data: SubmitData + "&x.X_HW_Token=" + getValue('onttoken'),
                url: 'add.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices.WanAccess&RequestFile=html/bbsp/wanacl/acl_ptvdfUser.asp',
                success: function() {}
            });	
        }
    } else {
        alertVDF(GetLanguage("bbsp_newwan_first")); 
    }
}

function domainTowanname(domainStr) {
    if((domainStr != null) && (domainStr != undefined)) {
        var domainArr = domainStr.split('.');
        var type = (domainStr.indexOf(".ip") == -1) ? 'WANPPPConnection' : 'WANIPConnection' ;
        return 'InternetGatewayDevice.WANDevice' + '.' + domainArr[0].match(/\d+/ig)  + '.' + 'WANConnectionDevice' + '.' + domainArr[1] + '.' + type + '.' +  domainArr[2].match(/\d+/ig);
    }
}
function domainToggle(domain) {
    if((domain != null) && (domain != undefined)) {
        var domaina = domain.split('.');
        var type = (domain.indexOf("WANIPConnection") == -1) ? '.ppp' : '.ip' ;
        return 'wan' + domaina[2]  + '.' + domaina[4] + type + domaina[6] ;
    }
}

function SubmitAction () {
    SubmitIcmpWanStatus();
    location.reload();
}


function loadframe() {
    SetInitIcmpWanEnable();  
}
</script>
</head>
<body  id="wanbody" onload="loadframe();">
    <input type="hidden" id="onttoken"   name="onttoken"     value="<%HW_WEB_GetToken();%>">
<div id="content">
<script> 
    CreatHeaderTitle("Access Control Services", "");
</script>  
<script> 
    var icmpEnableControl = new Array( new tableArrayInfo("checkboxbutton", GetLanguage("wanaclTitle"), "icmpControlService", null));
    CreatSetInfoTable("","icmpEnableStatus", icmpEnableControl);
    CreatApplyButton("SubmitAction()");
</script>
</div>
</body>
</html>
