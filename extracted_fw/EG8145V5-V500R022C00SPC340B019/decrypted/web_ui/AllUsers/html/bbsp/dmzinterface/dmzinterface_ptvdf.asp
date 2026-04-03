<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<script language="javascript" src="/html/bbsp/common/<%HW_WEB_DeepCleanCache_Resource(wan_list_ptvdf.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<style>
.apply-cancel{
    width: 716px;
}
</style>
<script>
function stDmzinterface(domain,Interface, PhyPortName, IPAddress, SubnetMask, Enable) {
    this.domain = domain;
    this.Interface = Interface;
    this.PhyPortName = PhyPortName;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;
    this.Enable = Enable;
}

var dmzInterfaceArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DMZ_Interface, Interface|PhyPortName|IPAddress|SubnetMask|Enable, stDmzinterface);%>; 
var dmzInfo = dmzInterfaceArr[0];

var TopoEthNum = '<%GetLanPortNum();%>';

function stLayer3Enable(domain, lay3enable)
{
    this.domain   = domain;
    this.L3Enable = lay3enable;
}

var Lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 

function MakeLANName(domain) {
     var InstId = domain.split('.')[4];

     if (isNaN(InstId) || parseInt(InstId) < 0 || parseInt(InstId) > TopoEthNum) {
        return "--";
     } else {
        return ("LAN" + InstId);
     }
}

function IsL3Mode(LanId)
{
    if (parseInt(LanId) >= Lay3Enables.length){
        return "null";
    }
    return Lay3Enables[parseInt(LanId)-1].L3Enable;
}

var wanAllList = GetWanList();
var wanList = new Array();
for (var i = 0; i < wanAllList.length; i++) {
    if ((wanAllList[i].Mode == 'IP_Routed') && (wanAllList[i].X_HW_IPv4Enable == '1') && (wanAllList[i].ServiceList.toUpperCase().indexOf("INTERNET") > -1)) {
        wanList.push(wanAllList[i]);
    }
}

var lanPortArr = ["lanportlist"]
for (var i = 0; i < parseInt(TopoEthNum); i++) {
    if (IsL3Mode(i + 1) == "1") {
        lanPortArr.push(Lay3Enables[i].domain);
        lanPortArr.push(MakeLANName(Lay3Enables[i].domain));
    }
}

var wanPortArr = ["wanportlist"];
for (var i = 0; i< wanList.length; i++) {
    wanPortArr.push(wanList[i].domain);
    wanPortArr.push(wanList[i].Description);
}

var dmzEnableTable = new Array(new tableArrayInfo("switchbutton", dmzinterface_language["bbsp_mune"], "dmzenable", "changeDmzEnable()"));
var dmzInterfaceTable = new Array(new tableArrayInfo("select", dmzinterface_language["bbsp_LANPort"], lanPortArr, ""),
                                  new tableArrayInfo("select", dmzinterface_language["bbsp_waninterface"], wanPortArr, ""),
                                  new tableArrayInfo("iptable", dmzinterface_language["bbsp_dmzinterface_ip"], "ipaddress", ""),
                                  new tableArrayInfo("iptable", dmzinterface_language["bbsp_dmzinterface_submask"], "subnetmask", ""));

function setDisplay(id, flag) {
    document.getElementById("disabledtips").style.display = (flag == 1) ? "block" : "none";
}

function CheckDMZinterface() {
    var wanport = getSelectValue("wanportlist");
    var ipaddress = getIPtableValue("ipaddress");
    var subnetmask = getIPtableValue("subnetmask");

    for (var i = 0; i < wanList.length; i++) {
        if ((wanList[i].domain == wanport) && (wanList[i].NATEnabled < 1)) {
            alertVDF(dmzinterface_language['bbsp_natof'] + wanList[i].Description + dmzinterface_language['bbsp_disable']);
            return false;
        }
        
        if (wanList[i].IPv4NATEnable < 1) {
            alertVDF(dmzinterface_language['bbsp_natof'] + wanList[i].Description + dmzinterface_language['bbsp_disable']);
            return false;
        }
    }

    if (ipaddress== '') {
        alertVDF(dmzinterface_language['bbsp_dmzisreq']);
        return false;
    }

    if (isAbcIpAddress(ipaddress) == false )  {
        alertVDF(dmzinterface_language['bbsp_dmzinvalid']);
        return false;
    }

    if (subnetmask == "" ) {
        alertVDF(dmzinterface_language['bbsp_alert_masknill']);
        return false;
    }

    if ((isValidSubnetMask(subnetmask) == false) || (subnetmask == '255.255.255.255')) {
        alertVDF(dmzinterface_language['bbsp_alert_mask'] + subnetmask + dmzinterface_language['bbsp_alert_invail']);
        return false;
    }

   return true;
}

function submitDmzInterface() {
    if (!CheckDMZinterface()) {
        return;
    }
    var dmzFrom = new webSubmitForm();
    var dmzEnableValue = getValueById("dmzenable");
    if (dmzEnableValue == "1") {
        dmzFrom.addParameter("x.Interface", getSelectValue("wanportlist"));
        dmzFrom.addParameter("x.PhyPortName", getSelectValue("lanportlist"));
        dmzFrom.addParameter("x.IPAddress", getIPtableValue("ipaddress"));
        dmzFrom.addParameter("x.SubnetMask", getIPtableValue("subnetmask"));
    }
    dmzFrom.addParameter("x.Enable", dmzEnableValue);
    dmzFrom.addParameter("x.X_HW_Token", getValueById("onttoken"));
    dmzFrom.setAction("set.cgi?x=InternetGatewayDevice.X_HW_DMZ_Interface&RequestFile=html/bbsp/dmzinterface/dmzinterface_ptvdf.asp");
    dmzFrom.submit();
}

function changeDmzEnable() {
    setDisplayTable("dmzinterface", getValueById("dmzenable"))
}

function loadframe() {
    initSelectIndex();
    document.getElementById("dmzenabletable").classList.remove("padding_b50");
    setSwitchButton("dmzenable", dmzInfo.Enable);
    setDisplayTable("dmzinterface", dmzInfo.Enable);
    setSelectValue("lanportlist", dmzInfo.PhyPortName);
    setSelectValue("wanportlist", dmzInfo.Interface);
    setIPtableValue("ipaddress", dmzInfo.IPAddress);
    setIPtableValue("subnetmask", dmzInfo.SubnetMask);
}

function doOk() {
    document.getElementById("alertblackBackground").style.display = "none";
}

</script>
</head>
<body  id="wanbody" onload="loadframe();">
<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
<div class="blackBackground" id="indexblackBackground" style="display:none;"></div>
<div class="blackBackground" id="alertblackBackground" style="z-index:301;display:none;">
    <div id="alertFrom" class="alertpopup">
        <div class="alerttext"><span id="alertspan"></span></div>
        <div class="alertpop"><input id="alertbtn" type="button" value="OK" onclick="doOk()" class="button button-apply W100"/></div>
    </div>
</div>
<div id="content">
<script>
    CreatHeaderTitle(dmzinterface_language["ptvdf_title"], "");

    CreatSetInfoTable("", "dmzenabletable", dmzEnableTable);

    CreatSetInfoTable("", "dmzinterface", dmzInterfaceTable);

    CreatApplyButton("submitDmzInterface()");
</script>
</div>

</body>
</html>
