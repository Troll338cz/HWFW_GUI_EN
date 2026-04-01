<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script>
var applyDomian = "";
var isEditflag = true;
var isIPPrefix = true;
var applyDataArray = [];
var initAddNum = 0;
function stFilterInIpv6(Domain, Priority, Protocol, Direction, SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd, Action, lanTcpPort, lanUdpPort, wanTcpPort, wanUdpPort, Name, SourceIPMask, DestIPMask) {
    this.Domain = Domain;
    this.Priority = Priority;
    this.Direction = Direction;
    this.Protocol = Protocol;
    this.SourceIPStart = SourceIPStart;
    this.SourceIPEnd = SourceIPEnd;
    this.DestIPStart = DestIPStart;    
    this.DestIPEnd = DestIPEnd;
    this.Action = Action;
    this.lanTcpPort = lanTcpPort;
    this.lanUdpPort = lanUdpPort;
    this.wanTcpPort = wanTcpPort;
    this.wanUdpPort = wanUdpPort;
    this.name = Name;
    this.SourceIPMask = SourceIPMask;
    this.DestIPMask = DestIPMask;
}
var FilterInIpv6 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SEC_FilterIn, InternetGatewayDevice.X_HW_Security.Ip6Filter.{i},Priority|Protocol|Direction|SourceIPStart|SourceIPEnd|DestIPStart|DestIPEnd|Action|LanSideTcpPort|LanSideUdpPort|WanSideTcpPort|WanSideUdpPort|Name|SourceIPMask|DestIPMask,stFilterInIpv6);%>;
function stPortFilter(domain, Ip6FilterRight, Ip6FilterPolicy, FirewallLevel) {
    this.domain = domain;
    this.Ip6FilterRight = Ip6FilterRight;
    this.Ip6FilterPolicy = Ip6FilterPolicy;
    this.FirewallLevel    = FirewallLevel;
}
var portFilters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security,Ip6FilterRight|Ip6FilterPolicy|X_HW_FirewallLevel,stPortFilter);%>;
var currentMode = portFilters[0].Ip6FilterPolicy;

function ModeChange() {
    var TCPFlag = false;
    var UDPFlag = false;
    var portolval = getSelectValue("selectPortol");

    if (portolval.toString().indexOf("TCP") > -1) {
        TCPFlag = true;
    }

    if (portolval.toString().indexOf("UDP") > -1) {
        UDPFlag = true;
    }

    displayRowById("lanTCPPort", TCPFlag)
    displayRowById("lanUDPPort", UDPFlag)
    displayRowById("wanTCPPort", TCPFlag)
    displayRowById("wanUDPPort", UDPFlag)
}

function GetLanguage(name) {
    return ipv6ipincoming_language[name];
}

function IsIPv6AddressValid(Address)
{
    if (Address == "::")
    {
        return true;
    }

    if (Address.length < 3)
    {
        return false;
    }

    var List = Address.split("::");
    if (List.length > 2)
    {
        return false;
    }
    
    if (List.length == 1)
    if (Address.split(":").length != 8)
    {
        return false;
    }
    
    if (List.length > 1)
    if (Address.split(":").length > 8)
    {
        return false;
    }

    List = Address.split("::");
    for (var i = 0; i < List.length; i++)
    {
        if (false == IsStandardIPv6AddressValid(List[i]))
        {
            return false;
        }
    }
    return true;
}

function IPModeChange() {
    if (getSelectValue("selectIpMode") == "IP Prefix") {
        displayRowById("lanStartIP", 0)
        displayRowById("lanEndIP", 0)
        displayRowById("wanStartIP", 0)
        displayRowById("wanEndIP", 0)
        displayRowById("lanSideIP", 1)
        displayRowById("wanSideIP", 1)
    } else {
        displayRowById("lanStartIP", 1)
        displayRowById("lanEndIP", 1)
        displayRowById("wanStartIP", 1)
        displayRowById("wanEndIP", 1)
        displayRowById("lanSideIP", 0)
        displayRowById("wanSideIP", 0)
    } 
}

