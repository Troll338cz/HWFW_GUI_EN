<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style>
.SelectDdns{
    width: 103px;
}
.InputRuleName{
    width: 96px;
}
.SelectApp{
    width: 127px;
}
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" type="text/javascript">
var appName = navigator.appName;
var TableName = "ipfilter";
var isSpecialFlag = '<%HW_WEB_GetFeatureSupport(FT_SONET_WEB_PWD_LENGTH);%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
function ipFilterAppTempPortAdd(proto_name)
{   
    var start_tcp_port = "";
    var end_tcp_port = "";
    var start_udp_port = "";
    var end_udp_port = "";
    
    this.name = proto_name;

    this.portinfo = function(s, e) {
        this.start = s;
        this.end = e;
    };
    
    var myport = new Object;

    if (arguments.length > 2) {
        start_tcp_port = arguments[1];
        end_tcp_port = arguments[2];
    }

    if (arguments.length > 4) {
        start_udp_port = arguments[3];
        end_udp_port = arguments[4];
    }
    myport.tcpPort = new this.portinfo(start_tcp_port,end_tcp_port);
    myport.udpPort = new this.portinfo(start_udp_port,end_udp_port);
    this.port = myport;
}

function IpFilterAppTempAdd()
{    
    var appTemps = new Array();
    nullTemps = new ipFilterAppTempPortAdd("NULL");
    this.appTemps = appTemps;
    
    appTemps.push(new ipFilterAppTempPortAdd("AIM Talk", "5190", "5190"));
    appTemps.push(new ipFilterAppTempPortAdd("Apple Remote desktop", "3283", "3283"));
    appTemps.push(new ipFilterAppTempPortAdd("XP Remote desktop", "3389", "3389"));
    appTemps.push(new ipFilterAppTempPortAdd("BearShare", "6346", "6346"));
    appTemps.push(new ipFilterAppTempPortAdd("BitTorrent", "6881:6900", "6881:6900", "6881:6900", "6881:6900"));
    appTemps.push(new ipFilterAppTempPortAdd("IP Camera 1", "80", "8120"));
    appTemps.push(new ipFilterAppTempPortAdd("IP Camera 2", "80", "8121"));
    appTemps.push(new ipFilterAppTempPortAdd("IP Camera 3", "80", "8122"));
    appTemps.push(new ipFilterAppTempPortAdd("IP Camera 4", "80", "8123"));
    appTemps.push(new ipFilterAppTempPortAdd("Checkpoint FW1 VPN", "259", "259", "259", "259"));
    appTemps.push(new ipFilterAppTempPortAdd("DirectX", "2300:2400,47624", "2300:2400,47624", "2302:2400,6073,47624","2302:2400,6073,47624"));
    appTemps.push(new ipFilterAppTempPortAdd("eMule", "4662,4711,64583", "4662,4711,64583", "4672,27673","4672,27673"));
    appTemps.push(new ipFilterAppTempPortAdd("Remote desktop", "3389", "3389"));
    appTemps.push(new ipFilterAppTempPortAdd("Gnutella", "6346:6347", "6346:6347","6346:6347", "6346:6347"));
    appTemps.push(new ipFilterAppTempPortAdd("ICQ", "5190", "5190"));
    appTemps.push(new ipFilterAppTempPortAdd("iMesh", "1214", "1214"));
    appTemps.push(new ipFilterAppTempPortAdd("IRC", "194,5100,6665:6669", "194,5100,6665:6669"));
    appTemps.push(new ipFilterAppTempPortAdd("iTunes", "3689", "3689","3689", "3689"));
    appTemps.push(new ipFilterAppTempPortAdd("KaZaa", "1214", "1214"));
    appTemps.push(new ipFilterAppTempPortAdd("Napster", "6699", "6699","6699", "6699"));
    appTemps.push(new ipFilterAppTempPortAdd("Netmeeting", "389,522,1023,1502:1504,1720:1732,65534", "389,522,1023,1502:1504,1720:1732,65534","1024:65535", "1024:65535"));
    appTemps.push(new ipFilterAppTempPortAdd("OpenVPN", "1194", "1194","1194", "1194"));
    appTemps.push(new ipFilterAppTempPortAdd("pcAnywhere", "5631:5632", "5631:5632","5631:5632", "5631:5632"));
    appTemps.push(new ipFilterAppTempPortAdd("PlayStation", "80,443,5223,10070:10080", "80,443,5223,10070:10080","3478:3479,3658,10070:10080", "3478:3479,3658,10070:10080"));
    appTemps.push(new ipFilterAppTempPortAdd("PPTP", "1723", "1723"));
    appTemps.push(new ipFilterAppTempPortAdd("FTP", "21", "21"));
    appTemps.push(new ipFilterAppTempPortAdd("DHCPv6", "547", "547","547", "547"));
    appTemps.push(new ipFilterAppTempPortAdd("DNS", "53", "53","53", "53"));
    appTemps.push(new ipFilterAppTempPortAdd("HTTPS", "443", "443"));
    appTemps.push(new ipFilterAppTempPortAdd("IMAP", "143,220,585,993", "143,220,585,993"));
    appTemps.push(new ipFilterAppTempPortAdd("Lotus Notes", "1352", "1352"));
    appTemps.push(new ipFilterAppTempPortAdd("MAMP", "8888:8889", "8888:8889"));
    appTemps.push(new ipFilterAppTempPortAdd("MySQL", "3306", "3306","3306", "3306"));
    appTemps.push(new ipFilterAppTempPortAdd("NNTP", "119,123", "119,123"));
    appTemps.push(new ipFilterAppTempPortAdd("POP3", "110,995", "110,995"));
    appTemps.push(new ipFilterAppTempPortAdd("SQL", "1433", "1433"));
    appTemps.push(new ipFilterAppTempPortAdd("SSH", "22", "22"));
    appTemps.push(new ipFilterAppTempPortAdd("SMTP", "25", "25"));
    appTemps.push(new ipFilterAppTempPortAdd("Telnet", "23", "23"));
    appTemps.push(new ipFilterAppTempPortAdd("TFTP", "","","69", "69"));
    appTemps.push(new ipFilterAppTempPortAdd("WEB", "80", "80"));
    appTemps.push(new ipFilterAppTempPortAdd("Skype", "80,443,23399", "80,443,23399","443,23399", "443,23399"));
    appTemps.push(new ipFilterAppTempPortAdd("VNC", "5500,5800,5900", "5500,5800,5900"));
    appTemps.push(new ipFilterAppTempPortAdd("Vuze", "6880,6969,7000,45100", "6880,6969,7000,45100","16680,49001", "16680,49001"));
    appTemps.push(new ipFilterAppTempPortAdd("Wii", "80,443,28910,29900,29901", "80,443,28910,29900,29901","80,443,28910,29900", "80,443,28910,29900"));
    appTemps.push(new ipFilterAppTempPortAdd("Windows Live Messenger", "80,443,1025,1503,1863,3389,5061,6891:6901,7001,30000:65535", "80,443,1025,1503,1863,3389,5061,6891:6901,7001,30000:65535",
                    "9,1025,1863,5004,6891:6901,7001,30000:65535", "9,1025,1863,5004,6891:6901,7001,30000:65535"));
    appTemps.push(new ipFilterAppTempPortAdd("WinMX", "6699", "6699", "6257", "6257"));
    appTemps.push(new ipFilterAppTempPortAdd("X Windows", "", "", "6000", "6000"));
    appTemps.push(new ipFilterAppTempPortAdd("Xbox Live", "53,80,1863,3074", "53,80,1863,3074","53,80,1863,3074","53,80,1863,3074"));
    appTemps.push(new ipFilterAppTempPortAdd("Yahoo Messenger", "5050", "5050"));
    
    this.GetTcpPortInfoByAppName = function(tempName){
        for (var i = 0; i < appTemps.length; i++){
            if (tempName == appTemps[i].name){
                return appTemps[i].port.tcpPort;
            }
        }
        return nullTemps.port.tcpPort;
    };
    this.GetUdpPortInfoByAppName = function(tempName){
        for (var i = 0; i < appTemps.length; i++){
            if (tempName == appTemps[i].name){
                return appTemps[i].port.udpPort;
            }
        }
        return nullTemps.port.udpPort;
    };
}

