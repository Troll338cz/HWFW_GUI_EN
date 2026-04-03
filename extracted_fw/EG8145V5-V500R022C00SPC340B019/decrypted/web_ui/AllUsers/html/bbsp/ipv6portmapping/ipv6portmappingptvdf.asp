<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_ptvdf.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script>
var curPortMappingNum = 0;
var curPortMappingIndex = 0;
var maxPortMappingIndex = 32;
var curPortMappingList = [];
var g_curPortMappingInst = "";

var isEditflag = true;
var firstInterWanDomain = GetFirstIPv6InternetWan();

var lanIPDataInfo = ["",];
var wanInfo = GetWanList();
var applyPortMappingDomian = "";

function GetUserDevAlias(obj) {
    if (obj.UserDevAlias != "--") {
        return obj.UserDevAlias;
    } else if (obj.HostName != "--") {
        return obj.HostName;
    } else {
        return obj.MacAddr;
    }
}

function getLanguage(name) {
    return ip6portMapping_language[name]
}

function stPortMappingPortList(domain, Protocol, InternalPort) {
    this.domain = domain;
    this.Protocol = Protocol;
    this.InternalPort = InternalPort;
}

function stPortMap(domain, Enabled, InternalClient, RemoteHost, RemoteHostRange, Description, MacAddress) {
    this.domain = domain;
    this.Enabled = Enabled;
    this.InClient = InternalClient;	
    this.RemoteHost = RemoteHost;
    this.RemoteHostRange = RemoteHostRange;	
    this.Description = Description;
    this.MacAddress = MacAddress;
}

var WanIPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_IPv6.PortForward.{i}.Portlist.{i},Protocol|InternalPortList,stPortMappingPortList);%>;
var WanPPPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_IPv6.PortForward.{i}.Portlist.{i},Protocol|InternalPortList,stPortMappingPortList);%>;
var WanIPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_IPv6.PortForward.{i},Enabled|InternalClient|RemoteHost|RemoteHostRange|Description|X_HW_MAC,stPortMap);%>;
var WanPPPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_IPv6.PortForward.{i},Enabled|InternalClient|RemoteHost|RemoteHostRange|Description|X_HW_MAC,stPortMap);%>; 

function stPortMapListInst() {
    this.domain = "";
    this.Name = "";
    this.MacAddress = "";
    this.Enabled = 1;
    this.RemoteHost = "";
    this.RemoteHostRange = "";
    this.InClient = "";
    this.Protocol = "";
    this.InternalPort = "";
    this.InternalPortEnd = "";

    this.EditFlag = "";
    this.LineID = "";
}

var portMappingListAll = [];
for (var i = 0; i < WanIPPortMapping.length -1; i++) {
    var tmpPMInst = new stPortMapListInst();
    tmpPMInst.domain = WanIPPortMapping[i].domain;
    var pmName = WanIPPortMapping[i].Description == "" ? "--" : WanIPPortMapping[i].Description;
    tmpPMInst.Name = pmName;
    tmpPMInst.Enabled = WanIPPortMapping[i].Enabled;
    tmpPMInst.MacAddress = WanIPPortMapping[i].MacAddress;
    tmpPMInst.RemoteHost = WanIPPortMapping[i].RemoteHost;
    tmpPMInst.RemoteHostRange = WanIPPortMapping[i].RemoteHostRange;
    tmpPMInst.InClient = WanIPPortMapping[i].InClient;
    for (var j = 0; j < WanIPPortMappingPortList.length - 1; j++) {
        if (WanIPPortMappingPortList[j].domain == (WanIPPortMapping[i].domain + ".Portlist.1")) {
            tmpPMInst.Protocol = WanIPPortMappingPortList[j].Protocol

            var portList = WanIPPortMappingPortList[j].InternalPort.toString().split(':');
            tmpPMInst.InternalPort = portList[0];
            tmpPMInst.InternalPortEnd = portList[0];
            if (portList.length > 1) {
                tmpPMInst.InternalPortEnd = portList[1];
            }
        }
    }
    portMappingListAll.push(tmpPMInst);
}

