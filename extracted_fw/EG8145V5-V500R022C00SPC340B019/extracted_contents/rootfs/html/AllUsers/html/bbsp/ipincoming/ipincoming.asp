<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>IP Incoming Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, ipincoming_language, portmapping_language);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<style>
.SelectDdns{
	width: 103px;
}
.InputRuleName{
	width: 98px;
}
.InputDdns{
	width: 120px;
}
</style>
<script language="JavaScript" type="text/javascript">
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var ignorefirewall = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPFLT_IGNORE_FWLEVEL);%>"; 
var IsDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var applyFlag = true;
var isARCLARO = (CfgModeWord === 'ARCLARO');
function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
}

var isZqFeatureSupport = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';

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
        for(var i = 0; i < appTemps.length; i++){
            if( tempName == appTemps[i].name ){
                return appTemps[i].port.tcpPort;
            }
        }
        return nullTemps.port.tcpPort;
    };
    this.GetUdpPortInfoByAppName = function(tempName){
        for(var i = 0; i < appTemps.length; i++){
            if( tempName == appTemps[i].name ){
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
LANhostName[0] = ipincoming_language['hostName_select'];

var SelectSIPStart = "";
var SelectSIPEnd = "";

function stApDeviceList(domain,ApOnlineFlag,APMacAddr) {
    this.domain = domain;
    this.ApOnlineFlag = ApOnlineFlag;
    this.APMacAddr = APMacAddr;
}
var ApDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i},ApOnlineFlag|APMacAddr,stApDeviceList);%>;
function GetUserDevAlias(obj)
{
    if (obj.UserDevAlias != "--")
    {
        return obj.UserDevAlias;
    }
    else if (obj.HostName != "--")
    {
        return obj.HostName;
    }
    else
    {
        return obj.MacAddr;
    }
}
function SetLanHostNameIp(UserDevices)
{
	var UserDevicesnum = UserDevices.length - 1;
	for (var i = 0,j = 1; i < UserDevicesnum; i++)
	{
	    var isAPMacAddr = 0;
        for (var k = 0; k < ApDeviceList.length-1; k++) {
            if (UserDevices[i].MacAddr.toUpperCase() == ApDeviceList[k].APMacAddr.toUpperCase()) {   
                isAPMacAddr = 1;
            }        
        }
		
		if(isAPMacAddr == 1) {
            continue;
        }
	
		if ("--" != UserDevices[i].HostName) {
      	    LANhostName[j] = UserDevices[i].HostName;
      	    LANhostIP[j] = UserDevices[i].IpAddr;
        } else {
            LANhostName[j] = UserDevices[i].MacAddr;
	  	    LANhostIP[j] = UserDevices[i].IpAddr;
        }
        if (IsDevTypeFlag == 1) {
            LANhostName[j] = GetUserDevAlias(UserDevices[i]);
        }
        j++;  		
  	    LANhostIP[i+1] = UserDevices[i].IpAddr;
    }
}

function SHostNameChange(item)
{

	setText('SourceIPStart',LANhostIP[getSelectVal('SHostName')]);

}

function EHostNameChange(item)
{
	
	setText('SourceIPEnd',LANhostIP[getSelectVal('EHostName')]);

}

var numpara = "";
if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
}

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = ipincoming_language[b.getAttribute("BindText")];
	}
}

function stPortFilter(domain, ipFilterInRight, ipFilterInPolicy, FirewallLevel)
{
    this.domain = domain;
	this.ipFilterInRight = ipFilterInRight;
	this.ipFilterInPolicy = ipFilterInPolicy;
	this.FirewallLevel    = FirewallLevel;
}

var portFilters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security,IpFilterInRight|IpFilterInPolicy|X_HW_FirewallLevel,stPortFilter);%>
var portFilter = portFilters[0]; 

var enblIn = portFilter.ipFilterInRight;
var Mode = portFilter.ipFilterInPolicy;
var FltsecLevel = portFilters[0].FirewallLevel.toUpperCase();
var selctIndex = -1;

function stFilterIn(Domain, Priority, Protocol, Direction, SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd, Action, lanTcpPort, lanUdpPort, wanTcpPort, wanUdpPort, Name, sourceInterface, vlanId)
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
    this.sourceInterface = sourceInterface;
    this.vlanId = vlanId;
}

function DirAndPriCmp(stFilterIn1, stFilterIn2)
{
	var cmp = 0;
	
	if(stFilterIn1.Direction != stFilterIn2.Direction)
	{
		if(stFilterIn1.Direction.toUpperCase() == "DOWNSTREAM")
			cmp = 1;
		else
			cmp = -1;
	}
	else
	{
		var IntAPri = parseInt(stFilterIn1.Priority, 10);
		var IntBPri = parseInt(stFilterIn2.Priority, 10);
		if(IntAPri > IntBPri)
			cmp = 1;
		else if(IntAPri < IntBPri)
			cmp = -1;
		else 
			cmp = 0;
	}
	
	return cmp;
}
var FilterIn = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SEC_FilterIn, InternetGatewayDevice.X_HW_Security.IpFilterIn.{i}, Priority|Protocol|Direction|SourceIPStart|SourceIPEnd|DestIPStart|DestIPEnd|Action|LanSideTcpPort|LanSideUdpPort|WanSideTcpPort|WanSideUdpPort|Name|SourceInterface|VlanId, stFilterIn);%>;

if(Mode == 2)
{
	FilterIn.splice(FilterIn.length - 1, 1);	
	FilterIn.sort(DirAndPriCmp);
	FilterIn.push(null);
}


function clickRemove() 
{
    if ((FilterIn.length-1) == 0)
	{
	    AlertEx(ipincoming_language['bbsp_norule']);
	    return;
	}

	if (selctIndex == -1)
	{
	    AlertEx(ipincoming_language['bbsp_cannotdel']);
	    return;
	}
    var rml = getElement('rml');
    var noChooseFlag = true;
    if ( rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             {   
                 noChooseFlag = false;
             }
         }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
    }
    if ( noChooseFlag )
    {
        AlertEx(ipincoming_language['bbsp_plschoose']);
        return ;
    }
 
	if (ConfirmEx(ipincoming_language['bbsp_isdel']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
		return;
    }
    setDisable('enblFilterIn',1);
    setDisable('FilterMode',1);
    setDisable('btnApply_ex',1);
    setDisable('cancelButton',1);
    removeInst('html/bbsp/ipincoming/ipincoming.asp');
}