var IpFilterAppTemps = new IpFilterAppTempAdd();

var LANhostIP = new Array();
var LANhostName = new Array();

LANhostIP[0] = "";
LANhostName[0] = telmex_language['Telmex_hostName_select'];

var SelectSIPStart = "";
var SelectSIPEnd = "";

var numpara = "";
if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
}

function setSelectIPAddr()
{
    if (CheckIpv6Parameter(numpara) == true) {
        clickAdd('ipfilter_head');
        setText('SourceIPStart', numpara);
    }
}

function loadlanguage()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = ipv6ipincoming_language[b.getAttribute("BindText")];
    }
}

function stPortFilter(domain, Ip6FilterRight, Ip6FilterPolicy, FirewallLevel)
{
    this.domain = domain;
    this.Ip6FilterRight = Ip6FilterRight;
    this.Ip6FilterPolicy = Ip6FilterPolicy;
    this.FirewallLevel = FirewallLevel;
}

var portFilters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security,Ip6FilterRight|Ip6FilterPolicy|X_HW_FirewallLevel,stPortFilter);%>
var portFilter = portFilters[0];
var enblIn = portFilter.Ip6FilterRight;
var Mode = portFilter.Ip6FilterPolicy;
var selctIndex = -1;

function stFilterIn(Domain, Priority, Protocol, Direction, SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd, Action, lanTcpPort, lanUdpPort, wanTcpPort, wanUdpPort,Name,SourceIPMask,DestIPMask,IcmpType)
{
    this.Domain = Domain;
    this.Priority = Priority;
    this.Direction = Direction;
    this.Protocol = Protocol;
    this.SourceIPStart = SourceIPStart;
    this.SourceIPEnd = SourceIPEnd;
    this.DestIPStart = DestIPStart;
    this.DestIPEnd = DestIPEnd;
    if ((Action != "0") && (Action != undefined)) {
        this.Action = (Action.toUpperCase() == "ACCEPT") ? "Accept" : "Drop";
    } else {
        this.Action = Action;
    }
    this.lanTcpPort = lanTcpPort;
    this.lanUdpPort = lanUdpPort;
    this.wanTcpPort = wanTcpPort;
    this.wanUdpPort = wanUdpPort;
    this.name = Name;
    this.SourceIPMask = SourceIPMask;
    this.DestIPMask = DestIPMask;
    this.IcmpType = IcmpType;
}

function DirAndPriCmp(stFilterIn1, stFilterIn2)
{
    var cmp = 0;

    if (stFilterIn1.Direction != stFilterIn2.Direction) {
        if(stFilterIn1.Direction.toUpperCase() == "DOWNSTREAM")
            cmp = 1;
        else
            cmp = -1;
    } else {
        var IntAPri = parseInt(stFilterIn1.Priority, 10);
        var IntBPri = parseInt(stFilterIn2.Priority, 10);
        if (IntAPri > IntBPri)
            cmp = 1;
        else if(IntAPri < IntBPri)
            cmp = -1;
        else 
            cmp = 0;
    }

    return cmp;
}
var FilterIn = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SEC_FilterIn, InternetGatewayDevice.X_HW_Security.Ip6Filter.{i},Priority|Protocol|Direction|SourceIPStart|SourceIPEnd|DestIPStart|DestIPEnd|Action|LanSideTcpPort|LanSideUdpPort|WanSideTcpPort|WanSideUdpPort|Name|SourceIPMask|DestIPMask|IcmpType,stFilterIn);%>;
var FirewallDual = <%HW_WEB_GetFeatureSupport("BBSP_FT_FIREWALL_DUAL");%>;
var IPv6Firewall = <%HW_WEB_GetFeatureSupport("BBSP_FT_CONFIG_IPV6_SESSION");%>;
var IPv6FirewallEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_IPv6FWDFireWallEnable);%>';

if (Mode == 2)
{
    FilterIn.splice(FilterIn.length - 1, 1);
    FilterIn.sort(DirAndPriCmp);
    FilterIn.push(null);
}

function ipfilterselectRemoveCnt(val)
{
}

function OnDeleteButtonClick(TableID)
{
    if ((FilterIn.length-1) == 0) {
        AlertEx(ipv6ipincoming_language['bbsp_norule']);
        return;
    }

    if (selctIndex == -1) {
        AlertEx(ipv6ipincoming_language['bbsp_cannotdel']);
        return;
    }
    var rml = document.getElementsByName(TableName + 'rml');
    var SubmitForm = new webSubmitForm();
    var Count = 0;
    for (var i = 0; i < rml.length; i++) {
        if (rml[i].checked != true) {
            continue;
        }

        Count++;
        SubmitForm.addParameter(rml[i].value,'');
    }
    if (Count <= 0) {
        AlertEx(ipv6ipincoming_language['bbsp_plschoose']);
        return;
    }

    if (ConfirmEx(ipv6ipincoming_language['bbsp_isdel']) == false) {
        document.getElementById("DeleteButton").disabled = false;
        return;
    }
    setDisable('enblFilterIn',1);
    setDisable('FilterMode',1);
    setDisable('btnApply_ex',1);
    setDisable('cancelButton',1);

    SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
    SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/ipv6ipincoming/ipv6ipincomingsonet.asp');   
    SubmitForm.submit();
}

function initPage() {
    setDisable('EnableIpFilter',1);
    setDisable('FilterMode',1);
    setDisable('DeleteButton',1);
    setDisable('RuleNameId',1);
    setDisable('Protocol',1);
    setDisable('sfamiliarAppId',1);
    setDisable('Priority',1);
    setDisable('Direction',1);
    setDisable('IPMode',1);
    setDisable('SourceIPStart',1);
    setDisable('SourceIPStartCol',1);
    setDisable('SourceIPEnd',1);
    setDisable('DestIPStart',1);
    setDisable('DestIPStartCol',1);
    setDisable('DestIPEnd',1);
    setDisable('lanTcpPortId',1);
    setDisable('lanUdpPortId',1);
    setDisable('wanTcpPortId',1);
    setDisable('wanUdpPortId',1);
    setDisable('ICMPType',1);
    setDisable('Action',1);
    setDisable('Newbutton',1);
    setDisable('btnApply_ex',1);
    setDisable('cancelButton',1);
}

function LoadFrame()
{
    InitOption();

    var isProtocalInit = false;

    if (enblIn != '' && Mode != '') {
        setDisplay('ConfigForm1',1);
        setSelect('FilterMode',Mode);

        if (FilterIn.length - 1 == 0) {
            selectLine('record_no');
            setDisplay('ConfigForm',0);
        } else {
            selectLine(TableName + '_record_0');
            setDisplay('ConfigForm',1);
        }

        isProtocalInit = true;
    }
    setDisplay('sfamiliarAppIdRow',0);

    if (enblIn == true) {
        getElById("EnableIpFilter").checked = true;
    }
    
    InitControlDataType();
    if (!isProtocalInit) {
        protocalChange();
    }
    loadlanguage();
    setSelectIPAddr();
    if ((isSpecialFlag == '1') && (IPv6FirewallEnable == 0)) {
        initPage();
    }
}