function EditIpv6AddressItem(obj, event) {
    var objID = obj.parentNode.parentNode.id;
    applyDomian = objID;
    if ((objID != "") && (objID != "ipv6AddressFilteringTable_add")) {
        displayPopupTable("editAddressTable");
        isEditflag = true;
        document.getElementById("selectIpMode_show").classList.add("op40");
        document.getElementById("editAddressTable_title").innerHTML = GetLanguage("ipv6filter001");
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == objID) {
                if (applyDataArray[i][5] == "" && applyDataArray[i][6] == "" && applyDataArray[i][7] == "" && applyDataArray[i][8] == "") {
                    setSelectValue("selectIpMode", "IP Prefix") ;
                } else {
                    setSelectValue("selectIpMode", "IP Range") ;
                }
                IPModeChange();
                setValueById("ruleName", applyDataArray[i][2]);
                setSelectValue("selectPortol", applyDataArray[i][3]) ;
                ModeChange();
                setValueById("lanStartIP", applyDataArray[i][5]);
                setValueById("lanEndIP", applyDataArray[i][6]);
                setValueById("wanStartIP", applyDataArray[i][7]);
                setValueById("wanEndIP", applyDataArray[i][8]);
                setMultipleIPtableValue("lanSideIP", applyDataArray[i][9]);
                setMultipleIPtableValue("wanSideIP", applyDataArray[i][10]);
                setValueById("lanTCPPort", applyDataArray[i][11]);
                setValueById("lanUDPPort", applyDataArray[i][12]);
                setValueById("wanTCPPort", applyDataArray[i][13]);
                setValueById("wanUDPPort", applyDataArray[i][14]);
            }
        }
    } else {
        if(applyDataArray.length >= 32) {
            alertVDF(ipincoming_language["bbsp_ipfilterfull"]);
            return;
        }
        displayPopupTable("editAddressTable");
        isEditflag = false;
        document.getElementById("selectIpMode_show").classList.remove("op40");
        document.getElementById("editAddressTable_title").innerHTML = "Add IPv6 Address Filtering";
        setValueById("ruleName", "");
        setSelectValue("selectPortol", "ALL") ;
        ModeChange();
        IPModeChange();
        setValueById("lanStartIP", "");
        setValueById("lanEndIP", "");
        setValueById("wanStartIP", "");
        setValueById("wanEndIP", "");
        setMultipleIPtableValue("lanSideIP", "/");
        setMultipleIPtableValue("wanSideIP", "/");
        setValueById("lanTCPPort", "");
        setValueById("lanUDPPort", "");
        setValueById("wanTCPPort", "");
        setValueById("wanUDPPort", "");
    }
}
function DeleteIpv6AddressItem(obj, event) {
    var deleteInstId = obj.parentElement.parentElement.id;
    if (deleteInstId.split("_")[0] != "add") {
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == deleteInstId) {
                applyDataArray[i][0] = "delete"
            }
        }
    } else {
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == deleteInstId) {
                applyDataArray[i] = "";
            }
        } 
    }
    event.target.parentNode.parentNode.parentNode.removeChild(event.target.parentNode.parentNode);
}