for (var i = 0; i < WanPPPPortMapping.length -1; i++) {
    var tmpPMInst = new stPortMapListInst();
    tmpPMInst.domain = WanPPPPortMapping[i].domain;
    var pmName = WanPPPPortMapping[i].Description == "" ? "--" : WanPPPPortMapping[i].Description;
    tmpPMInst.Name = pmName;
    tmpPMInst.Enabled = WanIPPortMapping[i].Enabled;
    tmpPMInst.MacAddress = WanIPPortMapping[i].MacAddress;
    tmpPMInst.RemoteHost = WanPPPPortMapping[i].RemoteHost;
    tmpPMInst.RemoteHostRange = WanPPPPortMapping[i].RemoteHostRange;
    tmpPMInst.InClient = WanPPPPortMapping[i].InClient;
    for (var j = 0; j < WanPPPPortMappingPortList.length - 1; j++) {
        if (WanPPPPortMappingPortList[j].domain == (WanPPPPortMapping[i].domain + ".X_HW_Portlist.1")) {
            tmpPMInst.Protocol = WanPPPPortMappingPortList[j].Protocol

            var portList = WanPPPPortMappingPortList[j].InternalPort.toString().split(':');
            tmpPMInst.InternalPort = portList[0];
            tmpPMInst.InternalPortEnd = portList[0];
            if (portList.length > 1) {
                tmpPMInst.InternalPortEnd = portList[1];
            }
        }
    }
    portMappingListAll.push(tmpPMInst);
}

function initPortMappingData() {
    if (portMappingListAll.length > 0) {
        for (var i = 0; i < portMappingListAll.length; i++) {
            addNewPortMappingLine(portMappingListAll[i]);
        }
    }
}

function creatInfoLine(id, val) {
    var html = '<div id="' + id + '" class="table-col padding20" title="' + val + '">';
    html += restrictingLength(val, 20) + '</div>'
    return html;
}

function addNewPortMappingLine(portMappingStLine) {
    var htmlinfo = "";
    htmlinfo += '<div class="table-row" id="addPortmapping_' + curPortMappingNum + '">'
    htmlinfo += creatEscapeInfoLine("portmappingname_" + curPortMappingNum, portMappingStLine.Name);
    htmlinfo += creatInfoLine("pmprotocol_" + curPortMappingNum, portMappingStLine.Protocol);
    htmlinfo += creatInfoLine("localipaddress_" + curPortMappingNum, portMappingStLine.InClient);
    htmlinfo += creatInfoLine("externalhost_" + curPortMappingNum, portMappingStLine.RemoteHost);
    htmlinfo += '<div class="table-col padding20">';
    htmlinfo += '<input class="button button-edit" type="button" onclick="editPortMappingLine(this)">';
    htmlinfo += '</div>';
    htmlinfo += '<div class="table-col padding20">';
    htmlinfo += '<input class="button button-delete" type="button" onclick="deletePortMappingLine(this)">';
    htmlinfo += '</div>';
    htmlinfo += '<div class="table-col fR tR padding20">';
    htmlinfo += '<div class="button button-on buttonbackon linebutton" id= "portmpEnablebtn_' + curPortMappingNum + '" onclick="disableEnableLine(this);EnableIpv6PortMappingItem(this)">';
    htmlinfo += '</div></div>';
    htmlinfo += '</div>';

    document.getElementById("Ipv6PortMappingTable_add").insertAdjacentHTML("beforeBegin", htmlinfo);
    portMappingStLine.LineID = curPortMappingNum;
    setLineEnable('portmpEnablebtn_' + curPortMappingNum, portMappingStLine.Enabled)

    curPortMappingList.push(portMappingStLine);
    curPortMappingNum++;
    curPortMappingIndex++;
}