function setCtlDisplay(record)
{
    setText('RuleNameId',record.name);
    var Protocol = (record.Protocol).toUpperCase();
    if ('ICMPV6' == Protocol) {
        setSelect('Protocol','ICMPv6');
        InitIcmpTypeList();
        setSelect('ICMPType',record.IcmpType);
    } else {
        setSelect('Protocol',Protocol);
    }

    setSelect('Direction',record.Direction);
    setText('Priority',record.Priority);
    setSelect('Action',record.Action);

    if ((record.SourceIPMask != "") || (record.DestIPMask != "")) {
        setSelect('IPMode',"Prefix");
        document.getElementById("SourceIPBias").innerHTML = ' / ';
        document.getElementById("DestIPBias").innerHTML = ' / ';
        document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark']; 
        document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];                                                                                                                                                                                                                                                                                                                          
        if (record.SourceIPMask != "") {
            var subString = record.SourceIPMask.split("/");
            if (subString.length >= 2) {
                setText('SourceIPStart',subString[0]);
                setText('SourceIPEnd',subString[1]);
            }
            if (record.DestIPMask != "") {
                var subString = record.DestIPMask.split("/");
                if (subString.length >= 2) {
                    setText('DestIPStart',subString[0]);
                    setText('DestIPEnd',subString[1]);
                }
            } else {
                setText('DestIPStart','');
                setText('DestIPEnd','');
            }
        } else {
            setText('SourceIPStart','');
            setText('SourceIPEnd','');
            if (record.DestIPMask != "") {
                var subString = record.DestIPMask.split("/");
                if (subString.length >= 2) {
                    setText('DestIPStart',subString[0]);
                    setText('DestIPEnd',subString[1]);
                }
            } else {
                setText('DestIPStart','');
                setText('DestIPEnd','');
            }
        }
        setDisable('IPMode',1);
    } else {  
        if(selctIndex == -1 ) {
            setSelect('IPMode',"Prefix");
            setDisable('IPMode',0);
            document.getElementById("SourceIPBias").innerHTML = '/';
            document.getElementById("DestIPBias").innerHTML = '/';
            document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
            document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
        } else {
            if ((record.SourceIPStart == "") && (record.DestIPStart == "")) {
                setSelect('IPMode',"Prefix");
                document.getElementById("SourceIPBias").innerHTML = '/';
                document.getElementById("DestIPBias").innerHTML = '/';
                document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
                document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
            } else {
                setSelect('IPMode',"Range");
                document.getElementById("SourceIPBias").innerHTML = '--';
                document.getElementById("DestIPBias").innerHTML = '--';
                document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_rangeremark'];
                document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_rangeremark'];
            }
            setDisable('IPMode',1);
        }
        setText('SourceIPStart',record.SourceIPStart);
        setText('SourceIPEnd',record.SourceIPEnd);
        SelectSIPStart = record.SourceIPStart;
        SelectSIPEnd = record.SourceIPEnd;
        setText('SourceIPStart',SelectSIPStart);
        setText('SourceIPEnd',SelectSIPEnd);
        setText('DestIPStart',record.DestIPStart);
        setText('DestIPEnd',record.DestIPEnd);    
    }
    setText('lanTcpPortId',record.lanTcpPort);
    setText('lanUdpPortId',record.lanUdpPort);
    setText('wanTcpPortId',record.wanTcpPort);
    setText('wanUdpPortId',record.wanUdpPort);
    protocalChange(null,record.IcmpType);
}

function setControl(index)
{
    var record;
    selctIndex = index;
    if (index == -1) {
        if (FilterIn.length >= 32+1) {
            setDisplay('ConfigForm', 0);
            AlertEx(ipv6ipincoming_language['bbsp_ipfilterfull']);
            return;
        } else {
            record = new stFilterIn('', '', 'ALL', 'Upstream', '', '', '', '', 0, '', '', '', '','','','','');
            document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
            document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
            setDisplay('ConfigForm', 1);
            setCtlDisplay(record);
        }
    } else if (index == -2) {
        setDisplay('ConfigForm', 0);
    } else {
        record = FilterIn[index];
        setDisplay('ConfigForm', 1);
        setCtlDisplay(record);
    }

    setDisable('btnApply_ex',0);
    setDisable('cancelButton',0);

    if ((isSpecialFlag == '1') && (IPv6FirewallEnable == 0)) {
        initPage();
    }
}

function ChangeMode()
{
    var Form = new webSubmitForm();

    var FilterMode = getElById("FilterMode");
    if (FilterMode[0].selected == true) { 
        if (ConfirmEx(ipv6ipincoming_language['bbsp_changemodenote1'])) {
            Form.addParameter('x.Ip6FilterPolicy',0);
        } else {
            setSelect('FilterMode', Mode);
            return;
        }
    } else if (FilterMode[1].selected == true) { 
        if (ConfirmEx(ipv6ipincoming_language['bbsp_changemodenote2'])) {
            Form.addParameter('x.Ip6FilterPolicy',1);
        } else {
            setSelect('FilterMode', Mode);
            return;
        }
    } else if (FilterMode[2].selected == true) { 
        if (ConfirmEx(ipv6ipincoming_language['bbsp_changemodenote3'])) {
            Form.addParameter('x.Ip6FilterPolicy',2);
        } else {
            setSelect('FilterMode', Mode);
            return;
        }
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
                    + '&RequestFile=html/bbsp/ipv6ipincoming/ipv6ipincomingsonet.asp');
    Form.submit();
}

function SubmitForm()
{ 
    var Form = new webSubmitForm();
    var Enable = getElById("EnableIpFilter").checked;
    if (Enable == true) {
        Form.addParameter('x.Ip6FilterRight',1);
    } else {
        Form.addParameter('x.Ip6FilterRight',0);
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
                        + '&RequestFile=html/bbsp/ipv6ipincoming/ipv6ipincomingsonet.asp');
    Form.submit();
}