var FirewallDual = <%HW_WEB_GetFeatureSupport("BBSP_FT_FIREWALL_DUAL");%>;
var IPv6Firewall = <%HW_WEB_GetFeatureSupport("BBSP_FT_CONFIG_IPV6_SESSION");%>;
var IPv6FirewallEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_IPv6FWDFireWallEnable);%>';
function IpFilterPortInputChk(portInfo) {
    var portList = portInfo.split(',');
    var numbersMatch = new RegExp("^[1-9][0-9]*$");
    var result;
    for (var i = 0; i < portList.length; i++) {
        if (portList[i].indexOf(":") > 0) {
            var list2 = portList[i].split(':'); 
            if (list2.length != 2) {
                return false;
            }
            for (var j = 0; j < 2;j++) {
                result = numbersMatch.exec(list2[j]);
                if (result == null) {
                    return false;
                }
            }
            if (parseInt(list2[0],10) > parseInt(list2[1],10)) {
                return false;
            }
        } else {
            result = numbersMatch.exec(portList[i]);
            if (result == null) {
                return false;
            }
        }
    }
    return true;
}
function IpFilterGetPortSum(portInfo) {
    var portList1 = portInfo.split(',');
    var portList2 = portInfo.split(':');
    var sum = (portList1.length - 1) + (portList2.length - 1) + 1;
    return sum;
}
function MakePortInfoPairs(s, e) {
    this.start = s;
    this.end = e;
}
function IpFilterParsePortInfo(portInfo) {
    var portInfoList = new Array(0);
    var portList1;
    var portList2;
    if (portInfo == '') {
        var portPairs = new MakePortInfoPairs("","");
        portInfoList.push(portPairs);
        return portInfoList;
    }
    portList1 = portInfo.split(',');
    for (var i = 0; i < portList1.length; i++) {
        var portPairs;       
        var portList2 = portList1[i].split(':');
        if (portList2.length > 1) {
            portPairs = new MakePortInfoPairs(portList2[0],portList2[1]);
        } else {
            portPairs = new MakePortInfoPairs(portList1[i],portList1[i]);
        }
        portInfoList.push(portPairs)
    }
    return portInfoList;
}
function PortValidChk(portIn, descp) {
    var portList;
    if (portIn == '') {
        return true;
    }
    if (!IpFilterPortInputChk(portIn)) {
        alertVDF(GetLanguage("ipv6filter002") + "("+portIn+")");
        return false;
    }
    if (IpFilterGetPortSum(portIn) > 15) {
        alertVDF(GetLanguage("ipv6filter003"));
        return false;
    }
    portList = IpFilterParsePortInfo(portIn);
    for (var i = 0; i < portList.length; i++) {
        var portInt = portList[i].start;
        if (!isValidPort(portInt)) {
            alertVDF(GetLanguage("ipv6filter004") +"("+ portInt+ ")");
            return false;
        }
        portInt = portList[i].end;
        if (!isValidPort(portInt)) {
            alertVDF(GetLanguage("ipv6filter004") +"("+ portInt+ ")");
            return false;
        }
    }
    var errorPort;
    var repeateFound = false;
    for (var i = 0; i < portList.length; i++) {
        var portStart = parseInt(portList[i].start,10);
        var portEnd = parseInt(portList[i].end,10);
        for (var j = 0; j < portList.length; j++) {
            if (i === j){
                continue;
            }
            if ((portStart >= parseInt(portList[j].start,10)) && (portStart <= parseInt(portList[j].end,10))) {
                errorPort = portStart;
                repeateFound = true;
                break;
            }
            if ((portEnd >= parseInt(portList[j].end,10)) && (portEnd <= parseInt(portList[j].end,10))) {
                errorPort = portEnd;
                repeateFound = true;
                break;
            }
            if ((portStart < parseInt(portList[j].start,10)) && (portEnd > parseInt(portList[j].end,10))) {
                errorPort = portList[j].start;
                repeateFound = true;
                break;
            }
        }
        if (repeateFound) {
            alertVDF(descp  +" \"" + errorPort + '" repeated.');
            return false;
        }
    }
    return true;
}
function IpFilterPortValidChk() {
    var lanTcpPort = getValueById("lanTCPPort");
    var wanTcpPort = getValueById("wanTCPPort");
    var lanUdpPort = getValueById("lanUDPPort");
    var wanUdpPort = getValueById("wanUDPPort");
    if (!PortValidChk(lanTcpPort,'LAN Side TCP port')) {
        return false;
    }
    if (!PortValidChk(wanTcpPort,'WAN Side TCP port')) {
        return false;
    }

    if (!PortValidChk(lanUdpPort,'LAN Side UDP port')) {
        return false;
    }
    if (!PortValidChk(wanUdpPort,'WAN Side UDP port')) {
        return false;
    }
    return true;
}
function IpFilterRepeateCfgChk() {
    var sourceIPStart = getValueById("lanStartIP");
    var sourceIPEnd = getValueById("lanEndIP");
    var destIPStart = getValueById("wanStartIP");
    var destIPEnd = getValueById("wanEndIP");
	var protocolVal = getSelectValue("selectPortol")
    var lanTcpPort = getValueById("lanTCPPort");
    var wanTcpPort = getValueById("wanTCPPort");
    var lanUdpPort = getValueById("lanUDPPort");
    var wanUdpPort = getValueById("wanUDPPort");
    
	for (var i = 0; i < truncate(FilterInIpv6).length; i++) {		
	    if ((truncate(FilterInIpv6)[i].SourceIPStart == sourceIPStart) && (truncate(FilterInIpv6)[i].SourceIPEnd == sourceIPEnd) && (truncate(FilterInIpv6)[i].DestIPStart == destIPStart) && (truncate(FilterInIpv6)[i].DestIPEnd == destIPEnd)
			&& (truncate(FilterInIpv6)[i].Protocol == protocolVal) && (truncate(FilterInIpv6)[i].lanTcpPort == lanTcpPort) && (truncate(FilterInIpv6)[i].lanUdpPort == lanUdpPort)
			&& (truncate(FilterInIpv6)[i].wanTcpPort == wanTcpPort)&& (truncate(FilterInIpv6)[i].wanUdpPort == wanUdpPort)) {
            alertVDF(GetLanguage("ipv6filter005"));		    
			return false;		    
    	}
	} 
	return true;   
}
function IpFilterDescpChk() {
    var descrip = getValueById("ruleName");
	if (descrip == "") {
	    alertVDF(GetLanguage("ipv6filter006"));
        return false;
    }
    if (!isValidName(descrip)) {
        alertVDF(GetLanguage("ipv6filter007"));
        return false;
    }

    for(var i = 0; i < truncate(FilterInIpv6).length - 1; i++) {
        if((!isEditflag) && (truncate(FilterInIpv6)[i].name  == descrip)) {
            alertVDF(GetLanguage("ipv6filter008"));
            return false;
        }
    }
    return true;
}