function deletePortMappingLine(obj) {
    var portMappingInst = obj.parentElement.parentElement.id;
    document.getElementById(portMappingInst).style.display = "none";
    var Index = getArrLineById(portMappingInst, curPortMappingList);
    if (Index == -1) {
        return;
    } else if (curPortMappingList[Index].EditFlag != "ADD") {
        curPortMappingList[Index].EditFlag = "DEL";
    } else {
        curPortMappingList.splice(Index, 1);
    }
    curPortMappingIndex--;
}

function editPortMappingLine(obj) {
    if ((firstInterWanDomain == "") || (firstInterWanDomain == null)) {
        alertVDF(ipv6portmapping_language["bbsp_creatwan"]);
        return;
    }

    var portMappingLineId = obj.parentElement.parentElement.id;
    if (portMappingLineId == "Ipv6PortMappingTable_add") {
        if (curPortMappingIndex >= maxPortMappingIndex) {
            alertVDF(ipv6portmapping_language["bbsp_mappingfull"]);
            return;
        }
        g_Editflag = "ADD";
        g_curPortMappingInst = "";
        document.getElementById("editPortMappingTable_title").innerHTML = getLanguage("ipv6port014");
        initPortMappingInst();
    } else {
        g_Editflag = "SET";
        g_curPortMappingInst = portMappingLineId.split("_")[1];
        document.getElementById("editPortMappingTable_title").innerHTML = getLanguage("ipv6port015");
        for (var i = 0; i < portMappingListAll.length; i++) {
            if (g_curPortMappingInst == portMappingListAll[i].LineID) {
                setPortMappingInst(portMappingListAll[i]);
            }
        }
    }

    displayPopupTable('editPortMappingTable');
}

function initPortMappingInst() {
    setValueById("portMappingName", "");
    setSelectValue("selectDevice", 0);
    setDeviceLine(0);
    setValueById("sourceIPAddress", "")
    setSelectValue("selectPortol", "TCP/UDP");
    portToggleRange("typeMode", 0);
    setValueById("publicPort", "");
    setValueById("publicPortRange1", "");
    setValueById("publicPortRange2", "");
}

function setDeviceLine(flag) {
    setValueById("internalhostinput", "")
    setMactableValue("selectMACaddress", "")

    displayRowById("selectHost", flag);
    displayRowById("internalhostinput", 1 - flag);
}

function setPortMappingInst(portMappingInst) {
    setValueById("portMappingName", portMappingInst.Name);
    setSelectValue("selectDevice", 0);
    setDeviceLine(0);
    setValueById("internalhostinput", portMappingInst.InClient)
    setMactableValue("selectMACaddress", portMappingInst.MacAddress)
    setValueById("sourceIPAddress", portMappingInst.RemoteHost)
    setSelectValue("selectPortol", portMappingInst.Protocol);
    
    if (portMappingInst.InternalPort == portMappingInst.InternalPortEnd) {
        portToggleRange("typeMode", 0);
        setValueById("publicPort", portMappingInst.InternalPort);
        setValueById("publicPortRange1", "");
        setValueById("publicPortRange2", "");
    } else {
        portToggleRange("typeMode", 1);
        setValueById("publicPort", "");
        setValueById("publicPortRange1", portMappingInst.InternalPort);
        setValueById("publicPortRange2", portMappingInst.InternalPortEnd);
    }
}

function getPortMappingInst() {
    var curStPortMappingInst = new stPortMapListInst();
    curStPortMappingInst.Name = getValueById("portMappingName");
    curStPortMappingInst.MacAddress = getMactableValue("selectMACaddress");
    curStPortMappingInst.Protocol = getSelectValue("selectPortol");
    curStPortMappingInst.InClient = getValueById("internalhostinput");
    curStPortMappingInst.RemoteHost = getValueById("sourceIPAddress");
    var typeModeFlag = getRadioValue("typeMode");
    if (typeModeFlag == 0) {
        curStPortMappingInst.InternalPort = getValueById("publicPort");
        curStPortMappingInst.InternalPortEnd = getValueById("publicPort");
    } else {
        curStPortMappingInst.InternalPort = getValueById("publicPortRange1");
        curStPortMappingInst.InternalPortEnd = getValueById("publicPortRange2");
    }

    return curStPortMappingInst;
}