function DefaultRule()
{
    if ((getSelectVal('Protocol') == 'ALL')
        && (getValue('SourceIPStart') == '')
        && (getValue('SourceIPEnd') == '')) {
        return true;
    } else {
        return false;
    }
}
function MakePortInfoPairs(s,e)
{
    this.start = s;
    this.end = e;
}
function IpFilterParsePortInfo(portInfo)
{
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
        if(portList2.length > 1) {
            portPairs = new MakePortInfoPairs(portList2[0],portList2[1]);
        } else {
            portPairs = new MakePortInfoPairs(portList1[i],portList1[i]);
        }
        portInfoList.push(portPairs)
    }
    return portInfoList;
}
function IpFilterPortInputChk(portInfo)
{
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
function IpFilterGetPortSum(portInfo)
{
    var portList1 = portInfo.split(',');
    var portList2 = portInfo.split(':');
    var sum = (portList1.length - 1) + (portList2.length - 1) + 1;
    return sum;
}

function PortValidChk(portIn,descp)
{
    var portList;
    if (portIn == '') {
        return true;
    }
    if (IpFilterPortInputChk(portIn) != true) {
        AlertEx(ipv6ipincoming_language['invalid_port'] + "("+portIn+")");
        return false;
    }
    if (IpFilterGetPortSum(portIn) > 15) {
        AlertEx(ipv6ipincoming_language['port_sum_exceed']);
        return false;
    }
    portList = IpFilterParsePortInfo(portIn);
    for (var i = 0; i < portList.length; i++) {
        var portInt = portList[i].start;
        if (isValidPort(portInt) == false) {
            AlertEx(ipv6ipincoming_language['port_port_invalid'] +"("+ portInt+ ")");
            return false;
        }
        portInt = portList[i].end;
        if (isValidPort(portInt) == false) {
            AlertEx(ipv6ipincoming_language['port_port_invalid'] +"("+ portInt+ ")");
            return false;
        }
    }
    var errorPort;
    var repeateFound = false;

    for (var i = 0; i < portList.length; i++) {
        var portStart = parseInt(portList[i].start,10);
        var portEnd = parseInt(portList[i].end,10);
        for (var j = 0; j < portList.length; j++) {
            if(i === j){
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
        if (true == repeateFound) {
            AlertEx(descp  +" \"" + errorPort + ipv6ipincoming_language['bbsp_repeated']);
            return false;
        }
    }

    return true;
}
function IpFilterPortValidChk()
{
    var lanTcpPort = getValue('lanTcpPortId');
    var wanTcpPort = getValue('wanTcpPortId');
    var lanUdpPort = getValue('lanUdpPortId');
    var wanUdpPort = getValue('wanUdpPortId');

    if (PortValidChk(lanTcpPort,ipv6ipincoming_language['port_lan_tcp']) != true) {
        return false;
    }
    if (PortValidChk(wanTcpPort,ipv6ipincoming_language['port_wan_tcp']) != true) {
        return false;
    }

    if (PortValidChk(lanUdpPort,ipv6ipincoming_language['port_lan_udp']) != true) {
        return false;
    }
    if (PortValidChk(wanUdpPort,ipv6ipincoming_language['port_wan_udp']) != true) {
        return false;
    }
    
    return true;
}
function IpFilterRepeateCfgChk()
{
    var Direction = getSelectVal('Direction');
    var Priority = getValue('Priority');
    var sourceIPStart = getValue('SourceIPStart');
    var sourceIPEnd = getValue('SourceIPEnd');
    var destIPStart = getValue('DestIPStart');
    var destIPEnd = getValue('DestIPEnd');
    var protocolVal = getSelectVal('Protocol');
    var dir = getSelectVal('Direction');
    var Action = getValue('Action');
    var lanTcpPort = getValue('lanTcpPortId');
    var wanTcpPort = getValue('wanTcpPortId');
    var lanUdpPort = getValue('lanUdpPortId');
    var wanUdpPort = getValue('wanUdpPortId');
    var Action = getSelectVal('Action');
    var IcmpType = getSelectVal('ICMPType');

    for (i = 0; i < FilterIn.length-1; i++) {
        if(selctIndex != i) {
            if ((Mode == 2)
                && (FilterIn[i].Direction == Direction)
                && (FilterIn[i].Priority == Priority)) {
                AlertEx(ipv6ipincoming_language['bbsp_invaliddirandpri'] + ipv6ipincoming_language[Direction]
                        + ipv6ipincoming_language['bbsp_priorityvalue1'] + Priority
                        + ipv6ipincoming_language['bbsp_repeated']);
                return false;
            }
            if ((FilterIn[i].SourceIPStart == sourceIPStart)
                && (FilterIn[i].SourceIPEnd == sourceIPEnd)
                && (FilterIn[i].DestIPStart == destIPStart)
                && (FilterIn[i].DestIPEnd == destIPEnd)
                && (FilterIn[i].Protocol == protocolVal)
                && (FilterIn[i].Direction == dir)
                && (FilterIn[i].lanTcpPort == lanTcpPort)
                && (FilterIn[i].lanUdpPort == lanUdpPort)
                && (FilterIn[i].wanTcpPort == wanTcpPort)
                && (FilterIn[i].wanUdpPort == wanUdpPort)
                && (FilterIn[i].IcmpType == IcmpType)) {
                    if (Mode == 2){
                        if ( FilterIn[i].Action == Action){
                            AlertEx(ipv6ipincoming_language['bbsp_rulerepeat']);
                            return false;
                        }
                    } else {
                        AlertEx(ipv6ipincoming_language['bbsp_rulerepeat']);
                        return false;
                    }
                }
        }
    }
    return true;
}
function IpFilterDescpChk()
{
    var descrip = getValue("RuleNameId");
    if (descrip == "") {
        AlertEx(ipv6ipincoming_language['rule_name_cannot_blank']);
        return false;
    }
    if (isValidName(descrip) == false) {
        AlertEx(ipv6ipincoming_language['rule_name_invalid']);
        return false;
    }

    for (var i = 0; i < FilterIn.length - 1; i++) {
        if ((FilterIn[i].name == descrip) && (selctIndex != i)) {
            AlertEx(ipv6ipincoming_language['rule_name_cannot_repeated']);
            return false;
        }
    }
    return true;
}

function CheckForm()
{
    if ((FirewallDual == 0) && (IPv6Firewall == 1) && (IPv6FirewallEnable == 0)) {
        AlertEx(ipv6ipincoming_language['bbsp_ipv6firewallnote']);
    }

    var SourceIPStart = getValue('SourceIPStart');
    var SourceIPEnd = getValue('SourceIPEnd');
    var DestIPStart = getValue('DestIPStart');
    var DestIPEnd = getValue('DestIPEnd');
    var Priority = getValue('Priority');

    if (IpFilterDescpChk() != true) {
        return false;
    }

    if (Mode == 2) {
        Priority = removeSpaceTrim(Priority);
        if (Priority!="") {
            if (CheckNumber(Priority,0, 255) == false) {
                AlertEx(ipv6ipincoming_language['bbsp_priorityvalue'] + Priority + ipv6ipincoming_language['bbsp_isvalid1']);
                return false;
            }
        } else {
            AlertEx(ipv6ipincoming_language['bbsp_priorityneed']);
            return false;
        }
    }
    if (getSelectVal('IPMode') == 'Range') {
        if ((SourceIPStart != "") && (CheckIpv6Parameter(SourceIPStart) == false)) {
            AlertEx(ipv6ipincoming_language['bbsp_lanstartaddr'] + SourceIPStart + ipv6ipincoming_language['bbsp_isvalid']);
            return false;
        }
        if ((SourceIPEnd != "") && (CheckIpv6Parameter(SourceIPEnd) == false)) {
            AlertEx(ipv6ipincoming_language['bbsp_lanendaddr'] + SourceIPEnd + ipv6ipincoming_language['bbsp_isvalid']);
            return false;
        }
        if ((SourceIPEnd != "") && (isStartIpbigerEndIp(SourceIPStart,SourceIPEnd) == true)) {
            AlertEx(ipv6ipincoming_language['bbsp_lanstartaddrinvalid']);
            return false;
        }
        if ((SourceIPStart == "") && (SourceIPEnd != "")) {
            AlertEx(ipv6ipincoming_language['bbsp_lanstartaddrisreq']);
            return false;
        }
        if ((DestIPStart != "")  && (CheckIpv6Parameter(DestIPStart) == false)) {
            AlertEx(ipv6ipincoming_language['bbsp_wanstartaddr'] + DestIPStart + ipv6ipincoming_language['bbsp_isvalid']);
            return false;
        }
        if ((DestIPEnd != "") && (CheckIpv6Parameter(DestIPEnd) == false)) {
            AlertEx(ipv6ipincoming_language['bbsp_wanendaddr'] + DestIPEnd + ipv6ipincoming_language['bbsp_isvalid']);
            return false;
        }
        if ((DestIPEnd != "") && (isStartIpbigerEndIp(DestIPStart,DestIPEnd) == true)) {
            AlertEx(ipv6ipincoming_language['bbsp_wanstartaddrinvalid']);
            return false;
        }
        if ((DestIPStart == "") && (DestIPEnd != "")) {
            AlertEx(ipv6ipincoming_language['bbsp_wanstartaddrisreq']);
            return false;
        }
    }
    if (IpFilterPortValidChk() != true) {
        return false;
    }

    if (IpFilterRepeateCfgChk() != true) {
        return false;
    }

    if ((Mode == 2) && (Priority != 255) && (DefaultRule() == true)) {
        AlertEx(ipv6ipincoming_language['bbsp_prioritydefault']);
        return false;
    }

    return true;
}

function GetAjaxRet(Result)
{
    var i = 0;
    var error_index = 'bbsp_paraerror';
    var errorCodeArray = new Array('0xf730708c', '0xf730708d');
    var errorstring = new Array('bbsp_lanprefix', 'bbsp_wanprefix');
    if (Result == '{ "result": 0 }') {
        window.location.href = "/html/bbsp/ipv6ipincoming/ipv6ipincomingsonet.asp";
        return true;
    } else {
        for (i = 0; ; i++) {
            if (Result.split(":")[i].toString().indexOf("error") >= 0 ) {
                break;
            }
        }
        var sub = Result.split(":")[i + 1];
        var errorcode = sub.substring(2, 12);
        for (i = 0; i < errorCodeArray.length; i++) {
            if (errorCodeArray[i] == errorcode) {
                error_index = errorstring[i];
                break;
            }
        }
        AlertEx(ipv6ipincoming_language[error_index]);
        setDisable('btnApply_ex',0);
        setDisable('cancelButton',0);
    }
}

function SubmitParaValue()
{
    if (CheckForm() != true)
    {
        return false;
    }

    var Result = null;
    var Priority = getValue('Priority');
    Priority = removeSpaceTrim(Priority);

    var SubmitParaForm = 'x.Protocol=' + getSelectVal('Protocol');

    SubmitParaForm += "&x.Direction=" + getSelectVal('Direction');

    SubmitParaForm += "&x.Name=" + getSelectVal('RuleNameId');
    if ((getSelectVal('Protocol') != 'ALL') && (getSelectVal('Protocol') != 'ICMP')) {
        SubmitParaForm += "&x.LanSideTcpPort=" + getValue('lanTcpPortId');
        SubmitParaForm += "&x.LanSideUdpPort=" + getValue('lanUdpPortId');
        SubmitParaForm += "&x.WanSideTcpPort=" + getValue('wanTcpPortId');
        SubmitParaForm += "&x.WanSideUdpPort=" + getValue('wanUdpPortId');
    } else {
        SubmitParaForm += "&x.LanSideTcpPort=" + "";
        SubmitParaForm += "&x.LanSideUdpPort=" + "";
        SubmitParaForm += "&x.WanSideTcpPort=" + "";
        SubmitParaForm += "&x.WanSideUdpPort=" + "";
    }
    
    var CurrentValueSS = getValue('SourceIPStart');
    var CurrentValueSE = getValue('SourceIPEnd');
    var CurrentValueDS = getValue('DestIPStart');
    var CurrentValueDE = getValue('DestIPEnd');

    if (getSelectVal('IPMode') == 'Prefix') {
        if ((CurrentValueSS == '') && (CurrentValueSE == '')) {
            SubmitParaForm += "&x.SourceIPMask=" + "";
        } else {
            if ((CurrentValueSS.indexOf("/") == -1) && (CurrentValueSE.indexOf("/") == -1)) {
                var SourceIPMaskValue = CurrentValueSS + '/' + CurrentValueSE;
            }
            SubmitParaForm += "&x.SourceIPMask=" + SourceIPMaskValue;
        }    
        if ((CurrentValueDS == '') && (CurrentValueDE == '')) {
            SubmitParaForm += "&x.DestIPMask=" + "";
        } else {
            if ((CurrentValueDS.indexOf("/") == -1) && (CurrentValueDE.indexOf("/") == -1)) {
                var DestIPMaskValue = CurrentValueDS + '/' + CurrentValueDE;
            }
            SubmitParaForm += "&x.DestIPMask=" + DestIPMaskValue;
        }         
    }
    
    if (getSelectVal('IPMode') == 'Range') {
        SubmitParaForm += "&x.SourceIPStart=" + CurrentValueSS;
        SubmitParaForm += "&x.SourceIPEnd=" + CurrentValueSE;
        SubmitParaForm += "&x.DestIPStart=" + CurrentValueDS;
        SubmitParaForm += "&x.DestIPEnd=" + CurrentValueDE;
    }

    if (getSelectVal('Protocol') == 'ICMPv6') {
        SubmitParaForm += "&x.IcmpType=" + getSelectVal('ICMPType');
    }

    SubmitParaForm += "&x.Direction=" + getSelectVal('Direction');

    if (Mode == 2) {
        SubmitParaForm += "&x.Priority=" + Priority;
        SubmitParaForm += "&x.Action=" + getSelectVal('Action');
    }
    setDisable('btnApply_ex',1);
    setDisable('cancelButton',1);
    setDisable('IPMode',1);
    
    if (selctIndex == -1) {
        $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
         url : "addajax.cgi?x=InternetGatewayDevice.X_HW_Security.Ip6Filter&RequestFile=html/bbsp/ipv6ipincoming/ipv6ipincomingsonet.asp",
         success : function(data) {
            Result = hexDecode(data);
            GetAjaxRet(Result);
         }});
    } else {
        $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
         url : "setajax.cgi?x="+ FilterIn[selctIndex].Domain+ "&RequestFile=html/bbsp/ipv6ipincoming/ipv6ipincomingsonet.asp",
         success : function(data) {
            Result = hexDecode(data);
            GetAjaxRet(Result);
         }
        });
    }
}