function CheckForm() {
    if ((FirewallDual == 0) && (IPv6Firewall == 1) && (IPv6FirewallEnable == 0)) {
        alertVDF(GetLanguage("ipv6filter009"));
    }
    var SourceIPStart = getValueById("lanStartIP");
    var SourceIPEnd = getValueById("lanEndIP");
    var DestIPStart = getValueById("wanStartIP");
    var DestIPEnd = getValueById("wanEndIP");
    if(!IpFilterDescpChk()) {
        return false;
    }
    if (getSelectValue("selectIpMode") == "IP Range") {
        if ((SourceIPStart != "") && (!CheckIpv6Parameter(SourceIPStart))) {
            alertVDF(GetLanguage("ipv6filter010") + SourceIPStart + GetLanguage("ipv6filter011"));
            return false;
        }
        if ((SourceIPEnd != "") && (!CheckIpv6Parameter(SourceIPEnd))) {
            alertVDF(GetLanguage("ipv6filter012") + SourceIPEnd + GetLanguage("ipv6filter011"));
            return false;
        }
        if ((SourceIPEnd != "") && (isStartIpbigerEndIp(SourceIPStart,SourceIPEnd))) {
            alertVDF(GetLanguage("ipv6filter013"));
            return false;
        }
        if ((SourceIPStart == "") && SourceIPEnd != "" ) {
            alertVDF(GetLanguage("ipv6filter014"));
            return false;
        }
        if ((DestIPStart != "")  && (!CheckIpv6Parameter(DestIPStart))) {
            alertVDF(GetLanguage("ipv6filter015") + DestIPStart + GetLanguage("ipv6filter011"));
            return false;
        }
        if ((DestIPEnd != "") && (!CheckIpv6Parameter(DestIPEnd))) {
            alertVDF(GetLanguage("ipv6filter016") + DestIPEnd + GetLanguage("ipv6filter011"));
            return false;
        }
        if ((DestIPEnd != "") && (isStartIpbigerEndIp(DestIPStart,DestIPEnd))) {
            alertVDF(GetLanguage("ipv6filter017"));
            return false;     	
        }
        if ((DestIPStart == "") && (DestIPEnd != "")) {
            alertVDF(GetLanguage("bbsp_wanstartaddrisreq"));
            return false;
        }
    }
	var deflansideip1value = getValueById("lanSideIP1");
	var defwansideip1value = getValueById("wanSideIP1");
	var deflansideip2value = getValueById("lanSideIP2");
	var defwansideip2value = getValueById("wanSideIP2");
	if (getSelectValue("selectIpMode") == "IP Prefix") {
		if(deflansideip1value != "" || defwansideip1value != "" || deflansideip2value != "" || defwansideip2value != "") {
			if (deflansideip1value != "" || deflansideip2value != "") {
				if ((!IsIPv6AddressValid(deflansideip1value)) || deflansideip2value == "" || (parseInt(deflansideip2value)) < 0 || (parseInt(deflansideip2value)) > 128) {
					alertVDF(GetLanguage("bbsp_lanprefix"));
					return false;
				}
			}
			if (defwansideip1value != "" || defwansideip2value != "") {
				if ((!IsIPv6AddressValid(defwansideip1value)) || defwansideip2value == "" || (parseInt(defwansideip2value)) < 0 || (parseInt(defwansideip2value)) > 128) {
					alertVDF(GetLanguage("bbsp_wanprefix"));
					return false;
				}
			}
		}
	}
    if(!IpFilterPortValidChk()) {
        return false;
    }

   	return true;
}
function GetAjaxRet(Result) {
    var i = 0;
    var error_index = 'bbsp_paraerror';
    var errorCodeArray = new Array('0xf730708c', '0xf730708d');
    var errorstring = new Array(GetLanguage("bbsp_lanprefix"), GetLanguage("bbsp_wanprefix"));
    if(Result == '{ "result": 0 }') {
        cancelPopupTable("editAddressTable");
        window.location.href = "/html/bbsp/ipv6ipincoming/ipv6filterptvdf.asp";
        return true;
    } else {
        for(i = 0; ; i++) {
            if (Result.split(":")[i].toString().indexOf("error") >= 0 ) {
                break;
            }
        }
        var sub = Result.split(":")[i + 1];		
        var errorcode = sub.substring(2, 12);
        for(i = 0; i < errorCodeArray.length; i++) {
            if (errorCodeArray[i] == errorcode) {
                error_index = errorstring[i];
                break;
            }
        }
        alertVDF(error_index);
    }
}