function changePortMappingInst(curStPMInst, setStPMInst) {
    setStPMInst.Name = curStPMInst.Name;
    setStPMInst.MacAddress = curStPMInst.MacAddress;
    setStPMInst.RemoteHost = curStPMInst.RemoteHost;
    setStPMInst.InClient = curStPMInst.InClient;
    setStPMInst.Protocol = curStPMInst.Protocol;
    setStPMInst.InternalPort = curStPMInst.InternalPort;
    setStPMInst.InternalPortEnd = curStPMInst.InternalPortEnd;
    if (setStPMInst.EditFlag == "") {
        setStPMInst.EditFlag = "SET";
    }
}

function PortMappingApply() {
    var curStPMInst = getPortMappingInst();
    if (CheckPortMappingCfg(curStPMInst) == false) {
        return false;
    }

    if (g_Editflag == "ADD") {
        curStPMInst.EditFlag = "ADD"
        addNewPortMappingLine(curStPMInst);
    } else {
        for (var i = 0; i < curPortMappingList.length; i++) {
            if (g_curPortMappingInst == curPortMappingList[i].LineID) {
                setLineInfo("portmappingname_" + g_curPortMappingInst, escapeHTML(curStPMInst.Name));
                setLineInfo("pmprotocol_" + g_curPortMappingInst, curStPMInst.Protocol);
                setLineInfo("localipaddress_" + g_curPortMappingInst, curStPMInst.InClient);
                setLineInfo("externalhost_" + g_curPortMappingInst, curStPMInst.RemoteHost);
                changePortMappingInst(curStPMInst, curPortMappingList[i])
            }
        }
    }

    cancelPopupTable("editPortMappingTable");
}

function PortMappingSubmit() {
    var PortMappingUrl = "complex.cgi?";
    var PortMappingData = "";

    var PortMappingDelUrl = "";
    var PortMappingSetUrl = "";

    for (var i = 0; i < curPortMappingList.length; i++) {
        if (curPortMappingList[i].EditFlag.toUpperCase() == "DEL") {
            PortMappingDelUrl += 'Del_y' + i + '=' + curPortMappingList[i].domain + '&';
        } else if (curPortMappingList[i].EditFlag.toUpperCase() == "SET") {
            PortMappingData += 'y' + i + '.Enabled=' + curPortMappingList[i].Enabled + '&';
            PortMappingData += 'y' + i + '.Description=' + curPortMappingList[i].Name + '&';
            PortMappingData += 'y' + i + '.RemoteHost=' + curPortMappingList[i].RemoteHost + '&';
            PortMappingData += 'y' + i + '.X_HW_MAC=' + curPortMappingList[i].MacAddress + '&';
            PortMappingData += 'y' + i + '.InternalClient=' + curPortMappingList[i].InClient + '&';

            PortMappingData += 'z' + i + '.Protocol=' + curPortMappingList[i].Protocol + '&';
            PortMappingData += 'z' + i + '.InternalPortList=' + curPortMappingList[i].InternalPort + ":" + curPortMappingList[i].InternalPortEnd + '&';

            PortMappingSetUrl += 'y' + i + '=' + curPortMappingList[i].domain + '&';
            PortMappingSetUrl += 'z' + i + '=' + curPortMappingList[i].domain + ".Portlist.1" + '&';
        } else {
            continue;
        }
    }

    PortMappingData += "x.X_HW_Token=" + getValueById('onttoken');
    PortMappingUrl += PortMappingDelUrl + PortMappingSetUrl + "RequestFile=html/bbsp/ipv6portmapping/ipv6portmappingptvdf.asp";
    submitDataVDF(PortMappingData, PortMappingUrl);

    for (var i = 0; i < curPortMappingList.length; i++) {
        if (curPortMappingList[i].EditFlag.toUpperCase() != "ADD") {
            continue;
        }
        PortMappingData = 'Group_a_m.Enabled=' + curPortMappingList[i].Enabled + '&';
        PortMappingData += 'Group_a_m.Description=' + curPortMappingList[i].Name + '&';
        PortMappingData += 'Group_a_m.RemoteHost=' + curPortMappingList[i].RemoteHost + '&';
        PortMappingData += 'Group_a_m.X_HW_MAC=' + curPortMappingList[i].MacAddress + '&';
        PortMappingData += 'Group_a_m.InternalClient=' + curPortMappingList[i].InClient + '&';

        PortMappingData += 'Group_a_n.Protocol=' + curPortMappingList[i].Protocol + '&';
        PortMappingData += 'Group_a_n.InternalPortList=' + curPortMappingList[i].InternalPort + ":" + curPortMappingList[i].InternalPortEnd + '&';

        PortMappingUrl = 'addcfgajax.cgi?Group_a_m=' + firstInterWanDomain.domain + '.X_HW_IPv6.PortForward';
        PortMappingUrl += '&Group_a_n=Group_a_m.Portlist';
        PortMappingData += "x.X_HW_Token=" + getValueById('onttoken');
        PortMappingUrl += "&RequestFile=html/bbsp/ipv6portmapping/ipv6portmappingptvdf.asp";
        submitDataVDF(PortMappingData, PortMappingUrl);
    }
    
    window.location = "ipv6portmappingptvdf.asp";
}