function CancelValue()
{
    setDisplay("ConfigForm", 0);
    if (selctIndex == -1) {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length == 1) {

        } else if (tableRow.rows.length == 2) {
 
        } else {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + '_record_0');
        }
    } else {
        var record = FilterIn[selctIndex];
        setCtlDisplay(record);
    }
}

function protocalChange(event_invoke, IcmpType)
{
    var currentPro = getSelectVal('Protocol');
    setDisplay('lanTcpPortIdRow',1);
    setDisplay('lanUdpPortIdRow',1);
    setDisplay('wanTcpPortIdRow',1);
    setDisplay('wanUdpPortIdRow',1);
    setDisplay('ICMPTypeRow',0);
    setDisable('lanUdpPortId',0);
    setDisable('wanUdpPortId',0);
    setDisable('lanTcpPortId',0);
    setDisable('wanTcpPortId',0);
    
    switch (currentPro) {
        case "ALL":
            setDisplay('sfamiliarAppIdRow',0);
            setDisplay('lanTcpPortIdRow',0);
            setDisplay('lanUdpPortIdRow',0);
            setDisplay('wanTcpPortIdRow',0);
            setDisplay('wanUdpPortIdRow',0);
            break;
        case "ICMPv6":
            setDisplay('sfamiliarAppIdRow',0);
            setDisplay('lanTcpPortIdRow',0);
            setDisplay('lanUdpPortIdRow',0);
            setDisplay('wanTcpPortIdRow',0);
            setDisplay('wanUdpPortIdRow',0);
            setDisplay('ICMPTypeRow',1);
            if (document.getElementById('ICMPType').options.length == 0) {
                InitIcmpTypeList();
            }
            if (IcmpType == undefined) {
                setSelect('ICMPType',"");
            } else {
                setSelect('ICMPType',IcmpType);
            }
            break;
        case "TCP":
            setText('lanUdpPortId',"");
            setText('wanUdpPortId',"");
            setDisable('lanUdpPortId',1);
            setDisable('wanUdpPortId',1);
            break;
        case "UDP":
            setText('lanTcpPortId',"");
            setText('wanTcpPortId',"");
            setDisable('lanTcpPortId',1);
            setDisable('wanTcpPortId',1);
            break;
        default:
            break;
    }
}