function ipv6AddressApply() {
    if(!CheckForm()) {
        return false;
    }
    var onceSaveData = [];
    if (isEditflag) {
        var htmlinfo = "";
        htmlinfo += '<div class="table-col padding20" title=" ' + escapeHTML(getValueById("ruleName")) + ' ">' + escapeHTML(restrictingLength(getValueById("ruleName"),20)) + '</div>'
        htmlinfo += '<div class="table-col padding20" title=" '+ getSelectValue("selectPortol") + '">'+ getSelectValue("selectPortol") + '</div>'
        htmlinfo += '<div class="table-col padding20" title="Bidirectional">Bidirectional</div>'
        if (getSelectValue("selectIpMode") == "IP Range") {
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("lanStartIP")  + "-" + getValueById("lanEndIP") + ' "> ' + getValueById("lanStartIP")  + "-" + ' </br> ' + getValueById("lanEndIP") + ' </div>'
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("wanStartIP")  + "-" + getValueById("wanEndIP") + ' "> ' + getValueById("wanStartIP")  + "-" + ' </br> ' + getValueById("wanEndIP") + ' </div>'
            isIPPrefix = false;
        } else {
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("lanSideIP1")  + "/" + getValueById("lanSideIP2") + ' "> ' + getValueById("lanSideIP1")  + "/" + getValueById("lanSideIP2") + ' </div>'
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("wanSideIP1")  + "/" + getValueById("wanSideIP2") + ' "> ' + getValueById("wanSideIP1")  + "/" + getValueById("wanSideIP2") + ' </div>'
            isIPPrefix = true;
        }
        htmlinfo += '<div class="table-col padding20">'
            htmlinfo += '<input class="button button-edit" type="button" onclick="EditIpv6AddressItem(this,event)">'
        htmlinfo += '</div>'
        htmlinfo += '<div class="table-col padding20">'
            htmlinfo += '<input class="button button-delete" type="button" onclick="DeleteIpv6AddressItem(this,event)">'
        htmlinfo += '</div>'
        document.getElementById(applyDomian).innerHTML = htmlinfo;
        onceSaveData.push("edit",applyDomian,getValueById("ruleName"),getSelectValue("selectPortol"),"Bidirectional",getValueById("lanStartIP"),getValueById("lanEndIP"),getValueById("wanStartIP"),getValueById("wanEndIP"),
        getValueById("lanSideIP1")+ "/" +getValueById("lanSideIP2"),getValueById("wanSideIP1") + "/" + getValueById("wanSideIP2"),getValueById("lanTCPPort"),getValueById("lanUDPPort"),getValueById("wanTCPPort"),getValueById("wanUDPPort"))
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == applyDomian) {
                applyDataArray[i] = onceSaveData
            }
        }
    } else {
        initAddNum ++;
        var htmlinfo = "";
        htmlinfo += '<div class="table-row" id="add_' + initAddNum + '">'
        htmlinfo += '<div class="table-col padding20" title=" ' + escapeHTML(getValueById("ruleName")) + ' ">' + escapeHTML(restrictingLength(getValueById("ruleName"),20)) + '</div>'
        htmlinfo += '<div class="table-col padding20" title=" '+ getSelectValue("selectPortol") + '">'+ getSelectValue("selectPortol") + '</div>'
        htmlinfo += '<div class="table-col padding20" title="Bidirectional">Bidirectional</div>'
        if (getSelectValue("selectIpMode") == "IP Range") {
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("lanStartIP")  + "-" + getValueById("lanEndIP") + ' "> ' + getValueById("lanStartIP")  + "-" + ' </br> ' + getValueById("lanEndIP") + ' </div>'
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("wanStartIP")  + "-" + getValueById("wanEndIP") + ' "> ' + getValueById("wanStartIP")  + "-" + ' </br> ' + getValueById("wanEndIP") + ' </div>'
            isIPPrefix = false;
        } else {
            isIPPrefix = true;
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("lanSideIP1")  + "/" + getValueById("lanSideIP2") + ' "> ' + getValueById("lanSideIP1")  + "/" + getValueById("lanSideIP2") + ' </div>'
            htmlinfo += '<div class="table-col padding20" title=" ' + getValueById("wanSideIP1")  + "/" + getValueById("wanSideIP2") + ' "> ' + getValueById("wanSideIP1")  + "/" + getValueById("wanSideIP2") + ' </div>'
        }
        htmlinfo += '<div class="table-col padding20">'
            htmlinfo += '<input class="button button-edit" type="button" onclick="EditIpv6AddressItem(this,event)">'
        htmlinfo += '</div>'
        htmlinfo += '<div class="table-col padding20">'
            htmlinfo += '<input class="button button-delete" type="button" onclick="DeleteIpv6AddressItem(this,event)">'
        htmlinfo += '</div>'
        htmlinfo += '</div>'
        $("#ipv6AddressFilteringTable_add").before(htmlinfo);
        onceSaveData.push("add","add_"+initAddNum,getValueById("ruleName"),getSelectValue("selectPortol"),"Bidirectional",getValueById("lanStartIP"),getValueById("lanEndIP"),getValueById("wanStartIP"),getValueById("wanEndIP"),
        getValueById("lanSideIP1") + "/" +getValueById("lanSideIP2"),getValueById("wanSideIP1") + "/" + getValueById("wanSideIP2"),getValueById("lanTCPPort"),getValueById("lanUDPPort"),getValueById("wanTCPPort"),getValueById("wanUDPPort"))
        applyDataArray.push(onceSaveData)
    }
    cancelPopupTable("editAddressTable");
}
function HWGetToken()
{
    var tokenstring="";
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/ssmp/common/GetRandToken.asp",
        success : function(data) {
            tokenstring = data;
        }
    });
    return tokenstring;
}
function SubmitAction() {
    setDisable("applybtn",1);
    if (getValueById("ipv6AddressEnable") == 0) {
        Ipv6FilterEnable();
    } else {
        Ipv6FilterEnable();
        applyDataArray.forEach((item, index) => {
        if (!item) {
            applyDataArray.splice(index, 1);
            }
        })
        for (var i = 0; i < applyDataArray.length; i++) {
            var Result = null;
            var SubmitData = "";
            var SubmitData = 'x.Protocol=' + applyDataArray[i][3];
                SubmitData += "&x.Name=" + applyDataArray[i][2];
            if (applyDataArray[i][3] != 'ALL' && applyDataArray[i][3] != 'ICMPv6') {
                SubmitData += "&x.LanSideTcpPort=" + applyDataArray[i][11];
                SubmitData += "&x.LanSideUdpPort=" + applyDataArray[i][12];
                SubmitData += "&x.WanSideTcpPort=" + applyDataArray[i][13];
                SubmitData += "&x.WanSideUdpPort=" + applyDataArray[i][14];		
            } else {
                SubmitData += "&x.LanSideTcpPort=" + "";
                SubmitData += "&x.LanSideUdpPort=" + "";
                SubmitData += "&x.WanSideTcpPort=" + "";
                SubmitData += "&x.WanSideUdpPort=" + "";
            }

            if(applyDataArray[i][9] == '' || applyDataArray[i][9] == "/") {
                SubmitData += "&x.SourceIPMask=" + "";	
            } else {
                SubmitData += "&x.SourceIPMask=" + applyDataArray[i][9];
            }

            if(applyDataArray[i][10] == '' || applyDataArray[i][10] == "/") {
                SubmitData += "&x.DestIPMask=" + "";	
            } else {
                SubmitData += "&x.DestIPMask=" + applyDataArray[i][10];
            }
            SubmitData += "&x.SourceIPStart=" + applyDataArray[i][5];
            SubmitData += "&x.SourceIPEnd=" + applyDataArray[i][6];
            SubmitData += "&x.DestIPStart=" + applyDataArray[i][7];
            SubmitData += "&x.DestIPEnd=" + applyDataArray[i][8];
            
            if (applyDataArray[i][0] == "edit") {  
                $.ajax({
                    type: "POST",
                    async: false,
                    cache: false,
                    data: SubmitData + "&x.X_HW_Token=" + HWGetToken(),
                    url: 'setajax.cgi?x=' + applyDataArray[i][1] + '&RequestFile=html/bbsp/ipv6ipincoming/ipv6filterptvdf.asp',
                    success : function(data) {
                    Result = hexDecode(data);
                    GetAjaxRet(Result);	
                }});   
            } else if (applyDataArray[i][0] == "delete") {
                $.ajax({
                    type: "POST",
                    async: false,
                    cache: false,
                    data : applyDataArray[i][1] + "=" + "&x.X_HW_Token=" + HWGetToken(),
                    url: 'del.cgi?x=' + applyDataArray[i][1] + '&RequestFile=html/bbsp/ipv6ipincoming/ipv6filterptvdf.asp',
                    success: function() {}
                });  
            } else if (applyDataArray[i][0] == "add") {
                $.ajax({
                    type: "POST",
                    async: false,
                    cache: false,
                    data: SubmitData + "&x.X_HW_Token=" + HWGetToken(),
                    url: 'addajax.cgi?x=InternetGatewayDevice.X_HW_Security.Ip6Filter' + '&RequestFile=html/bbsp/ipv6ipincoming/ipv6filterptvdf.asp',
                    success : function(data) {	 
                    Result = hexDecode(data);	
                    GetAjaxRet(Result);
                }});   
            }
        }
    }
    location.reload();
}