function USERDeviceList(Domain,UserDevAlias,MacAddr,HostName,IPv4Enabled,IPv6Enabled) {
    this.domain = Domain;
    this.MacAddr = MacAddr;
    this.HostName = HostName;
    this.UserDevAlias = UserDevAlias;
    this.IPv4Enabled = IPv4Enabled;
    this.IPv6Enabled = IPv6Enabled;
}

var UserDevinfoList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecialGetUserDevInfo,InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i},UserDevAlias|MacAddr|HostName|IPv4Enabled|IPv6Enabled ,USERDeviceList);%>;

function USERv6Device(domain, IPv6Addr, IPv6Scope, DevStatus) {
    this.domain = domain;
    this.IPv6Addr = IPv6Addr;
    this.IPv6Scope = IPv6Scope;
    this.DevStatus = DevStatus;
}
var UserDev6info = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i}.IPv6Address.{i},IP|Scope|DevStatus, USERv6Device);%>;

function ipv6UserDevInst() {
    this.domain = "";
    this.MacAddr = "";
    this.Device = "";
    this.IPv6Addr = "";
    this.DevStatus = "";
}

var ipv6UserDevList = [];
for (var i = 0; i < UserDevinfoList.length - 1; i++) {
    if (UserDevinfoList[i].IPv6Enabled == 0) {
        continue;
    }

    var ipv6UserDevTmp = new ipv6UserDevInst();
    ipv6UserDevTmp.domain = UserDevinfoList[i].domain;
    ipv6UserDevTmp.MacAddr = UserDevinfoList[i].MacAddr;
    if (UserDevinfoList[i].UserDevAlias != "") {
        ipv6UserDevTmp.Device = UserDevinfoList[i].UserDevAlias;
    } else if (UserDevinfoList[i].HostName != "") {
        ipv6UserDevTmp.Device = UserDevinfoList[i].HostName;
    } else {
        ipv6UserDevTmp.Device = UserDevinfoList[i].MacAddr;
    }

    var indexPath = UserDevinfoList[i].domain + ".IPv6Address";
    var addressList = [];
    for (var j = 0; j < UserDev6info.length -1; j++) {
        if ((UserDev6info[j].domain.indexOf(indexPath) > -1) && (UserDev6info[j].IPv6Scope.toUpperCase() == "GUA") &&
            (UserDev6info[j].DevStatus.toUpperCase() == "ONLINE")) {
                addressList.push(UserDev6info[j].IPv6Addr)
        }
    }
    ipv6UserDevTmp.IPv6Addr = addressList;
    ipv6UserDevList.push(ipv6UserDevTmp);
}