function InitIcmpTypeList() {
    var List = getElementById("ICMPType");
    List.options.length = 0;
    List.options.add(new Option(ipv6ipincoming_language['bbsp_destination_unreachable'],"destination-unreachable"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_no_route_to_destination'],"no-route-to-destination"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_administratively_prohibited'],"administratively-prohibited"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_beyond_scope_of_source_address'],"beyond-scope-of-source-address"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_address_unreachable'],"address-unreachable"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_icmp_port_unreachable_mh'],"port-unreachable"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_source_address_fai'],"source-address-failed"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_reject_route_to_destination'],"reject-route-to-destination"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_error_source_routing_header'],"error-source-routing-header"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_packet_too_big'],"packet-too-big"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_time_exceeded'],"time-exceeded"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_hop_limit_exceeded'],"hop-limit-exceeded"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_fragment_reassembly_time_exceeded'],"fragment-reassembly-time-exceeded"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_parameter_problem'],"parameter-problem"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_erroneous_header_field'],"erroneous-header-field"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_unrecognized_next_header_type'],"unrecognized-next-header-type"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_unrecognized_ipv6_option'],"unrecognized-ipv6-option"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_echo_request'],"echo-request"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_echo_reply'],"echo-reply"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_neighbor_solicitation'],"neighbor-solicitation"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_neighbor_advertisement'],"neighbor-advertisement"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_redirect_message'],"redirect-message"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_router_renumbering'],"router-renumbering"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_router_renumbering_command'],"router-renumbering-command"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_router_renumbering_result'],"router-renumbering-result"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_sequence_numberreset'],"sequence-number-reset"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_node_information_query'],"node-information-query"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_node_information_response'],"node-information-response"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_inverse_neighbor_discovery_solicitation'],"inverse-neighbor-discovery-solicitation"));
    List.options.add(new Option(ipv6ipincoming_language['bbsp_inverse_neighbor_discoveryadvertisement'],"inverse-neighbor-discovery-advertisement"));
    List.options.add(new Option("",""));
}

function ipmodeChange(event_invoke)
{
    var currentIPMode = getSelectVal('IPMode');
    switch (currentIPMode) {
        case "Prefix":
            document.getElementById("SourceIPBias").innerHTML = ' / ';
            document.getElementById("DestIPBias").innerHTML = ' / ';
            document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];
            document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_prefixremark'];

            break;
        case "Range":
            document.getElementById("SourceIPBias").innerHTML = '--';
            document.getElementById("DestIPBias").innerHTML = '--';
            document.getElementById("SourceIPRemark").innerHTML = ipv6ipincoming_language['bbsp_rangeremark'];
            document.getElementById("DestIPRemark").innerHTML = ipv6ipincoming_language['bbsp_rangeremark'];
            break;
        default:
            break;
            
    }
}