function Ipv6FilterEnable() { 
    if (getValueById("ipv6AddressEnable") == 0) {
        setDisplayTable("ipv6AddressFilteringTable",0);
        setDisplayTable("ipv6FilterModeTable",0);
    } else {
        setDisplayTable("ipv6AddressFilteringTable",1);
        setDisplayTable("ipv6FilterModeTable",1);       
    }
    var SubmitData = "";
    SubmitData += 'x.Ip6FilterRight=' + getValueById("ipv6AddressEnable");
    $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: SubmitData + "&x.X_HW_Token=" + document.getElementById('onttoken').value,
        url: 'set.cgi?x=InternetGatewayDevice.X_HW_Security' + '&RequestFile=html/bbsp/ipv6ipincoming/ipv6filterptvdf.asp',
        success: function() {}
    });  
}

function confirmBWMacList() {
    var curMode = getSelectValue("ipv6FilterMode");
    if (curMode == currentMode) {
        return;
    }
    var curConfirmTips = ipv6ipincoming_language["bbsp_changemodenote1"];
    if (curMode == "1") {
        curConfirmTips = ipv6ipincoming_language["bbsp_changemodenote2"]
    }
    confirmVDF(curConfirmTips, "changeBWListMode()", 'rebackBWListMode()');
}

function changeBWListMode() {
    var setForm = new webSubmitForm();
    setForm.addParameter("x.Ip6FilterPolicy", getSelectValue("ipv6FilterMode"));
    setForm.addParameter("x.X_HW_Token", getValue('onttoken'));
    setForm.setAction("set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/ipv6ipincoming/ipv6filterptvdf.asp");
    setForm.submit();
}