function setSelectHostName()
{
	if(isValidIpAddress(numpara) == true)
	{
		clickAdd('IP Incoming Filter');
		setText('SourceIPStart', numpara);
		getElById("EnableIpFilter").checked = true;

		for (var k = 0; k < LANhostIP.length; k++)
		{
			if (numpara == LANhostIP[k])
			{
				setSelect('SHostName', k);
				break;
			}
		}
	}
}

function setSelectSHostName()
{
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (SelectSIPStart == LANhostIP[k])
		{
			setSelect('SHostName', k);
			break;
		}
	}
}
function setSelectEHostName()
{
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (SelectSIPEnd == LANhostIP[k])
		{
			setSelect('EHostName', k);
			break;
		}
	}
}

function newClickAdd(flag) 
{ 
    initSelectHostNameARCLARO();
    initDataForARCLARO();
    clickAdd(flag);
}

function newOnDeleteButtonClick(flag)
{
    if(isARCLARO){
       return;
    }
    OnDeleteButtonClick(flag);
}

function newSelectLine(flag)
{
    selectLine(flag);
    initSelectHostNameARCLARO("grey");
    initDataForARCLARO("grey");
}

function replaceSelectLineFun()
{   
    if (!isARCLARO) {
        return;
    }
    for (var i = 0; i < FilterIn.length - 1; i++)
    {   
        var record = "record_"+i;
        $('#'+record).attr("onclick","newSelectLine(this.id);");
    }   
}

function constantGrey() 
{
    setDisable('EnableIpFilter', 1);
    setDisable('FilterMode', 1);
    setDisable('DeleteButton', 1);
}

function initSelectHostNameARCLARO(flag)
{
    if (!isARCLARO) {
        return;
    }
    if (flag == "grey") {
        applyFlag = false;
        setDisable("SHostName", 1);
        setDisable("EHostName", 1);
    } else {
        applyFlag = true;
        setDisable("SHostName", 0);
        setDisable("EHostName", 0);
    }
}

function initDataForARCLARO(flag)
{
    if (!isARCLARO) {
        return;
    }
    var ipFilterInput = $('#ipfilter').find("input");
    var cfgFormInput = $('#TableConfigurationForm').find("input");
    var select = $('#TableConfigurationForm').find("select");
  
    if (flag == "grey") {
        applyFlag = false;
        constantGrey();
        for (var i = 0; i < ipFilterInput.length; i++) {
            setDisable(ipFilterInput[i].id, 1);
        }
        for (var i = 0; i < cfgFormInput.length; i++) {
            setDisable(cfgFormInput[i].id, 1);
        }
        for (var i = 0; i < select.length; i++) {
            setDisable(select[i].id, 1);
        }
    } else {
        applyFlag = true;
        constantGrey();
        for (var i = 0; i < cfgFormInput.length; i++) {
            setDisable(cfgFormInput[i].id, 0);
        }
        for (var i = 0; i < select.length; i++) {
            setDisable(select[i].id, 0);
        }
    }
    $("#Newbutton").attr("onclick","newClickAdd('IP Incoming Filter');");
    $("#DeleteButton").attr("onclick","newOnDeleteButtonClick('IP Incoming Filter');"); 
}