function GetFmiliarAppOptions()
{
    var appTempsLists = getElementById('sfamiliarAppId');
    var apps = new Array(
        "FIRST_APP","bbsp_selectdd",
        "AIM Talk","bbsp_AIMTalk",
        "Apple Remote desktop","bbsp_AppleRemoteDesktop",
        "BearShare","bbsp_BearShare",
        "BitTorrent","bbsp_BitTorrent",
        "Checkpoint FW1 VPN","bbsp_CheckpointFW1VPN",
        "DHCPv6","bbsp_ServerDHCPv6",
        "DirectX","bbsp_DirectX",
        "DNS","bbsp_ServerDNS",
        "eMule","bbsp_eMule",
        "FTP","bbsp_FTPServer",
        "Gnutella","bbsp_Gnutella",
        "HTTPS","bbsp_ServerHTTPS",
        "ICQ","bbsp_ICQ",
        "IMAP","bbsp_ServerIMAP",
        "iMesh","bbsp_iMesh",
        "IP Camera 1","bbsp_CameraIP1",
        "IP Camera 2","bbsp_CameraIP2",
        "IP Camera 3","bbsp_CameraIP3",
        "IP Camera 4","bbsp_CameraIP4",
        "IRC","bbsp_IRC",
        "iTunes","bbsp_iTunes",
        "KaZaa","bbsp_KaZaa",
        "Lotus Notes","bbsp_ServerLotusNotes",
        "MAMP","bbsp_ServerMAMP",
        "MySQL","bbsp_ServerMySQL",
        "Napster","bbsp_Napster",
        "Netmeeting","bbsp_Netmeeting",
        "NNTP","bbsp_ServerNNTP",
        "OpenVPN","bbsp_OpenVPN",
        "pcAnywhere","bbsp_pcAnywhere",
        "PlayStation","bbsp_PlayStation",
        "POP3","bbsp_ServerPOP3",
        "PPTP","bbsp_PPTP",
        "Remote desktop","bbsp_RemoteDesktop",
        "Skype","bbsp_Skype",
        "SMTP","bbsp_ServerSMTP",
        "SQL","bbsp_ServerSQL",
        "SSH","bbsp_ServerSSH",
        "Telnet","bbsp_TelnetServer",
        "TFTP","bbsp_TFTP",
        "WEB","bbsp_ServerWEB",
        "VNC","bbsp_VNC",
        "Vuze","bbsp_Vuze",
        "Wii","bbsp_Wii",
        "Windows Live Messenger","bbsp_WindowsLiveMessenger",
        "WinMX","bbsp_WinMX",
        "XP Remote desktop","bbsp_RemoteSupportXP",
        "X Windows","bbsp_XWindows",
        "Xbox Live","bbsp_XboxLive",
        "Yahoo Messenger","bbsp_YahooMessenger");

    appTempsLists.options.length = 0; 
    for (var i = 0; i < apps.length; i += 2 ) {
        appTempsLists.options.add(new Option(portmapping_language[apps[i+1]], apps[i]));
    }

}
function InitOption()
{
    var Directionlist = getElementById('Direction');
    Directionlist.options.length = 0;

    if (Mode == 2) {
        Directionlist.options.add(new Option(ipv6ipincoming_language['Upstream'], 'Upstream'));
        Directionlist.options.add(new Option(ipv6ipincoming_language['Downstream'], 'Downstream'));
    } else {
        Directionlist.options.add(new Option(ipv6ipincoming_language['Bidirectional'], 'Bidirectional'));
        setDisable('Direction', 1);
        setDisplay('PriorityRow',0);
        setDisplay('ActionRow',0);
    }

    GetFmiliarAppOptions();
}
function IpFilterAppTempSelect(event_invoke)
{
    var currentAppTemp = getSelectVal('sfamiliarAppId');
    setText("lanTcpPortId","");
    setText("wanTcpPortId","");
    setText("lanUdpPortId","");
    setText("wanUdpPortId","");
    setText("wanTcpPortId",IpFilterAppTemps.GetTcpPortInfoByAppName(currentAppTemp).end);
    setText("wanUdpPortId",IpFilterAppTemps.GetUdpPortInfoByAppName(currentAppTemp).end);

    if ((arguments.length > 0) && (event_invoke)) {
        setSelect('Protocol',"TCP/UDP");
        protocalChange();
    }
}
function IpFilterShowInst()
{
    var TableDataInfo = new Array();
    var ShowButtonFlag = true;
    var Listlen = 0;
    
    if (FilterIn.length - 1 == 0) {   
        TableDataInfo[Listlen] = new stFilterIn();
        TableDataInfo[Listlen].domain = '--';
        TableDataInfo[Listlen].Name = '--';
        if (Mode == 2) {
            TableDataInfo[Listlen].Priority = '--';
        }
        TableDataInfo[Listlen].Protocol = '--';
        TableDataInfo[Listlen].Direction = '--';
        TableDataInfo[Listlen].lanip = '--';
        TableDataInfo[Listlen].wanip = '--';
        if (Mode == 2) {
            TableDataInfo[Listlen].Action = '--';
        }
        
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, Ipv6IpincomingConfiglistInfo, ipv6ipincoming_language, null);
    } else {
        for (var i = 0; i < FilterIn.length - 1; i++) {
            TableDataInfo[Listlen] = new stFilterIn();
            TableDataInfo[Listlen].domain = FilterIn[i].Domain;
            
            var ruleName = FilterIn[i].name;
            if (ruleName == '') {
                ruleName = "--";
            }
            TableDataInfo[Listlen].Name = ruleName;
            if (Mode == 2) {
                TableDataInfo[Listlen].Priority = FilterIn[i].Priority;
            }

            if ((FilterIn[i].Protocol).toUpperCase() == "TCP/UDP") {
                TableDataInfo[Listlen].Protocol = ipv6ipincoming_language['TCPUDP'] + '&nbsp;';
            } else if ((FilterIn[i].Protocol).toUpperCase() == "ICMPV6") {
                TableDataInfo[Listlen].Protocol = ipv6ipincoming_language['ICMPv6'] + '&nbsp;';
            } else {
                TableDataInfo[Listlen].Protocol = ipv6ipincoming_language[(FilterIn[i].Protocol).toUpperCase()] + '&nbsp;';
            }
            
            TableDataInfo[Listlen].Direction = ipv6ipincoming_language[FilterIn[i].Direction] + '&nbsp;';

           if (FilterIn[i].SourceIPMask != '') {
              if (FilterIn[i].DestIPMask != '') {
                 TableDataInfo[Listlen].lanip = FilterIn[i].SourceIPMask + '&nbsp;';
                 TableDataInfo[Listlen].wanip = FilterIn[i].DestIPMask + '&nbsp;';
              } else {
                 TableDataInfo[Listlen].lanip = FilterIn[i].SourceIPMask + '&nbsp;';
                 TableDataInfo[Listlen].wanip = '--' + '&nbsp;';
              }
           } else {
              if (FilterIn[i].DestIPMask != '') {
                TableDataInfo[Listlen].lanip = '--' + '&nbsp;';
                TableDataInfo[Listlen].wanip = FilterIn[i].DestIPMask + '&nbsp;';
              } else {
                 if ((FilterIn[i].SourceIPStart != '') && (FilterIn[i].SourceIPEnd != '')) {
                   TableDataInfo[Listlen].lanip = FilterIn[i].SourceIPStart + '-' + '<br/>' + FilterIn[i].SourceIPEnd + '&nbsp;';
                } else if (FilterIn[i].SourceIPStart != '' && FilterIn[i].SourceIPEnd == '') {    
                   TableDataInfo[Listlen].lanip = FilterIn[i].SourceIPStart + '&nbsp;';
                } else if (FilterIn[i].SourceIPStart == '' && FilterIn[i].SourceIPEnd == '') {
                   TableDataInfo[Listlen].lanip = '--' + '&nbsp;';
                }
              }
           }

         if (FilterIn[i].DestIPMask != '') {
            if (FilterIn[i].SourceIPMask != '') {
              TableDataInfo[Listlen].lanip = FilterIn[i].SourceIPMask + '&nbsp;';
              TableDataInfo[Listlen].wanip = FilterIn[i].DestIPMask + '&nbsp;';
            } else {
              TableDataInfo[Listlen].lanip = '--' + '&nbsp;';
              TableDataInfo[Listlen].wanip = FilterIn[i].DestIPMask + '&nbsp;';
            }
         } else {
            if (FilterIn[i].SourceIPMask != '') {
              TableDataInfo[Listlen].lanip = FilterIn[i].SourceIPMask + '&nbsp;';
              TableDataInfo[Listlen].wanip = '--' + '&nbsp;';
            } else {
              if ((FilterIn[i].DestIPStart != '') && (FilterIn[i].DestIPEnd != '')) {
                 TableDataInfo[Listlen].wanip = FilterIn[i].DestIPStart + '-' + '<br/>' + FilterIn[i].DestIPEnd + '&nbsp;';
             } else if ((FilterIn[i].DestIPStart != '') && (FilterIn[i].DestIPEnd == '')) {
                 TableDataInfo[Listlen].wanip = FilterIn[i].DestIPStart + '&nbsp;';
             } else {
                 TableDataInfo[Listlen].wanip = '--' + '&nbsp;';
             }
            }
         }

        if (Mode == 2) {
            TableDataInfo[Listlen].Action = ipv6ipincoming_language[FilterIn[i].Action];
        }

          Listlen++;
       }
       TableDataInfo.push(null);
       HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, Ipv6IpincomingConfiglistInfo, ipv6ipincoming_language, null);
    }
}

function WriteFilterModeOption()
{
    var output = "";
    output = '<option value="0" id="FilterMode1">' + ipv6ipincoming_language['bbsp_blackList'] + '</option>';
    $("#FilterMode").append(output);

    output = '<option value="1" id="FilterMode2">' + ipv6ipincoming_language['bbsp_whiteList'] + '</option>';
    $("#FilterMode").append(output);

    output = '<option value="2" id="FilterMode3" title="' + ipv6ipincoming_language['title3'] + '">' + ipv6ipincoming_language['bbsp_hybridList'] + '</option>';
    $("#FilterMode").append(output);

}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div id="ConfigForm1" style="display:inline">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("ipv6ipincomingtitle", GetDescFormArrayById(ipv6ipincoming_language, "bbsp_mune"), GetDescFormArrayById(ipv6ipincoming_language, ""), false);
    if ((FirewallDual == 0) && (IPv6Firewall == 1)) {
        document.getElementById("ipv6ipincomingtitle_content").innerHTML = ipv6ipincoming_language['bbsp_ipincoming_title1'];
    } else {
        document.getElementById("ipv6ipincomingtitle_content").innerHTML = ipv6ipincoming_language['bbsp_ipincoming_title'];
    }
</script>
<div class="title_spread"></div>