function rebackBWListMode() {
    var curMode = getSelectValue("ipv6FilterMode");
    setSelectValue("ipv6FilterMode", 1 - curMode);
}

function initData() {
    if (truncate(FilterInIpv6) && truncate(FilterInIpv6).length > 0) {
        for (var i = 0; i < truncate(FilterInIpv6).length; i++) {
            var initArr = [];
            initArr.push("edit", truncate(FilterInIpv6)[i].Domain,truncate(FilterInIpv6)[i].name,truncate(FilterInIpv6)[i].Protocol,"Bidirectional",truncate(FilterInIpv6)[i].SourceIPStart,truncate(FilterInIpv6)[i].SourceIPEnd,truncate(FilterInIpv6)[i].DestIPStart,truncate(FilterInIpv6)[i].DestIPEnd,
            truncate(FilterInIpv6)[i].SourceIPMask,truncate(FilterInIpv6)[i].DestIPMask,truncate(FilterInIpv6)[i].lanTcpPort,truncate(FilterInIpv6)[i].lanUdpPort,truncate(FilterInIpv6)[i].wanTcpPort,truncate(FilterInIpv6)[i].wanUdpPort)
            applyDataArray.push(initArr)
        }
    }
}

function loadframe() {
    initData();
    initSelectIndex();
    setSwitchButton ("ipv6AddressEnable",portFilters[0].Ip6FilterRight);
    if (portFilters[0].Ip6FilterRight == 0) {
        setDisplayTable("ipv6AddressFilteringTable",0);
        setDisplayTable("ipv6FilterModeTable",0);
    } else {
        setDisplayTable("ipv6AddressFilteringTable",1);
        setDisplayTable("ipv6FilterModeTable",1);
    }
    setSelectValue("ipv6FilterMode", portFilters[0].Ip6FilterPolicy) ;
}
</script>
</head>
<body  id="wanbody" onload="loadframe();">
    <input type="hidden" id="onttoken"   name="onttoken"     value="<%HW_WEB_GetToken();%>">