function setIPv6SelectDevice() {
    var curIndex = getSelectValue("selectDevice");
    if (curIndex == 0) {
        setDeviceLine(0);
        return;
    }
    setDeviceLine(1);
    var internalhostVal = [];
    internalhostVal = ipv6UserDevList[curIndex - 1].IPv6Addr;
    var macaddressVal = ipv6UserDevList[curIndex - 1].MacAddr;

    setMactableValue("selectMACaddress", macaddressVal);
    $("#selectHost_hide").empty();
    var selectHtml = '';
    for (var i = 0; i < internalhostVal.length; i++) {
        selectHtml += '<li id="selectHost_0" nvalue="' + internalhostVal[i] + '" onclick="changeDropdownInfo(this);selectHostenvent(this)" title="' + internalhostVal[i] + '">'+ internalhostVal[i] + '</li>'
    }
    $("#selectHost_hide").append(selectHtml);
    setValueById("selectHost_show", internalhostVal[0]);
    setValueById("internalhostinput", internalhostVal[0]);
    $("#selectHost_show").html(restrictingLength(internalhostVal[0],20));
}

function selectHostenvent(val) {
    setValueById("internalhostinput", val.innerText);
}

function EnableIpv6PortMappingItem(obj) {
    var EnabledVal = getValueById(obj.id);
    var lineId = obj.id.split("_")[1];
    
    for (var i = 0; i < curPortMappingList.length; i++) {
        if (lineId == curPortMappingList[i].LineID) {
            curPortMappingList[i].Enabled = EnabledVal;
            if (curPortMappingList[i].EditFlag == "") {
                curPortMappingList[i].EditFlag = "SET";
            }
        }
    }
}

function portToggleRange(id, value) {
    setRadioValue(id, value)
    if (value == 1) {
        displayRowById("publicPortRange", 1);
        displayRowById("publicPort", 0);
    } else {
        displayRowById("publicPortRange", 0);
        displayRowById("publicPort", 1);
    }
}

function CheckPortMappingCfg(curStPMInst) {
    if (firstInterWanDomain == null) {
         alertVDF(ipv6portmapping_language['bbsp_creatwan']);
         return false;
    }

    if (true != portListInstIpChk(curStPMInst)) {
        return false;
    }

    if (true != portValueValidChk(curStPMInst)){
        return false;
    }

    return true;
}

function portListInstIpChk(curStPMInst) {
    var innerHostIp = curStPMInst.InClient;
    var externalHostIp = curStPMInst.RemoteHost;
    
    if (innerHostIp == "") {
        alertVDF(ipv6portmapping_language['bbsp_hostipinvalid1']);
        return false;
    }

    if ((innerHostIp != "") && (CheckIpv6Parameter(innerHostIp) == false)) {
        alertVDF(ipv6portmapping_language['bbsp_hostipinvalid1']);
        return false;
    }

    if ((externalHostIp != "") && (CheckIpv6Parameter(externalHostIp) == false)) {
        alertVDF(ipv6portmapping_language['bbsp_extsrcipinvalid']);
        return false;
    }

    return true;
}

function portValueValidChk(curStPMInst) {
    var innerStartPort = curStPMInst.InternalPort;
    var innerEndPort = curStPMInst.InternalPortEnd;

    if (innerStartPort == innerEndPort) {
        if (innerStartPort == "") {
            alertVDF(ipv6portmapping_language['bbsp_startportisreq1']);
            return false;
        } else if ((innerStartPort.charAt(0) == "0") || (isValidPort(innerStartPort) == false)) {
            alertVDF(ipv6portmapping_language['bbsp_startport1'] +  innerStartPort + ipv6portmapping_language['bbsp_invalid']);
            return false;
        }
        return true;
    }

    if (innerStartPort == "") {
        alertVDF(ipv6portmapping_language['bbsp_startportisreq']);
        return false;
    } else if ((innerStartPort.charAt(0) == "0") || (isValidPort(innerStartPort) == false)) {
        alertVDF(ipv6portmapping_language['bbsp_startport'] +  innerStartPort + ipv6portmapping_language['bbsp_invalid']);
        return false;
    }

    if ((innerEndPort != "") && ((innerEndPort.charAt(0) == "0") || (isValidPort2(innerEndPort) == false))) {
        alertVDF(ipv6portmapping_language['bbsp_endport'] +  innerEndPort + ipv6portmapping_language['bbsp_invalid']);
        return false;
    }

    if ((innerStartPort != "") && (innerEndPort != "")
        && (parseInt(innerStartPort, 10) > parseInt(innerEndPort, 10))) {
        alertVDF(ipv6portmapping_language['bbsp_startportleqendport']);
        return false;
    }

    return true;
}