<form id="ipIncomingFltForm" name="ipIncomingFltForm">
<table id="ipIncomingFltFormPanel" cellspacing="1" cellpadding="0" width="100%" class="tabal_noborder_bg">
<li id="EnableIpFilter" RealType="CheckBox" DescRef="bbsp_enable" RemarkRef="tip_perfence" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Ip6FilterRight" InitValue="Empty" ClickFuncApp="onclick=SubmitForm"/>
<li id="FilterMode" RealType="DropDownList" DescRef="bbsp_filtermodemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Ip6FilterPolicy" InitValue="Empty" ClickFuncApp="onchange=ChangeMode" />
</table>
<script>
var TableClass = new stTableClass("table_title width_per20 align_left", "table_right align_left");
var ipIncomingFltFormList = new Array();
ipIncomingFltFormList = HWGetLiIdListByForm("ipIncomingFltForm",null);
HWParsePageControlByID("ipIncomingFltForm",TableClass,ipv6ipincoming_language,null);
WriteFilterModeOption();
document.getElementById("EnableIpFilterspan").innerHTML = "(" + ipv6ipincoming_language['tip_perfence'] + ")";
document.getElementById("EnableIpFilterColleft").innerHTML = ipv6ipincoming_language['bbsp_enable']+ (("1" == "<% HW_WEB_GetFeatureSupport(BBSP_FT_CTC);%>" )?(ipv6ipincoming_language['bbsp_e8cport']):(ipv6ipincoming_language['bbsp_comip'])) + ipv6ipincoming_language['bbsp_filtermh'];

getElById("FilterModeRow").title = ipv6ipincoming_language['title'];
getElById("FilterMode1").title = ipv6ipincoming_language['title1'];
getElById("FilterMode2").title = ipv6ipincoming_language['title2'];
</script>
</form>
<div class="func_spread"></div>
<div  id="divipv6filter" style="overflow-x:auto;overflow-y:hidden;width:100%;">
<script language="JavaScript" type="text/javascript">
    var Ipv6IpincomingConfiglistInfo = new Array();
    var ColumnNum = 0;
    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("Empty","align_center width_per5","DomainBox"));
    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("tip_rule_name2","align_center","Name",false,20));
    ColumnNum = ColumnNum + 2;
    if (Mode == 2) {
        Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("bbsp_priority","align_center","Priority",  false,"",0));
        ColumnNum++;
    }
    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("bbsp_protocol","align_center","Protocol", false,"",0));
    ColumnNum++;

    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("bbsp_direction","align_center","Direction", false,"",0));
    ColumnNum++;

    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("bbsp_lanip","align_center","lanip", false,"",0));
    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("bbsp_wanip","align_center","wanip", false,"",0));
    ColumnNum = ColumnNum + 2;
    if (Mode == 2) {
        Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo("bbsp_action","align_center","Action"));
        ColumnNum++;
    }
    Ipv6IpincomingConfiglistInfo.push(new stTableTileInfo(null));
    IpFilterShowInst();
</script>

<div id="ConfigForm" style="display:none">
    <div class="list_table_spread"></div>
    <form id="ConfigurationForm" name="ConfigurationForm">
        <table id="ConfigurationFormPanel" cellpadding="2" cellspacing="0" width="100%" class="tabal_noborder_bg">
            <li id="RuleNameId" RealType="TextBox" DescRef="tip_rule_name" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.Name" Elementclass="InputRuleName" MaxLength="32" InitValue="Empty" />
            <li id="Protocol" RealType="DropDownList" DescRef="bbsp_protocolmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Protocol" Elementclass="SelectDdns" InitValue="[{TextRef:'ALL',Value:'ALL'},{TextRef:'TCPUDP',Value:'TCP/UDP'},{TextRef:'TCP',Value:'TCP'},{TextRef:'UDP',Value:'UDP'},{TextRef:'ICMPv6',Value:'ICMPv6'}]" ClickFuncApp="onchange=protocalChange" />
            <li id="ICMPType" RealType="DropDownList" DescRef="bbsp_icmptypemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IcmpType" InitValue="Empty"  />
            <li id="sfamiliarAppId" RealType="DropDownList" DescRef="tip_familiar_app" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="sfamiliarAppId" Elementclass="SelectApp" InitValue="Empty" ClickFuncApp="onchange=IpFilterAppTempSelect"/>
            <li id="Priority" RealType="TextBox" DescRef="bbsp_prioritymh" RemarkRef="" ErrorMsgRef="Empty" Require="TRUE" BindField="x.Priority" Elementclass="InputRuleName" MaxLength="6" InitValue="Empty" />
            <li id="Direction" RealType="DropDownList" DescRef="bbsp_directionmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Direction" Elementclass="SelectDdns" InitValue="Empty" />
            <li id="IPMode" RealType="DropDownList" DescRef="bbsp_ipmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" Elementclass="SelectDdns" InitValue="[{TextRef:'IPPrefix',Value:'Prefix'},{TextRef:'IPRange',Value:'Range'}]" ClickFuncApp="onchange=ipmodeChange" />
            <li id="SourceIPStart" RealType="TextOtherBox" DescRef="bbsp_lanipmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="63"
                InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'SourceIPBias'},{AttrName:'innerhtml', AttrValue:' / '}]},
                            {Type:'text',Item:[{AttrName:'id',AttrValue:'SourceIPEnd'},{AttrName:'BindFileld', AttrValue:'x.SourceIPEnd'},{AttrName:'MaxLength', AttrValue:'63'}]},
                            {Type:'span',Item:[{AttrName:'id',AttrValue:'SourceIPRemark'},{AttrName:'innerhtml', AttrValue:''}]}]"/>
            <li id="DestIPStart" RealType="TextOtherBox" DescRef="bbsp_wanipmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="63" 
                InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'DestIPBias'},{AttrName:'innerhtml', AttrValue:' / '}]},
                            {Type:'text',Item:[{AttrName:'id',AttrValue:'DestIPEnd'},{AttrName:'BindFileld', AttrValue:'x.DestIPEnd'},{AttrName:'MaxLength', AttrValue:'63'}]},
                            {Type:'span',Item:[{AttrName:'id',AttrValue:'DestIPRemark'},{AttrName:'innerhtml', AttrValue:''}]}]"/>
            <li id="lanTcpPortId" RealType="TextBox" DescRef="port_lan_tcp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.LanSideTcpPort" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
            <li id="lanUdpPortId" RealType="TextBox" DescRef="port_lan_udp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.LanSideUdpPort" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
            <li id="wanTcpPortId" RealType="TextBox" DescRef="port_wan_tcp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.WanSideTcpPort" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
            <li id="wanUdpPortId" RealType="TextBox" DescRef="port_wan_udp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.WanSideUdpPort" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
            <li id="Action" RealType="DropDownList" DescRef="bbsp_actionmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Action" Elementclass="SelectDdns" InitValue="[{TextRef:'Accept',Value:'Accept'},{TextRef:'Drop',Value:'Drop'}]" />
        </table>
        <script>
            var Ipv6FilterConfigurationFormList = new Array();
            Ipv6FilterConfigurationFormList = HWGetLiIdListByForm("ConfigurationForm",null);
            HWParsePageControlByID("ConfigurationForm",TableClass,ipv6ipincoming_language,null);
            document.getElementById("PriorityRemark").innerHTML = '(0-255)';
        </script>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
            <tr>
                <td class='width_per20'></td>
                <td class="table_submit">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <button id='btnApply_ex' name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitParaValue();"><script>document.write(ipv6ipincoming_language['bbsp_app']);</script></button>
                <button id='cancelButton' name="cancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();"><script>document.write(ipv6ipincoming_language['bbsp_cancel']);</script></button> </td>
            </tr>
        </table>
    </form>
</div>
<div style="height:15px;"></div>
</div> 
 <table width="100%" height="20" cellpadding="0" cellspacing="0"><tr><td></td></tr></table>
</body>
</html>