<div id="content">
<script> 
    CreatHeaderTitle(GetLanguage("ipv6filter026"), "");
    var ipv6FilterModeSelect = ["ipv6FilterMode", "0", "Black List", "1", "White List"]
    var ipv6AddressTableinfo = new Array(new tableArrayInfo("switchbutton", GetLanguage("ipv6filter020"), "ipv6AddressEnable", "Ipv6FilterEnable()"));
    var ipv6FilterModeTableinfo = new Array(new tableArrayInfo("select", GetLanguage("bbsp_filtermodemh"), ipv6FilterModeSelect,"confirmBWMacList()"));
    CreatSetInfoTable("", "ipv6AddressTableinfo", ipv6AddressTableinfo);
    CreatSetInfoTable("", "ipv6FilterModeTable", ipv6FilterModeTableinfo);
    var ipv6AddressInfoControl = [[GetLanguage("tip_rule_name2"), GetLanguage("bbsp_protocolmh"), GetLanguage("bbsp_direction"), GetLanguage("ipv6filter018"),GetLanguage("ipv6filter019")]];
    for (var i = 0; i < truncate(FilterInIpv6).length; i++) {
        ipv6AddressInfoControl[i+1] =[];
        ipv6AddressInfoControl[i+1][0] = truncate(FilterInIpv6)[i].Domain;
        ipv6AddressInfoControl[i+1][1] = restrictingLength(truncate(FilterInIpv6)[i].name, 10);
        ipv6AddressInfoControl[i+1][2] = truncate(FilterInIpv6)[i].Protocol;
        ipv6AddressInfoControl[i+1][3] = truncate(FilterInIpv6)[i].Direction;
        if (truncate(FilterInIpv6)[i].SourceIPMask == "" && truncate(FilterInIpv6)[i].DestIPMask == "") {
            ipv6AddressInfoControl[i+1][4] = restrictingLength(truncate(FilterInIpv6)[i].SourceIPStart, 20) + "-" + "</br>" + restrictingLength(truncate(FilterInIpv6)[i].SourceIPEnd, 20);
            ipv6AddressInfoControl[i+1][5] = restrictingLength(truncate(FilterInIpv6)[i].DestIPStart, 20) + "-" + "</br>" + restrictingLength(truncate(FilterInIpv6)[i].DestIPEnd, 20);
        } else {
            ipv6AddressInfoControl[i+1][4] = truncate(FilterInIpv6)[i].SourceIPMask;
            ipv6AddressInfoControl[i+1][5] = truncate(FilterInIpv6)[i].DestIPMask;
        }
    }
    CreatComplexInfoTable(GetLanguage("ipv6filter020"), "ipv6AddressFilteringTable", ipv6AddressInfoControl, "EditIpv6AddressItem(this,event)", "DeleteIpv6AddressItem(this,event)", "");

    var  selectDirectionInfo = ["selectDirection", "Bidirectional", "Bidirectional"]
    var  selectPortolInfo = ["selectPortol", "ALL", "ALL","TCP/UDP","TCP/UDP", "TCP", "TCP","UDP","UDP","ICMPv6", "ICMPv6"]
    var  selectIPModeInfo = ["selectIpMode", "IP Prefix", "IP Prefix","IP Range","IP Range"]
    var  ipv6AddressPopupinfo = new Array( new tableArrayInfo("singleinput",GetLanguage("tip_rule_name2"),"ruleName",32),
                                           new tableArrayInfo("select", GetLanguage("bbsp_protocol"), selectPortolInfo, "ModeChange()"),
                                           new tableArrayInfo("select", GetLanguage("bbsp_direction"), selectDirectionInfo, ""),
                                           new tableArrayInfo("select", GetLanguage("bbsp_ipmode"), selectIPModeInfo, "IPModeChange()"),
                                           new tableArrayInfo("singleinput", GetLanguage("ipv6filter021"), "lanStartIP", null),
                                           new tableArrayInfo("singleinput", GetLanguage("ipv6filter022"), "lanEndIP", null),
                                           new tableArrayInfo("singleinput", GetLanguage("ipv6filter023"), "wanStartIP", null),
                                           new tableArrayInfo("singleinput", GetLanguage("ipv6filter024"), "wanEndIP", null),
                                           new tableArrayInfo("multipleiptable", GetLanguage("ipv6filter018"), "lanSideIP", null),
                                           new tableArrayInfo("multipleiptable", GetLanguage("ipv6filter019"), "wanSideIP", null),
                                           new tableArrayInfo("singleinput","LAN Side TCP Port","lanTCPPort","","text"),
                                           new tableArrayInfo("singleinput","LAN Side UDP Port","lanUDPPort","","text"),
                                           new tableArrayInfo("singleinput","WAN Side TCP Port","wanTCPPort","","text"),
                                           new tableArrayInfo("singleinput","WAN Side UDP Port","wanUDPPort","","text"));
    CreatPopupTable(GetLanguage("ipv6filter001"), "editAddressTable", ipv6AddressPopupinfo, "ipv6AddressApply()")
    CreatApplyButton("SubmitAction()");
	
	function checkInputNumber(obj) {
		obj.value = obj.value.replace(/[^\d]/g, '');
	    if(obj.value.length > 3){
	       obj.value = obj.value.slice(0, 3);
	    }
    }
	document.getElementById("lanSideIP2").setAttribute("oninput", "checkInputNumber(this)");
	document.getElementById("wanSideIP2").setAttribute("oninput", "checkInputNumber(this)");
</script>
</div>
</div>
</body>
</html>