function loadframe() {
    initSelectIndex();
    displayRowById("selectMACaddress", 0);
    setDisplayTable("Ipv6PortMappingTable",1);
    initPortMappingData();
}
</script>
</head>
<body  id="wanbody" onload="loadframe();">
    <input type="hidden" id="onttoken" name="onttoken" value="<%HW_WEB_GetToken();%>">
<div id="content">
<script> 
CreatHeaderTitle(getLanguage("ipv6port000"), getLanguage("ipv6port001"));
var Ipv6PortMappingInfoControl = [[getLanguage("ipv6port002"), getLanguage("ipv6port003"), getLanguage("ipv6port004"), getLanguage("ipv6port005")]];

CreatComplexInfoTable("Port Mapping", "Ipv6PortMappingTable", Ipv6PortMappingInfoControl, "editPortMappingLine(this)", "DeleteIpv6PortMappingItem(this,event)", "EnableIpv6PortMappingItem(this)");
var selectDeviceInfo = ["selectDevice", "0", "Select..."];
for (var i = 0; i < ipv6UserDevList.length; i ++) {
    selectDeviceInfo.push(i+1);
    selectDeviceInfo.push(ipv6UserDevList[i].Device);
}
var selectHostInfo = ["selectHost"];
var selectPortolInfo = ["selectPortol", "TCP/UDP","TCP/UDP", "TCP", "TCP","UDP","UDP"]
var selectInternalHostInfo = ["selectInternalHost", "0", ""]
var typeModeArr = [ip6portMapping_language["ipv6port007"], ip6portMapping_language["ipv6port008"], ip6portMapping_language["ipv6port009"]]
var ipv6PortMappingPopupinfo = new Array( new tableArrayInfo("singleinput",getLanguage("ipv6port002"),"portMappingName", 256),
                                            new tableArrayInfo("select", getLanguage("ipv6port016"), selectDeviceInfo, "setIPv6SelectDevice()"),
                                            new tableArrayInfo("select", getLanguage("ipv6port004"), selectHostInfo, "selectHostenvent()"),
                                            new tableArrayInfo("singleinput", getLanguage("ipv6port004"), "internalhostinput", ""),
                                            new tableArrayInfo("mactable", "MAC Address", "selectMACaddress", ""),
                                            new tableArrayInfo("singleinput", getLanguage("ipv6port011"), "sourceIPAddress", null),
                                            new tableArrayInfo("select", getLanguage("ipv6port003"), selectPortolInfo, ""),
                                            new tableArrayInfo("radiobutton", typeModeArr, "typeMode", ""),
                                            new tableArrayInfo("singleinput", ip6portMapping_language["ipv6port013a"],"publicPort","","text"),
                                            new tableArrayInfo("iprangetable", ip6portMapping_language["ipv6port013"], "publicPortRange", null));
CreatPopupTable("Edit Port Mapping", "editPortMappingTable", ipv6PortMappingPopupinfo, "PortMappingApply()");
CreatApplyButton("PortMappingSubmit()");
</script>
<script>
$('input:radio[name="typeMode-to-show"]').click(function () {
    if (getRadioValue("typeMode") == 1) {
         displayRowById("publicPortRange", 1);
         displayRowById("publicPort", 0)
    } else {
         displayRowById("publicPortRange", 0);
         displayRowById("publicPort", 1)
    }
});
</script>
</div>
</div>
</body>
</html>