function LoadFrame()
{   
    InitOption();

    if (enblIn != '' && Mode != '')
    {   
        setDisplay('ConfigForm1',1);
        setSelect('FilterMode',Mode);

        if (FilterIn.length - 1 == 0)
        {   
            selectLine('record_no');
            setDisplay('ConfigForm',0);
        }
        else
        {
            selectLine('record_0');
            setDisplay('ConfigForm',1);
        }
    }

    if (enblIn == true)
    {
        getElById("EnableIpFilter").checked = true;
    }

    
	InitControlDataType();
    protocalChange();
    
	setSelectHostName();
	if((FltsecLevel != 'CUSTOM')
	    && (ignorefirewall == "0"))
	{
		setDisable('EnableIpFilter' , 1);
		setDisable('FilterMode' , 1);
    }

    if (((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) && (FltsecLevel != 'CUSTOM')) {
        setDisable('DeleteButton',1);
        setDisable('Newbutton',1);
        $("#EnableIpFilterColleft").css("color","#767676");
        $("#FilterModeColleft").css("color","#767676");
    }	
	loadlanguage();
    initDataForARCLARO("grey");
}


function setCtlDisplay(record)
{
    setText('RuleNameId',record.name);
	setSelect('Protocol',(record.Protocol).toUpperCase());

	setSelect('Direction',record.Direction);
	setText('Priority',record.Priority);
	setSelect('Action',record.Action);
	
    setText('SourceIPStart',record.SourceIPStart);
	setText('SourceIPEnd',record.SourceIPEnd);
	SelectSIPStart = record.SourceIPStart;
	SelectSIPEnd = record.SourceIPEnd;
	setSelectSHostName();
	setSelectEHostName();
	setText('SourceIPStart',SelectSIPStart);
	setText('SourceIPEnd',SelectSIPEnd);
	
	setText('DestIPStart',record.DestIPStart);
	setText('DestIPEnd',record.DestIPEnd);

	setText('lanTcpPortId',record.lanTcpPort);
	setText('lanUdpPortId',record.lanUdpPort);
	setText('wanTcpPortId',record.wanTcpPort);
    setText('wanUdpPortId',record.wanUdpPort);
    setSelect('WanNameList_DEFHIDE', record.sourceInterface);
    setText('VlanId', record.vlanId == '0' ? '' : record.vlanId);

    protocalChange();
    if (GetCfgMode().TELMEX != '1') {
        handleDirectionChange();
    }
    else {
        setDisplay('VlanIdRow', 0);
    }
}

function handleDirectionChange() {
    var currDir = getSelectVal('Direction');
    if (isZqFeatureSupport == '1' && Mode == '2' && currDir == 'Upstream') {
        setDisplay('VlanIdRow', 1);
    }
    else {
        setDisplay('VlanIdRow', 0);
    }
}

function setControl(index)
{
    var record;
    selctIndex = index;
    if (index == -1)
	{
	    if (FilterIn.length >= 32+1)
        {
            setDisplay('ConfigForm', 0);
            AlertEx(ipincoming_language['bbsp_ipfilterfull']);
            return;
        }
        else
        {
			record = new stFilterIn('', '', 'ALL', 'Upstream', '', '', '', '', 'Accept', '', '', '', '', '', '', '0');
            setDisplay('ConfigForm', 1);
	        setCtlDisplay(record);
        }
	}
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
	else
	{
	    record = FilterIn[index];
        setDisplay('ConfigForm', 1);
	    setCtlDisplay(record);
	}

    setDisable('btnApply_ex',0);
    setDisable('cancelButton',0);
}

function ChangeMode()
{
    var Form = new webSubmitForm();
	
    var FilterMode = getElById("FilterMode");
    if (FilterMode[0].selected == true)
	{ 
		if (ConfirmEx(ipincoming_language['bbsp_changemodenote1']))
		{
			Form.addParameter('x.IpFilterInPolicy',0);		
		}
		else
		{
	        setSelect('FilterMode', Mode);
			return;
		}
	}
	else if (FilterMode[1].selected == true)
	{ 
		if (ConfirmEx(ipincoming_language['bbsp_changemodenote2']))
		{
			Form.addParameter('x.IpFilterInPolicy',1);
		}
		else
		{
		     setSelect('FilterMode', Mode);
			 return;
		}
	}
	else if (FilterMode[2].selected == true)
	{
		if (CfgModeWord == "TRIPLETAP" || CfgModeWord == "TRIPLETAPNOGM" || CfgModeWord == "TRIPLETAP6" || CfgModeWord == "TRIPLETAP6PAIR") {
			ipincoming_language['bbsp_changemodenote3'] = ipincoming_language['bbsp_changemodenote4'];
		}
		if (ConfirmEx(ipincoming_language['bbsp_changemodenote3']))
		{
			Form.addParameter('x.IpFilterInPolicy',2);
		}
		else
		{
			 setSelect('FilterMode', Mode);
			 return;
		}
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
	                + '&RequestFile=html/bbsp/ipincoming/ipincoming.asp');
    Form.submit();
}

function SubmitForm()
{ 
    var Form = new webSubmitForm();
    var Enable = getElById("EnableIpFilter").checked;
    if (Enable == true)
    {
        Form.addParameter('x.IpFilterInRight',1); 
    }
    else
    {
        Form.addParameter('x.IpFilterInRight',0); 
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
                        + '&RequestFile=html/bbsp/ipincoming/ipincoming.asp');
    Form.submit();
}

function DefaultRule()
{
	if ((getSelectVal('Protocol') == 'ALL')
		&& (getValue('SourceIPStart') == '')
		&& (getValue('SourceIPEnd') == ''))
	{
        if (CfgModeWord.toUpperCase() == "ROSUNION") {
            if ((getValue('DestIPStart') == '') && (getValue('DestIPEnd') == '')) {
                return true;
            }
            return false;
        } 
		return true;
	}
	return false;
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

    if('' == portInfo)
    {
        var portPairs = new MakePortInfoPairs("","");
        portInfoList.push(portPairs);
        return portInfoList;
    }
    
    portList1 = portInfo.split(',');

    for(var i = 0; i < portList1.length; i++)
    {
        var portPairs;       
        var portList2 = portList1[i].split(':');
        if(portList2.length > 1)
        {
            portPairs = new MakePortInfoPairs(portList2[0],portList2[1]);
        }
        else
        {
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

    for(var i = 0; i < portList.length; i++)
    {       
        if(portList[i].indexOf(":") > 0)
        {
            var list2 = portList[i].split(':');
            
            if(2 != list2.length)
            {
                return false;
            }
            for(var j = 0; j < 2;j++)
            {
                result = numbersMatch.exec(list2[j]);
                if(null == result)
                {
                    return false;
                }
            }

            if(parseInt(list2[0],10) > parseInt(list2[1],10))
            {
                return false;
            }
        }
        else
        {
            result = numbersMatch.exec(portList[i]);
            if(null == result)
            {
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
    if('' == portIn)
    {
        return true;
    }
    if(true != IpFilterPortInputChk(portIn))
    {
        AlertEx(ipincoming_language['invalid_port'] + "("+portIn+")");
        return false;
    }
    if(IpFilterGetPortSum(portIn) > 15)
    {
        AlertEx(ipincoming_language['port_sum_exceed']);
        return false;
    }
    portList = IpFilterParsePortInfo(portIn);
    for(var i = 0; i < portList.length; i++)
    {
        var portInt = portList[i].start;
        if(isValidPort(portInt) == false)
        {
            AlertEx(ipincoming_language['port_port_invalid'] +"("+ portInt+ ")");
            return false;
        }
        portInt = portList[i].end;
        if(isValidPort(portInt) == false)
        {
            AlertEx(ipincoming_language['port_port_invalid'] +"("+ portInt+ ")");
            return false;
        }
    }
    var errorPort;
    var repeateFound = false;

    for(var i = 0; i < portList.length; i++)
    {
        var portStart = parseInt(portList[i].start,10);
        var portEnd = parseInt(portList[i].end,10);
        for(var j = 0; j < portList.length; j++)
        {
            if(i === j){
                continue;
            }

    		if( (portStart >= parseInt(portList[j].start,10)) && (portStart <= parseInt(portList[j].end,10)) )
    		{
    		    errorPort = portStart;
    		    repeateFound = true;
    		    break;
    		}

    		if( (portEnd >= parseInt(portList[j].end,10)) && (portEnd <= parseInt(portList[j].end,10)) )
    		{
    		    errorPort = portEnd;
    		    repeateFound = true;
    		    break;
    		}

    		if( (portStart < parseInt(portList[j].start,10)) && (portEnd > parseInt(portList[j].end,10)) )
    		{
    		    errorPort = portList[j].start;
    		    repeateFound = true;
    		    break;
    		}
        }
        if(true == repeateFound)
        {
            AlertEx(descp  +" \"" + errorPort + ipincoming_language['bbsp_repeated']);
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
 

    if(true != PortValidChk(lanTcpPort,ipincoming_language['port_lan_tcp']))
    {
        return false;
    }
    if(true != PortValidChk(wanTcpPort,ipincoming_language['port_wan_tcp']))
    {
        return false;
    }

    if(true != PortValidChk(lanUdpPort,ipincoming_language['port_lan_udp']))
    {
        return false;
    }
    if(true != PortValidChk(wanUdpPort,ipincoming_language['port_wan_udp']))
    {
        return false;
    }
    
    return true;
}

function IpFilterRepeateCfgChk() {
    var direction = getSelectVal('Direction');
    var priority = getValue('Priority');
    var sourceIPStart = getValue('SourceIPStart');
    var sourceIPEnd = getValue('SourceIPEnd');
    var destIPStart = getValue('DestIPStart');
    var destIPEnd = getValue('DestIPEnd');
    var protocolVal = getSelectVal('Protocol');
    var lanTcpPort = getValue('lanTcpPortId');
    var wanTcpPort = getValue('wanTcpPortId');
    var lanUdpPort = getValue('lanUdpPortId');
    var wanUdpPort = getValue('wanUdpPortId');
    var action = getSelectVal('Action');
    var vlanId = getValue('VlanId');

    for (i = 0; i < FilterIn.length - 1; i++) {
        if (i == selctIndex) {
            continue;
        }

        if (Mode == 2 && FilterIn[i].Direction == direction && FilterIn[i].Priority == priority) {
            AlertEx(ipincoming_language['bbsp_invaliddirandpri'] + ipincoming_language[direction] +
                ipincoming_language['bbsp_priorityvalue1'] + priority + ipincoming_language['bbsp_repeated']);
            return false;
        }

        if (FilterIn[i].SourceIPStart == sourceIPStart && FilterIn[i].SourceIPEnd == sourceIPEnd &&
            FilterIn[i].DestIPStart == destIPStart && FilterIn[i].DestIPEnd == destIPEnd &&
            FilterIn[i].Protocol == protocolVal && FilterIn[i].Direction == direction &&
            FilterIn[i].lanTcpPort == lanTcpPort && FilterIn[i].lanUdpPort == lanUdpPort &&
            FilterIn[i].wanTcpPort == wanTcpPort && FilterIn[i].wanUdpPort == wanUdpPort) {
            if (Mode != 2) {
                AlertEx(ipincoming_language['bbsp_rulerepeat']);
                return false;
            }

            if (isZqFeatureSupport == '1') {
                if (FilterIn[i].Action == action &&
                    (FilterIn[i].vlanId == vlanId || (FilterIn[i].vlanId == 0 && vlanId == ''))) {
                    AlertEx(ipincoming_language['bbsp_rulerepeat']);
                    return false;
                }
            }
            else {
                if (FilterIn[i].Action == action) {
                    AlertEx(ipincoming_language['bbsp_rulerepeat']);
                    return false;
                }
            }
        }
    }
    return true;
}

function CheckForm()
{	
    var SourceIPStart = getValue('SourceIPStart');
    var SourceIPEnd = getValue('SourceIPEnd');
    var DestIPStart = getValue('DestIPStart');
    var DestIPEnd = getValue('DestIPEnd');
	var Priority = getValue('Priority');

	if ( Mode == 2 )
	{
		Priority = removeSpaceTrim(Priority);
		if(Priority!="")
		{
		   if ( false == CheckNumber(Priority,0, 255) )
		   {
			 AlertEx(ipincoming_language['bbsp_priorityvalue'] + Priority + ipincoming_language['bbsp_isvalid1']);
			 return false;
		   }
		}
		else
		{
			AlertEx(ipincoming_language['bbsp_priorityneed']);
			return false;
		}
	}	

    if (GetCfgMode().TELMEX != '1') {
        var direction = getSelectVal('Direction');
        if (isZqFeatureSupport == '1' && Mode == '2' && direction == 'Upstream') {
            var vlanId = getValue('VlanId');
            if (vlanId != '' && !CheckNumber(vlanId, 1, 4093)) {
                AlertEx(ipincoming_language['bbsp_tips_vlan_id'] + vlanId + ipincoming_language['bbsp_isvalid']);
                return false;
            }
        }
    }

	if (SourceIPStart != "" && isAbcIpAddress(SourceIPStart) == false)
	{
		AlertEx(ipincoming_language['bbsp_lanstartaddr'] + SourceIPStart + ipincoming_language['bbsp_isvalid']);
		return false;
	}
	if (SourceIPEnd != "" && isAbcIpAddress(SourceIPEnd) == false)
	{
		AlertEx(ipincoming_language['bbsp_lanendaddr'] + SourceIPEnd + ipincoming_language['bbsp_isvalid']);
		return false;
	}
    if (SourceIPEnd != "" 
	    && (IpAddress2DecNum(SourceIPStart) > IpAddress2DecNum(SourceIPEnd)))
	{
		AlertEx(ipincoming_language['bbsp_lanstartaddrinvalid']);
		return false;     	
	}
    if (SourceIPStart == "" && SourceIPEnd != "" ) 
	{
		AlertEx(ipincoming_language['bbsp_lanstartaddrisreq']);
		return false;
	}
	
	

	if (DestIPStart != ""  && isAbcIpAddress(DestIPStart) == false) 
	{
		AlertEx(ipincoming_language['bbsp_wanstartaddr'] + DestIPStart + ipincoming_language['bbsp_isvalid']);
		return false;
	}
	if (DestIPEnd != "" && isAbcIpAddress(DestIPEnd) == false) 
	{
		AlertEx(ipincoming_language['bbsp_wanendaddr'] + DestIPEnd + ipincoming_language['bbsp_isvalid']);
		return false;
	}
    if (DestIPEnd != "" 
	    && (IpAddress2DecNum(DestIPStart) > IpAddress2DecNum(DestIPEnd)))
	{
		AlertEx(ipincoming_language['bbsp_wanstartaddrinvalid']);
		return false;     	
	}
    if (DestIPStart == "" && DestIPEnd != "" ) 
	{
		AlertEx(ipincoming_language['bbsp_wanstartaddrisreq']);
		return false;
	}
	

    if(true != IpFilterPortValidChk())
    {
        return false;
    }

    if(true != IpFilterRepeateCfgChk())
    {
        return false;
    }
    
	if ((Mode == 2) && (Priority != 255) && (true == DefaultRule()))
	{
	    AlertEx(ipincoming_language['bbsp_prioritydefault']);
		return false;
	}

   	return true;
}
function AddSubmitParam(SubmitForm,type)
{
	var Priority = getValue('Priority');
	Priority = removeSpaceTrim(Priority);

    SubmitForm.addParameter('x.Protocol', getSelectVal('Protocol'));
    if ("1" != GetCfgMode().TELMEX) {
        var direction = getSelectVal('Direction');
        SubmitForm.addParameter('x.Direction', direction);

        var vlanId = getValue('VlanId');
        if (isZqFeatureSupport == '1' && Mode == '2') {
            if (direction == 'Upstream') {
                SubmitForm.addParameter('x.VlanId', vlanId == '' ? 0 : vlanId);
            }
            else {
                SubmitForm.addParameter('x.VlanId', 0);
            }
        }
    }

    SubmitForm.addParameter('x.Name',getSelectVal('RuleNameId'));
    if ( Mode == 2 )
    {
    	SubmitForm.addParameter('x.Priority',Priority);
    	SubmitForm.addParameter('x.Action',getValue('Action'));	  
    }

    SubmitForm.addParameter('x.SourceIPStart',getValue('SourceIPStart'));
    SubmitForm.addParameter('x.SourceIPEnd',getValue('SourceIPEnd'));
    SubmitForm.addParameter('x.DestIPStart',getValue('DestIPStart'));
    SubmitForm.addParameter('x.DestIPEnd',getValue('DestIPEnd'));

    if (getSelectVal('Protocol') != 'ALL' && getSelectVal('Protocol') != 'ICMP')
    {
        SubmitForm.addParameter('x.LanSideTcpPort',getValue('lanTcpPortId'));
        SubmitForm.addParameter('x.LanSideUdpPort',getValue('lanUdpPortId'));
        SubmitForm.addParameter('x.WanSideTcpPort',getValue('wanTcpPortId'));
        SubmitForm.addParameter('x.WanSideUdpPort',getValue('wanUdpPortId'));
    }
    else
    {
        SubmitForm.addParameter('x.LanSideTcpPort',"");
        SubmitForm.addParameter('x.LanSideUdpPort',"");
    	SubmitForm.addParameter('x.WanSideTcpPort',"");
    	SubmitForm.addParameter('x.WanSideUdpPort',"");
    }

    if (CfgModeWord.toUpperCase() == "ROSUNION") {
        SubmitForm.addParameter('x.SourceInterface', getSelectVal('WanNameList_DEFHIDE'));
	}
	
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
    setDisable('btnApply_ex',1);
    setDisable('cancelButton',1);
    
	if (selctIndex == -1)
	{
        SubmitForm.setAction('add.cgi?x=InternetGatewayDevice.X_HW_Security.IpFilterIn'
    	                         + '&RequestFile=html/bbsp/ipincoming/ipincoming.asp');
    }
    else
    {
		SubmitForm.setAction('set.cgi?x=' + FilterIn[selctIndex].Domain
				+ '&RequestFile=html/bbsp/ipincoming/ipincoming.asp');
    }

}

function SubmitEx()
{
    if (!applyFlag){
        CancelValue();
    }

    if(isValidIpAddress(numpara) == true)
    {
        var IpFilterInRightValue;
        var Form = new webSubmitForm();
        if (true == getElById("EnableIpFilter").checked)
        {
            IpFilterInRightValue = 1; 
        }
        else
        {
            IpFilterInRightValue = 0;
        }

        $.ajax({
             type : "POST",
             async : false,
             cache : false,
             data : "x.IpFilterInRight=" + IpFilterInRightValue +"&x.X_HW_Token="+getValue('onttoken'),
             url : "set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/ipincoming/ipincoming.asp",
             success : function(data) {
             },
             complete: function (XHR, TS) {
                XHR=null;
             }
        });
    }

    Submit();
}

function CancelValue()
{
    setDisplay("ConfigForm", 0);
	
	if (selctIndex == -1)
    {
        var tableRow = getElement("ipfilter");

        if (tableRow.rows.length == 1)
        {

        }
        else if (tableRow.rows.length == 2)
        {
            addNullInst('IP Incoming Filter');
        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine('record_0');
        }
    }
    else
    {
        var record = FilterIn[selctIndex];
        setCtlDisplay(record);
    }
}



function protocalChange(event_invoke)
{   
    var currentPro = getSelectVal('Protocol');
    
    if ("1" == GetCfgMode().TELMEX){
        setDisplay('sfamiliarAppIdDEFHIDERow',1);
        if((arguments.length > 0)&&(event_invoke)){
            IpFilterAppTempSelect();
        }
    }
    setDisplay('lanTcpPortIdRow',1);
	setDisplay('lanUdpPortIdRow',1);
    setDisplay('wanTcpPortIdRow',1);
	setDisplay('wanUdpPortIdRow',1);
    setDisable('lanUdpPortId',0);
    setDisable('wanUdpPortId',0);
    setDisable('lanTcpPortId',0);
    setDisable('wanTcpPortId',0);
    
    switch (currentPro)
    {
        case "ALL":
        case "ICMP":
            setDisplay('sfamiliarAppIdDEFHIDERow',0);
            setDisplay('lanTcpPortIdRow',0);
			setDisplay('lanUdpPortIdRow',0);
            setDisplay('wanTcpPortIdRow',0);
			setDisplay('wanUdpPortIdRow',0);
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

function GetFmiliarAppOptions()
{
    var appTempsLists = getElementById('sfamiliarAppIdDEFHIDE');
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
    for(var i = 0; i < apps.length; i += 2 )
    {
        appTempsLists.options.add(new Option(portmapping_language[apps[i+1]], apps[i]));
    }
    
}

function IsValidWan(wan) {
    if (wan.Mode =="IP_Routed") {
        return true;
    }

    return false;
}

function InitOption()
{
	var Directionlist = getElementById('Direction');

	Directionlist.options.length = 0;

	if(Mode == 2)
	{		
		Directionlist.options.add(new Option(ipincoming_language['Upstream'], 'Upstream'));
		Directionlist.options.add(new Option(ipincoming_language['Downstream'], 'Downstream'));
	}
	else
	{
		Directionlist.options.add(new Option(ipincoming_language['Bidirectional'], 'Bidirectional'));
		setDisable('Direction', 1);
		setDisplay('PriorityRow',0);
		setDisplay('ActionRow',0);
    }
	if ("1" == GetCfgMode().TELMEX)
	{	
	    setDisplay('DirectionRow',0);		
	}
	
    GetFmiliarAppOptions();

    if (CfgModeWord.toUpperCase() == "ROSUNION") {
		InitWanNameListControl1("WanNameList_DEFHIDE", IsValidWan);
		setDisplay('WanNameList_DEFHIDERow', 1);
	}
}
function IpFilterAppTempSelect()
{
    var currentAppTemp = getSelectVal('sfamiliarAppIdDEFHIDE');

    setText("lanTcpPortId","");
    setText("wanTcpPortId","");
    setText("lanUdpPortId","");
    setText("wanUdpPortId","");


    setText("wanTcpPortId",IpFilterAppTemps.GetTcpPortInfoByAppName(currentAppTemp).end);
    setText("wanUdpPortId",IpFilterAppTemps.GetUdpPortInfoByAppName(currentAppTemp).end);

    if(arguments.length > 0)
    {
        setSelect('Protocol',"TCP/UDP");
        protocalChange();
    }
    
    
}
function IpFilterShowInst()
{
    if((FltsecLevel != 'CUSTOM')
	    && (ignorefirewall == "0"))
	{
		FilterIn.length = 1;
	}
    if (FilterIn.length - 1 == 0)
    {
        document.write('<tr id="record_no" class="tabal_01 align_center" onclick="selectLine(this.id);">' +
                   '<td ' + bottomBorderClass(true) + '>--</td>' +
                   '<td ' + bottomBorderClass(true) + '>--</td>' +
                   '<td ' + bottomBorderClass(true) + '>--</td>' +
                   '<td ' + bottomBorderClass(true) + '>--</td>' +
                   '<td ' + bottomBorderClass(true) + '>--</td>');
        if (GetCfgMode().TELMEX != "1") {
            document.write('<td ' + bottomBorderClass(true) + '>--</td>');
        }

        if (Mode == 2) {
            document.write('<td >--</td>');
            document.write('<td >--</td>');
            if (isZqFeatureSupport == '1') {
                document.write('<td >--</td>');
            }
        }
        document.write('</tr>');
    }
    else
    {
        for (var i = 0; i < FilterIn.length - 1; i++)
        {
            var ruleName = FilterIn[i].name;
            if('' == ruleName){
                ruleName = "--"
            }
            
       		document.write('<tr id="record_' + i 
        	                + '"class="tabal_01 align_center"  onclick="selectLine(this.id);">'); 
			document.write('<td ' + bottomBorderClass(true) + '>' + '<input type="checkbox" id = \"rml'+i+'\" name="rml"'  + ' value="' 
							 + FilterIn[i].Domain  + '">' + '</td>');
			document.write('<td' + bottomBorderClass(true) + ' id="rulename_'+i+'" title="'+htmlencode(ruleName)+'">' + GetStringContent(htmlencode(ruleName),20) + '</td>');
			if (Mode == 2) {
				document.write('<td ' + bottomBorderClass(true) + '>' + FilterIn[i].Priority + '</td>');
			}

			if ((FilterIn[i].Protocol).toUpperCase() == "TCP/UDP") {
				document.write('<td ' + bottomBorderClass(true) + '>' + ipincoming_language['TCPUDP'] + '&nbsp;</td>'); 
			} else {
				document.write('<td ' + bottomBorderClass(true) + '>' + ipincoming_language[(FilterIn[i].Protocol).toUpperCase()] + '&nbsp;</td>'); 
			}
				
			if ( GetCfgMode().TELMEX != "1" ) {
				document.write('<td ' + bottomBorderClass(true) + '>' + ipincoming_language[FilterIn[i].Direction] + '&nbsp;</td>');
			}		 	
			if (FilterIn[i].SourceIPStart != '' && FilterIn[i].SourceIPEnd != '') {
				document.write('<td class="restrict_dir_ltr' + bottomBorderClass(false) + '">' + FilterIn[i].SourceIPStart + '-' + '<br/>' + FilterIn[i].SourceIPEnd + '&nbsp;</td>');
			} else if (FilterIn[i].SourceIPStart != '' && FilterIn[i].SourceIPEnd == '') {
				document.write('<td ' + bottomBorderClass(true) + '>' + FilterIn[i].SourceIPStart + '&nbsp;</td>');
			} else {
				document.write('<td ' + bottomBorderClass(true) + '>'  + '--' + '&nbsp;</td>');
			}

			if (FilterIn[i].DestIPStart != '' && FilterIn[i].DestIPEnd != '') {   
				document.write('<td class="restrict_dir_ltr' + bottomBorderClass(false) + '">' + FilterIn[i].DestIPStart + '-' + '<br/>'
							 + FilterIn[i].DestIPEnd + '&nbsp;</td>');
			} else if (FilterIn[i].DestIPStart != '' && FilterIn[i].DestIPEnd == '') {
				document.write('<td ' + bottomBorderClass(true) + '>' + FilterIn[i].DestIPStart + '&nbsp;</td>'); 
			} else {
				document.write('<td ' + bottomBorderClass(true) + '>' + '--' + '&nbsp;</td>');
			}

			if (Mode == 2) {
				if (CfgModeWord == "TRIPLETAP" || CfgModeWord == "TRIPLETAPNOGM" || CfgModeWord == "TRIPLETAP6" || CfgModeWord == "TRIPLETAP6PAIR") {
					if(FilterIn[i].Action == ipincoming_language['Accept']) {
						ipincoming_language[FilterIn[i].Action] = ipincoming_language['Allow'];
					  } else {
						ipincoming_language[FilterIn[i].Action] = ipincoming_language['Deny'];
					}
				}
				document.write('<td ' + bottomBorderClass(true) + '>' + ipincoming_language[FilterIn[i].Action] + '</td>');

                if (isZqFeatureSupport == '1') {
                    if (FilterIn[i].vlanId == '0') {
                        document.write('<td ' + bottomBorderClass(true) + '>' + '--' + '&nbsp;</td>');
                    } else {
                        document.write('<td ' + bottomBorderClass(true) + '>' + FilterIn[i].vlanId + '</td>');
                    }
                }
			}
			document.write('</tr>');
       } 	 
    }
}
function WriteFilterModeOption()
{
	var output = "";
	if (CfgModeWord == "TRIPLETAP" || CfgModeWord == "TRIPLETAPNOGM" || CfgModeWord == "TRIPLETAP6" || CfgModeWord == "TRIPLETAP6PAIR") {
		ipincoming_language['bbsp_hybridList'] = "ACLv4";
	}
	output = '<option value="0" id="FilterMode1">' + ipincoming_language['bbsp_blackList'] + '</option>';
	$("#FilterMode").append(output);
	
	output = '<option value="1" id="FilterMode2">' + ipincoming_language['bbsp_whiteList'] + '</option>';
	$("#FilterMode").append(output);
	if ("1" != GetCfgMode().TELMEX)
	{
		output = '<option value="2" id="FilterMode3" title="' + ipincoming_language['title3'] + '">' + ipincoming_language['bbsp_hybridList'] + '</option>';
		$("#FilterMode").append(output);
	}
}

function SetLanHostOptionInfoStart()
{
	var output = "";
	output = output + '<select class="restrict_dir_ltr" name=' + "'SHostName'" + ' id=' + "'SHostName'" + ' size="1" onChange=' + '"SHostNameChange(item)"' + ' style="width: 110px">';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = output + '<option value="' + i + '" id="' + htmlencode(LANhostName[i]) + '" title="'+ htmlencode(LANhostName[i])+'">' + GetStringContent(htmlencode(LANhostName[i]),30) + '</option>';			   
	} 
	output = output + '</select>';
	$("#SourceIPStart").after(output);
}	
function SetLanHostOptionInfoEnd()
{
	var output = "";
	output = output + '<select class="restrict_dir_ltr" name=' + "'EHostName'" + ' id=' + "'EHostName'" + ' size="1" onChange=' + '"EHostNameChange(item)"' + ' style="width: 110px">';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = output + '<option value="' + i + '" id="' + htmlencode(LANhostName[i]) + '" title="'+htmlencode(LANhostName[i])+'">' + GetStringContent(htmlencode(LANhostName[i]),30) + '</option>';			   
	} 
	output = output + '</select>'; 
	$("#SourceIPEnd").after(output);
}			


</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div id="ConfigForm1"style="display:inline"> 
<script language="JavaScript" type="text/javascript">
if (CfgModeWord == "TRIPLETAP" || CfgModeWord == "TRIPLETAPNOGM" || CfgModeWord == "TRIPLETAP6" || CfgModeWord == "TRIPLETAP6PAIR") {
    HWCreatePageHeadInfo("ipincoming", GetDescFormArrayById(ipincoming_language, "bbsp_mune_tripletap"), GetDescFormArrayById(ipincoming_language, "bbsp_ipincoming_title"), false);
} else if ((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) {
    HWCreatePageHeadInfo("ipincoming", GetDescFormArrayById(ipincoming_language, "bbsp_mune"), GetDescFormArrayById(ipincoming_language, "bbsp_ipincoming_title_cnt"), false);
} else if ((CfgModeWord == "SHCTA8C") || (CfgModeWord == "A8C")) {
        HWCreatePageHeadInfo("ipincoming", GetDescFormArrayById(ipincoming_language, "bbsp_mune"), GetDescFormArrayById(ipincoming_language, "bbsp_ipincoming_title2"), false);
} else {
        HWCreatePageHeadInfo("ipincoming", GetDescFormArrayById(ipincoming_language, "bbsp_mune"), GetDescFormArrayById(ipincoming_language, "bbsp_ipincoming_title"), false);
}


if (IsNeedAddSafeDesForBelTelecom() == true) {
	document.getElementById("ipincoming_content").innerHTML = ipincoming_language['bbsp_ipincoming_title'] + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>";
}
if ((CfgModeWord.toUpperCase() == "ROSUNION") && (Mode == 2)) {
    document.getElementById("ipincoming_content").innerHTML = ipincoming_language['bbsp_ipincoming_title'] + "<br>" + ipincoming_language['bbsp_ipincoming_title2'];
}
</script>

<div class="title_spread"></div>
<form id="ipIncomingFltForm" name="ipIncomingFltForm">
<table id="ipIncomingFltFormPanel" cellspacing="1" cellpadding="0" width="100%">
<li id="EnableIpFilter" RealType="CheckBox" DescRef="bbsp_enable" RemarkRef="tip_perfence" ErrorMsgRef="Empty" Require="FALSE" BindField="EnableIpFilter" InitValue="Empty" ClickFuncApp="onclick=SubmitForm"/>
<li id="FilterMode" RealType="DropDownList" DescRef="bbsp_filtermodemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FilterMode" InitValue="Empty" ClickFuncApp="onchange=ChangeMode" />
</table>
<script>
var TableClass = new stTableClass("table_title width_per20 align_left", "table_right align_left");
	var ipIncomingFltFormList = new Array();
	ipIncomingFltFormList = HWGetLiIdListByForm("ipIncomingFltForm",null);
	HWParsePageControlByID("ipIncomingFltForm",TableClass,ipincoming_language,null);
	WriteFilterModeOption();
</script>
<script> document.getElementById("EnableIpFilterspan").innerHTML = "(" + ipincoming_language['tip_perfence'] + ")";</script>
<script> 
if (CfgModeWord == "TRIPLETAP" || CfgModeWord == "TRIPLETAPNOGM" || CfgModeWord == "TRIPLETAP6" || CfgModeWord == "TRIPLETAP6PAIR") {
    document.getElementById("EnableIpFilterColleft").innerHTML = "Enable IP Filter & ACLv4:"
} else {
    document.getElementById("EnableIpFilterColleft").innerHTML = ipincoming_language['bbsp_enable']+ (("1" == "<% HW_WEB_GetFeatureSupport(BBSP_FT_CTC);%>" )?(ipincoming_language['bbsp_e8cport']):(ipincoming_language['bbsp_comip'])) + ipincoming_language['bbsp_filtermh'];
}
</script>
<script LANGUAGE="JavaScript">  
	if ("1" == GetCfgMode().TELMEX)
	{
		getElById("FilterModeRow").title = ipincoming_language['title4'];
	}
	else
	{
		getElById("FilterModeRow").title = ipincoming_language['title'];
	}
	getElById("FilterMode1").title = ipincoming_language['title1'];
	getElById("FilterMode2").title = ipincoming_language['title2'];
		</script>
</form>
<div class="func_spread"></div>

<script language="JavaScript" type="text/javascript">
    if (ignorefirewall == "0")
    {
        ((FltsecLevel == 'CUSTOM') ? writeTabCfgHeader : writeTabInfoHeader)('IP Incoming Filter',"100%","140");
    }
	else
	{
	    writeTabCfgHeader('IP Incoming Filter',"100%","140");
	}

</script>

  <table class="tabal_bg" id="ipfilter" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr class=" head_title">
	  <script>
        document.write('<td ' + bottomBorderClass(true) + '>&nbsp;</td>' +
                       "<td BindText='tip_rule_name2'" + bottomBorderClass(true) + "></td>");
	  </script>
	  <script>
	  if(Mode == 2)
	  	document.write("<td  BindText='bbsp_priority'></td>");
      </script>
	
     <script>
        document.write("<td  BindText='bbsp_protocol'" + bottomBorderClass(true) + "></td>");
      </script>
      <script>
        document.write("<td  BindText='bbsp_direction' " + bottomBorderClass(true) + "></td>" +
                       "<td  BindText='bbsp_lanip' " + bottomBorderClass(true) + "></td>" +
                       "<td  BindText='bbsp_wanip' " + bottomBorderClass(true) + "></td> ");
      </script>

    <script>
        if (Mode == 2) {
            document.write("<td BindText='bbsp_action'></td>");
            if (isZqFeatureSupport == '1') {
                document.write("<td BindText='bbsp_header_vlan_id'></td>");
            }
        }
    </script>
    </tr> 
    <script language="JavaScript" type="text/javascript">
	    IpFilterShowInst();
        replaceSelectLineFun();
    </script>
  </table>

<div id="ConfigForm" style="display:none">
<div class="list_table_spread"></div>
<form id="ConfigurationForm" name="ConfigurationForm">
<table id="ConfigurationFormPanel" cellpadding="2" cellspacing="0" width="100%">
<li id="RuleNameId" RealType="TextBox" DescRef="tip_rule_name" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RuleNameId" Elementclass="InputRuleName" MaxLength="32" InitValue="Empty" />
<li id="Protocol" RealType="DropDownList" DescRef="bbsp_protocolmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Protocol" Elementclass="SelectDdns" InitValue="[{TextRef:'ALL',Value:'ALL'},{TextRef:'TCPUDP',Value:'TCP/UDP'},{TextRef:'TCP',Value:'TCP'},{TextRef:'UDP',Value:'UDP'},{TextRef:'ICMP',Value:'ICMP'}]" ClickFuncApp="onchange=protocalChange" />
<li id="sfamiliarAppIdDEFHIDE" RealType="DropDownList" DescRef="tip_familiar_app" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="sfamiliarAppIdDEFHIDE" Elementclass="SelectDdns" InitValue="Empty" ClickFuncApp="onchange=IpFilterAppTempSelect"/>
<li id="Priority" RealType="TextBox" DescRef="bbsp_prioritymh" RemarkRef="prioritytip" ErrorMsgRef="Empty" Require="TRUE" BindField="Priority" Elementclass="InputDdns" MaxLength="6" InitValue="Empty" />
<li id="Direction" RealType="DropDownList" DescRef="bbsp_directionmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Direction" Elementclass="SelectDdns" InitValue="Empty" ClickFuncApp="onchange=handleDirectionChange" />
<li id="VlanId" RealType="TextBox" DescRef="bbsp_desc_vlan_id" RemarkRef="bbsp_remark_vlan_id" ErrorMsgRef="Empty" Require="FALSE" BindField="VlanId" Elementclass="InputDdns" MaxLength="4" InitValue="Empty" />
<li id="SourceIPStart" RealType="TextOtherBox" DescRef="bbsp_lanstartaddraddcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SourceIPStart" MaxLength="15" InitValue="Empty"/>
<li id="SourceIPEnd" RealType="TextOtherBox" DescRef="bbsp_lanendaddraddcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SourceIPEnd" MaxLength="15" InitValue="Empty"/>
<li id="DestIPStart" RealType="TextOtherBox" DescRef="bbsp_wanipmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DestIPStart" MaxLength="15" 
InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'DestIPStartBias'},{AttrName:'innerhtml', AttrValue:'bbsp_dash'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'DestIPEnd'},{AttrName:'MaxLength', AttrValue:'15'}]}]"/>

<li id="lanTcpPortId" RealType="TextBox" DescRef="port_lan_tcp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="lanTcpPortId" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
<li id="lanUdpPortId" RealType="TextBox" DescRef="port_lan_udp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="lanUdpPortId" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
<li id="wanTcpPortId" RealType="TextBox" DescRef="port_wan_tcp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="wanTcpPortId" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
<li id="wanUdpPortId" RealType="TextBox" DescRef="port_wan_udp_addcolon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="wanUdpPortId" Elementclass="InputDdns" MaxLength="90" InitValue="Empty" />
<script>
if (CfgModeWord == "TRIPLETAP" || CfgModeWord == "TRIPLETAPNOGM" || CfgModeWord == "TRIPLETAP6" || CfgModeWord == "TRIPLETAP6PAIR") {
	document.write("<li id=\"Action\" RealType=\"DropDownList\" DescRef=\"bbsp_actionmh\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Action\" Elementclass=\"SelectDdns\" InitValue=\"[{TextRef:'Allow',Value:'Accept'},{TextRef:'Deny',Value:'Drop'}]\" />");
} else {
	document.write("<li id=\"Action\" RealType=\"DropDownList\" DescRef=\"bbsp_actionmh\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Action\" Elementclass=\"SelectDdns\" InitValue=\"[{TextRef:'Accept',Value:'Accept'},{TextRef:'Drop',Value:'Drop'}]\" />");
}
if (CfgModeWord.toUpperCase() == "ROSUNION") {
    document.write("<li id=\"WanNameList_DEFHIDE\" RealType=\"DropDownList\" DescRef=\"bbsp_wannamemh\" RemarkRef=\"Empty\" ErrorMsgRef=\"\" Require=\"FALSE\" BindField=\"x.WanName\" Elementclass=\"SelectDdns\" InitValue=\"Empty\" />");
}
</script>
</table>
<script>
var TableClassTwo = new stTableClass("table_title width_per25", "table_right width_per80","ltr");
var ConfigurationFormList = new Array();
	ConfigurationFormList = HWGetLiIdListByForm("ConfigurationForm",null);
	HWParsePageControlByID("ConfigurationForm",TableClassTwo,ipincoming_language,null);
</script>	 
  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
<tr>
<td class='width_per20'></td>
<td class="table_submit">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<input class="ApplyButtoncss buttonwidth_100px" name="btnApply_ex" id= "btnApply_ex" type="button" BindText="bbsp_app" onClick="SubmitEx();">
<input class="CancleButtonCss buttonwidth_100px" name="cancelButton" id="cancelButton" type="button" BindText="bbsp_cancel" onClick="CancelValue();"></td>
</tr>
</table>
</form>
<div style="height:10px;"></div>
  <script language="JavaScript" type="text/javascript">
    writeTabTail();
	GetLanUserDevInfo(function(para)
	{
		SetLanHostNameIp(para);
		SetLanHostOptionInfoStart();
		SetLanHostOptionInfoEnd();
		setSelectSHostName();
		setSelectEHostName();
		setSelectHostName();
        initSelectHostNameARCLARO("grey");  
	});
	ParseBindTextByTagName(ipincoming_language, "input", 2);

  </script>
</div>
</div>
</body>
</html>
