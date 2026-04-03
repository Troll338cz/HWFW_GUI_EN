<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, status_ethinfo_language);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/lanuserinfo.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>

<title>Eth Port Information</title>
<script language="JavaScript" type="text/javascript">

var isOpticUpMode = '<%HW_WEB_IsOpticUpMode();%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var upMode = '<%HW_WEB_GetUpMode();%>';
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';

var P2pFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_P2P);%>';

var NatieFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DRV_NATIE_LAN_TO_WAN);%>';

var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';

var BjcuFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_BJCU);%>';

var AisApRtFlag = '<%HW_WEB_GetFeatureSupport(AMP_FT_AISAP);%>';

var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";

var IsSupportLanAsWan = '<%HW_WEB_GetFeatureSupport(FT_LAN_AS_WAN);%>';

var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var isPfFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_ETH_PF);%>';

var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var ethTypes = '<%GetEthServiceTypes();%>';
if (ethTypes !== '') {
  ethTypes = JSON.parse(ethTypes);
}
var acEthType = '<%HW_WEB_GetEthTypeList();%>'; 
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var intMax = 4294967296;

function stConfigPort(domain,X_HW_MainUpPort, typpon, X_HW_UpPortID)
{
    this.domain = domain;
    this.X_HW_MainUpPort = X_HW_MainUpPort;
    this.typpon = typpon;
    this.X_HW_UpPortID = X_HW_UpPortID;
}

var PortConfigInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,X_HW_MainUpPort|typpon|X_HW_UpPortID,stConfigPort);%>;
var PortConfigInfo = PortConfigInfos[0];
var MainUpPort = PortConfigInfo.X_HW_MainUpPort;
var tureUpPortMode = PortConfigInfo.typpon;
var tureUpPortId = PortConfigInfo.X_HW_UpPortID;

function GetIPTVWANInfo()
{
	if (supportIPTVPort != 1)
	{
		return 0;
	}

	var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
	if (IPTVUpPortInfo == "")
	{
		return 0;
	}
	
	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
	var tempIPTVUpList = tempIPTVUpValue.split(".");
	return tempIPTVUpList[0].substr(3);
}

function LoadFrame() 
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}

		b.innerHTML = status_ethinfo_language[b.getAttribute("BindText")];
	}

    if((TelMexFlag == '1') || (BjcuFlag == '1'))
    {
        setDisplay("divDhcpInfo",1);
    }

    if (1 == TelMexFlag)
	{
		setDisplay("divVlanMacInfo",1);
    }
    // 1056769-上行PON口ID
    if (tureUpPortMode == 'ETHERNET' && tureUpPortId == '1056769' && isBponFlag == 1) {
        setDisplay("GeOpticInfo",1);
    }

    if (('1' == P2pFlag) && ('0' == isOpticUpMode) && (6 == geInfos.length))
    {
        getElById('ExtId').className = "gray";
        getElById('ModeId').className = "gray"; getElById('ModeId').innerHTML = "-";
        getElById('SpeedId').className = "gray"; getElById('SpeedId').innerHTML = "-";
        getElById('StatusId').className = "gray"; getElById('StatusId').innerHTML = "-";
        getElById('RxBId').className = "gray"; getElById('RxBId').innerHTML = "-";
        getElById('RxFId').className = "gray"; getElById('RxFId').innerHTML = "-";
        if (1 == TelMexFlag)
        {
            getElById('RxEId').className = "gray"; getElById('RxEId').innerHTML = "-";
            getElById('RxDId').className = "gray"; getElById('RxDId').innerHTML = "-";
        }
        getElById('TxBId').className = "gray"; getElById('TxBId').innerHTML = "-";
        getElById('TxFId').className = "gray"; getElById('TxFId').innerHTML = "-";
        if (1 == TelMexFlag)
        {
            getElById('TxEId').className = "gray"; getElById('TxEId').innerHTML = "-";
            getElById('TxDId').className = "gray"; getElById('TxDId').innerHTML = "-";
        }
    }

    if ((CfgMode.toUpperCase() == "ROSUNION") && (curUserType == sysUserType)) {
        document.getElementById('ClearEthinfo_table').style.marginBottom  = '5px';
    }

	DisplayWanStatistics();
	
	if (IsSupportLanAsWan == 1) {
		setDisplay("extethinfo", 0);
	}
}

function LANStats(domain,txPackets,txPackets_H,txGoodBytes,txGoodBytes_H,txBadBytes,txBadBytes_H,rxPackets,rxPackets_H,rxGoodBytes,rxGoodBytes_H,rxBadBytes,rxBadBytes_H)
{  
    this.domain   = domain;
    this.txPackets = parseInt(txPackets_H)*intMax + parseInt(txPackets);
    this.txBytes  = parseInt(txGoodBytes_H)*intMax + parseInt(txGoodBytes) + parseInt(txBadBytes) + parseInt(txBadBytes_H)*intMax;
    this.rxPackets = parseInt(rxPackets_H)*intMax + parseInt(rxPackets);
    this.rxBytes  = parseInt(rxGoodBytes_H)*intMax + parseInt(rxGoodBytes) + parseInt(rxBadBytes) + parseInt(rxBadBytes_H)*intMax;
}

function PONStats(domain, TxPackets, TxOmci, TxDrop, BipErr, RxPackets, RxOmci, RxDrop)
{  
    this.domain   = domain;
    this.TxPackets = parseInt(TxPackets);
    this.TxOmci  = parseInt(TxOmci);
    this.RxPackets = parseInt(RxPackets);
    this.RxOmci  = parseInt(RxOmci);
}

function GEMStats(domain, gemId, tcontId, txPackets, txPackets_H, txBytes, txBytes_H, rxPackets, rxPackets_H, rxBytes, rxBytes_H, discard, direction, type)
{  
    this.domain = domain;
    this.gemId = parseInt(gemId);
	this.tcontId = parseInt(tcontId);
	this.txPackets = parseInt(txPackets_H)*intMax + parseInt(txPackets);
    this.txBytes = parseInt(txBytes_H)*intMax + parseInt(txBytes);
    this.rxPackets = parseInt(rxPackets_H)*intMax + parseInt(rxPackets);
	this.rxBytes = parseInt(rxBytes_H)*intMax + parseInt(rxBytes);
	this.discard = discard;
    this.direction = direction;
    this.type = type;
}

function tcontAllocid(domain, id)
{  
    this.domain = domain;
    this.id = parseInt(id);
}

var tcontAllocids = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.OmciMibShowAllocId.{i}.allocid, id, tcontAllocid);%>;
var userPonInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.Pon.GetPonStats, TxPackets|TxOmci|TxDrop|BipErr|RxPackets|RxOmci|RxDrop, PONStats);%>;
var gemportInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.Gemport.GemInfo.{i}.Stats, gemId|tcontId|txPackets|txPackets_H|txBytes|txBytes_H|rxPackets|rxPackets_H|rxBytes|rxBytes_H|discard|direction|type, GEMStats);%>;

var userEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.Statistics,SendFrame|SendFrame_H|SendGoodPktOcts|SendGoodPktOcts_H|SendBadPktOcts|SendBadPktOcts_H|RcvFrame|RcvFrame_H|RcvGoodPktOcts|RcvGoodPktOcts_H|RcvBadPktOcts|RcvBadPktOcts_H,LANStats);%>;

function IncorrectStats(domain, RcvFrame_Undersize, RcvTooLong, RcvFragmentFrame, RcvJabbersFrame, RcvFcsErrFrame, RcvAlignErrFrame, MacRxErrFrame, CarrierSenseErrCnt,ExcessCollisionFrame, MacSendErrFrame)
{  
    var delta = 0;
    if ( (parseInt(RcvTooLong) >= parseInt(RcvJabbersFrame)) && (parseInt(RcvFcsErrFrame) >= parseInt(RcvJabbersFrame)) )
    {
    	delta = parseInt(RcvTooLong) + parseInt(RcvFcsErrFrame) - parseInt(RcvJabbersFrame);
    }
    else
    {
    	delta = parseInt(RcvTooLong) + parseInt(RcvFcsErrFrame);
    }

    this.domain   			= domain;

    this.rxDiscardPackets 	=   parseInt(RcvFrame_Undersize)     						 
    						  + parseInt(RcvAlignErrFrame) 
    						  + parseInt(MacRxErrFrame)
    						  + delta;

    this.txDiscardPackets 	=   parseInt(CarrierSenseErrCnt)
    						  + parseInt(ExcessCollisionFrame)
    						  + parseInt(MacSendErrFrame);

    this.rxErrorPackets 	=   parseInt(RcvFrame_Undersize)     						
    						  + parseInt(MacRxErrFrame)
    						  + delta;

    this.txErrorPackets 	= 0; 
}

var incorrectPortStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.Statistics, RcvFrame_Undersize|RcvTooLong|RcvFragmentFrame|RcvJabbersFrame|RcvFcsErrFrame|RcvAlignErrFrame|MacRxErrFrame|CarrierSenseErrCnt|ExcessCollisionFrame|MacSendErrFrame, IncorrectStats);%>;

function clearStatistic() {
	var Form = new webSubmitForm();
	
	Form.addParameter('x.RcvFrame', 255);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	url= userEthInfos[0].domain;
	Form.setAction('set.cgi?x='+url+'&RequestFile=html/amp/ethinfo/ethinfo.asp');
	Form.submit();
}

function GEInfo(domain,Mode,Speed,Status)
{
    this.domain		= domain;
	this.Mode 		= Mode;
	this.Speed 		= Speed;
	this.Status 	= Status;

	if(Status==1)
	{
		if(Mode==0)this.Mode = status_ethinfo_language['amp_port_halfduplex'];
		if(Mode==1)this.Mode = status_ethinfo_language['amp_port_fullduplex'];

		if(Speed==0)this.Speed = status_ethinfo_language['amp_port_10M'];
		if(Speed==1)this.Speed = status_ethinfo_language['amp_port_100M'];
		if(Speed==2)this.Speed = status_ethinfo_language['amp_port_1000M'];
		if(Speed==3)this.Speed = status_ethinfo_language['amp_port_2500M'];
		if(Speed==4)this.Speed = status_ethinfo_language['amp_port_10000M'];
		if(Speed==6)this.Speed = status_ethinfo_language['amp_port_5000M'];
		

		this.Status = status_ethinfo_language['amp_port_linkup'];
	}
	else
	{
		this.Mode = "--";
		this.Speed = "--";
		this.Status = status_ethinfo_language['amp_port_linkdown'];
	}
}

var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Duplex|Speed|Link,GEInfo);%>;

var lanMac = "--:--:--:--:--:--";
function DeviceLanMAC(domain,LanMac,WLanMac)
{
	this.domain 	= domain;
	this.LanMac   = LanMac;
	this.WLANMac	= WLanMac;
}

var DeviceLanMACs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,X_HW_LanMac|X_HW_WlanMac,DeviceLanMAC);%>;

lanMac = DeviceLanMACs[0].LanMac;

var WanEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.3.WANEthernetInterfaceConfig, X_HW_DuplexMode|X_HW_Speed|Status, WanEthInfo);%>;

function WanEthInfo(domain,Mode,Speed,Status)
{
	this.domain	= domain;
	this.Mode 	= Mode;
	this.Speed 	= Speed;
    this.Status = Status;

    if(Status == "Up")
    {
        if((Mode == "Auto_Half") || (Mode == "Half"))this.Mode = status_ethinfo_language['amp_port_halfduplex'];
        if((Mode == "Auto_Full") || (Mode == "Full"))this.Mode = status_ethinfo_language['amp_port_fullduplex'];
        if(Mode == "")this.Mode = status_ethinfo_language['amp_port_halfduplex'];
    
        if((Speed == "Auto_10") || (Speed == "10"))this.Speed = status_ethinfo_language['amp_port_10M'];
        if((Speed == "Auto_100") || (Speed == "100"))this.Speed = status_ethinfo_language['amp_port_100M'];
        if((Speed == "Auto_1000") || (Speed == "1000"))this.Speed = status_ethinfo_language['amp_port_1000M'];
		if((Speed == "Auto_10000") || (Speed == "10000"))this.Speed = status_ethinfo_language['amp_port_10000M'];
        if(Speed == "")this.Speed = status_ethinfo_language['amp_port_10M'];
    
        this.Status = status_ethinfo_language['amp_port_linkup'];
    }
    else
    {
        this.Mode = "--";
		this.Speed = "--";
    
        this.Status = status_ethinfo_language['amp_port_linkdown'];
    }
}

var WanEthStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.3.WANEthernetInterfaceConfig.Stats, BytesReceived|PacketsReceived|BytesSent|PacketsSent, WanEthStats);%>;

function WanEthStats(domain, BytesReceived, PacketsReceived, BytesSent, PacketsSent)
{  
	this.domain             = domain;
	this.BytesReceived 	    = BytesReceived;
	this.PacketsReceived    = PacketsReceived;
	this.BytesSent  	= BytesSent;
	this.PacketsSent 	= PacketsSent;     
}

function DisplayWanStatistics()
{
	if ((curChangeMode > 0) || (ProductType != '1')) 
	{
		setDisplay("wanstatistics",0);
    }

    if ((AisApRtFlag == '1') && (upMode == '3') && (WanEthInfos[0] != null)) 
    {
        setDisplay("wanstatistics",1);
    }
}

function leftCountWithStyle(count)
{
    if (rosunionGame == "1") {
        return ' style = "padding: 3px 0px;text-align: center;border-bottom: 1px solid #6d6060;position: relative;left: -' + count + 'px;"';
    } else {
        return '';
    }
}
</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">

<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("amp_ethinfo_desc", 
	GetDescFormArrayById(status_ethinfo_language, "amp_ethinfo_desc_head"), 
	GetDescFormArrayById(status_ethinfo_language, "amp_ethinfo_desc"), false);
</script>

<div class="title_spread"></div>

<div id="GeOpticInfo" style="display:none">
    <div class="func_title"><SCRIPT>document.write(status_ethinfo_language["amp_upport_info"]);</SCRIPT></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr class="head_title" id="dhcpinfotitle">
            <td BindText='amp_ethinfo_portnum'></td>
            <td BindText='amp_ethinfo_duplex'></td>
            <td BindText='amp_ethinfo_speed'></td>
            <td BindText='amp_ethinfo_link'></td>
        </tr>
        <script type="text/javascript" language="javascript">
            if (tureUpPortMode == 'ETHERNET' && tureUpPortId == '1056769' && isBponFlag == 1) {
                var upEthInfos = "";
                $.ajax({
                    type : "POST",
                    async : false,
                    cache : false,
                    url : "./getUpEthInfo.asp",
                    success : function(data) {
                        upEthInfos = dealDataWithStr(data);
                    }
                });
                var mode = "--";
                var speed = "--";
                var status = status_ethinfo_language['amp_port_linkdown'];
                if (undefined != upEthInfos && "" != upEthInfos) {
                    var upEthInfo = upEthInfos[upEthInfos.length - 1];
                    if (upEthInfo.link==1) {
                        if(upEthInfo.duplex == 0) {
                            mode = status_ethinfo_language['amp_port_halfduplex'];
                        } else if (upEthInfo.duplex == 1){
                            mode = status_ethinfo_language['amp_port_fullduplex'];
                        }

                        if (upEthInfo.speed == 0) {
                            speed = status_ethinfo_language['amp_port_10M'];
                        } else if (upEthInfo.speed == 1) {
                            speed = status_ethinfo_language['amp_port_100M'];
                        } else if (upEthInfo.speed == 2) {
                            speed = status_ethinfo_language['amp_port_1000M'];
                        } else if (upEthInfo.speed == 3) {
                            speed = status_ethinfo_language['amp_port_2500M'];
                        } else if (upEthInfo.speed == 4) {
                            speed = status_ethinfo_language['amp_port_10000M'];
                        } else if (upEthInfo.speed == 6) {
                            speed = status_ethinfo_language['amp_port_5000M'];
                        }

                        status = status_ethinfo_language['amp_port_linkup'];
                    }
                }
                
                document.write("<tr class=\"tabal_01\">");
                document.write('<td class=\"align_center\">'+ "GE0" +'</td>');
                document.write('<td class=\"align_center\">'+ mode +'</td>');
                document.write('<td class=\"align_center\">'+ speed +'</td>');
                document.write('<td class=\"align_center\">'+ status +'</td>');
                document.write("</tr>");
            }
        </script>
    </table>
    <div class="func_spread"></div>
</div>

<div id="divVlanMacInfo" style="display:none">

<div class="func_title"><SCRIPT>document.write(status_ethinfo_language["amp_lanmacinfo_title"]);</SCRIPT></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<tr>
	<td width="25%"  class="table_title" style="color: #000000;" BindText='amp_lanmac'></td>
	<td class="table_right" style="color: #000000;">
		<script language="JavaScript" type="text/javascript">
		document.write(lanMac);
		</script>
	</td> 
</tr>
</table>

<div class="func_spread"></div>

</div>

<div id="divDhcpInfo" style="display:none">

<div class="func_title"><SCRIPT>document.write(status_ethinfo_language["amp_dhcpinfo_title"]);</SCRIPT></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
	<tr class="head_title" id="dhcpinfotitle">
	    <td BindText='amp_dhcpinfo_ipadd'></td>
	    <td BindText='amp_dhcpinfo_macadd'></td>
	    <td BindText='amp_dhcpinfo_dev'></td>
	</tr>
	<script type="text/javascript" language="javascript">
	function appendstr(str)
	{
		return str;
	}
	function createdhcptable(dhcpInfos)
	{
	    var dhcpNum = dhcpInfos.length - 1;
		var Count = 0;
		var output = "";
		for(i=0;i< dhcpNum ;i++)
		{
			if (0 == dhcpInfos[i].remaintime)
	        {  
	  			continue;
	        }
	              
	        Count++;		

	        if(Count%2 == 0)
	 		{
	 		    output = output + appendstr("<tr class=\"tabal_01\">");
	 		}
	 		else
	 		{
	 		    output = output + appendstr("<tr class=\"tabal_02\">");
	 		}

			output = output + appendstr('<td class=\"align_center\">'+dhcpInfos[i].ip	+'</td>');
			output = output + appendstr('<td class=\"align_center\">'+dhcpInfos[i].mac	+'</td>');
			output = output + appendstr('<td class=\"align_center\">'+htmlencode(dhcpInfos[i].devtype)	+'</td>');

			output = output + appendstr("</tr>");
		}

		if(( 0 == dhcpNum ) || (Count == 0) )
		{
			output = output + appendstr("<tr class=\"tabal_01\">");
			output = output + appendstr('<td class=\"align_center\">'+'--'	+'</td>');
			output = output + appendstr('<td class=\"align_center\">'+'--'	+'</td>');
			output = output + appendstr('<td class=\"align_center\">'+'--'	+'</td>');
			output = output + appendstr("</tr>");
		}

		$("#dhcpinfotitle").after(output);
	}
	

    if ((TelMexFlag == '1') || (BjcuFlag == '1')) {
        GetLanUserDhcpInfo(function(para) {
            createdhcptable(para);	
        });
    }
	</script>
</table>

<div class="func_spread"></div>

</div>

<div style="overflow:auto;overflow-y:hidden"> 

<table id="ClearEthinfo_table" width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
    <input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
    <tr>
        <td class="width_per100" BindText="amp_ethinfo_title"></td>
        <script>
            if ((CfgMode.toUpperCase() == "ROSUNION") && (curUserType == sysUserType)) {
                document.write(
                    '<td >' +
                        '<button onclick="clearStatistic()" style="width: 110px;height: 25px;cursor: pointer;margin-right: 1px;">' +
                            status_ethinfo_language['amp_ethinfo_clear'] +'</button>' + 
                    '</td>'
                );
            }
        </script>
    </tr>
</table>

<table id="eth_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr class="head_title">
        <script type="text/javascript" language="javascript">
            var count = 0;
            document.write('<td colspan="1" rowspan="2" BindText="amp_ethinfo_portnum" '+ leftCountWithStyle(count++) + '></td>' +
                           '<td colspan="3" BindText="amp_ethinfo_portstatus" '+ leftCountWithStyle(count++) + '></td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                document.write('<td colspan="4">' + status_ethinfo_language['amp_ethinfo_rx'] + '</td>');
                document.write('<td colspan="4">' + status_ethinfo_language['amp_ethinfo_tx'] + '</td>');
            } else {
                document.write('<td colspan="2" ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_ethinfo_rx'] + '</td>');
                document.write('<td colspan="2" ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_ethinfo_tx'] + '</td>');
            }
        </script>
    </tr>

    <tr class="head_title">
        <script type="text/javascript" language="javascript">
            var count = 0;
            document.write('<td BindText="amp_ethinfo_duplex" ' + leftCountWithStyle(count++) + '></td>' +
                           '<td BindText="amp_ethinfo_speed" ' + leftCountWithStyle(count++) + '></td>' +
                           '<td BindText="amp_ethinfo_link" ' + leftCountWithStyle(count++) + '></td>');

            document.write('<td ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_ethinfo_bytes'] + '</td>');        
            document.write('<td ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_ethinfo_pkts'] + '</td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                 document.write('<td>' + status_ethinfo_language['amp_ethstat_err'] + '</td>');
                 document.write('<td>' + status_ethinfo_language['amp_ethstat_drop'] + '</td>');
            }

            document.write('<td ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_ethinfo_bytes'] + '</td>');        
            document.write('<td ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_ethinfo_pkts'] + '</td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                document.write('<td>' + status_ethinfo_language['amp_ethstat_err'] + '</td>');
                document.write('<td>' + status_ethinfo_language['amp_ethstat_drop'] + '</td>');
            }
        </script>
    </tr>

    <script type="text/javascript" language="javascript">
        var count;
        if ((userEthInfos.length == 1) || (userEthInfos == null)) {
            count = 0;
            document.write("<tr class=\"tabal_01\">");
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                document.write('<td>' + '&nbsp ' + '</td>');
                document.write('<td>' + '&nbsp ' + '</td>');
            }

            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + '&nbsp ' + '</td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                document.write('<td>' + '&nbsp ' + '</td>');
                document.write('<td>' + '&nbsp ' + '</td>');
            }

		document.write("</tr>");
	}

        var lanid;
        var ethNum = parseInt(acEthType.charAt(0), 10);
        for (i = 0; i < userEthInfos.length - 1; i++) {
            lanid = i + 1;
            count = 0;

            if ((typeof ethTypes != "undefined") && (ethTypes[i] == 2)) {
                continue;
            }

            if ((P2pFlag == '1') && (lanid >= userEthInfos.length - 1) && (userEthInfos.length != 5)) {
                if (AisApRtFlag != '1') {
                    break;
                } else if (upMode == '3') {
                    break;
                }
            }

            if ((P2pFlag == '1') && (lanid == UpUserPortID)) {
                break;
            }

            if ((NatieFlag == '1') && (lanid == UpUserPortID)) {
                continue;
            }

            if (i%2 == 0) {
                document.write("<tr class=\"tabal_01\">");
            } else {
                document.write("<tr class=\"tabal_02\">");
            }

            if (((IsSupportLanAsWan == 1) && (upMode == '3')) && (lanid == UpUserPortID)) {
                document.write('<td>'+  status_ethinfo_language['amp_port_wan']	+'</td>');
                document.write('<td>'+ WanEthInfos[0].Mode	+'</td>');
                document.write('<td>'+ WanEthInfos[0].Speed	+'</td>');
                document.write('<td>'+ WanEthInfos[0].Status	+'</td>');
                document.write('<td>'+WanEthStats[0].BytesReceived	+'</td>');
                document.write('<td>'+WanEthStats[0].PacketsReceived	+'</td>');
                document.write('<td>'+WanEthStats[0].BytesSent	+'</td>');
                document.write('<td>'+WanEthStats[0].PacketsSent	+'</td>');
                document.write("</tr>");
                continue;
            }

            if (stbport == lanid) {
                document.write('<td ' + leftCountWithStyle(count++) + '>' + status_ethinfo_language['amp_port_inner_stb'] + '</td>');
            } else {
                var tempIPTVWANID = GetIPTVWANInfo();
                if (tempIPTVWANID == lanid) {
                    document.write('<td ' + leftCountWithStyle(count++) + '>IPTV WAN</td>');
                } else {
                    document.write('<td ' + leftCountWithStyle(count++) + '>' + lanid + '</td>');
                }
            }

            document.write('<td ' + leftCountWithStyle(count++) + '>' + geInfos[i].Mode + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + geInfos[i].Speed + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + geInfos[i].Status + '</td>');

            document.write('<td ' + leftCountWithStyle(count++) + '>' + userEthInfos[i].rxBytes + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + userEthInfos[i].rxPackets + '</td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                document.write('<td>'+ incorrectPortStats[i].rxErrorPackets	+'</td>');
                document.write('<td>'+ incorrectPortStats[i].rxDiscardPackets +'</td>');
            }

            document.write('<td ' + leftCountWithStyle(count++) + '>' + userEthInfos[i].txBytes + '</td>');
            document.write('<td ' + leftCountWithStyle(count++) + '>' + userEthInfos[i].txPackets + '</td>');

            if ((TelMexFlag == 1) || (CfgMode.toUpperCase() == 'OI2')) {
                document.write('<td>'+ incorrectPortStats[i].txErrorPackets	+'</td>');
                document.write('<td>'+ incorrectPortStats[i].txDiscardPackets +'</td>');
            }

            document.write("</tr>");

            if (isPfFlag == 1 && isBponFlag == 1) {
                break; // BPON S1016需求只保留一个Lan口
            }
        }

	if (('3' == upMode && PonUpportConfig != 1) || '1' == P2pFlag)
	{
		if (UpUserPortID < geInfos.length)
		{
			var uiExtEthId = UpUserPortID - 1;
					
			document.write("<tr class=\"tabal_01\" id=\"extethinfo\">");	
			if (ProductType == 2)
			{
				document.write('<td id="ExtId">' + status_ethinfo_language['amp_port_wan'] +'</td>');
			}
			else
			{
				document.write('<td id="ExtId">' + status_ethinfo_language['amp_port_ext1'] +'</td>');
			}
			document.write('<td id="ModeId">'+ geInfos[uiExtEthId].Mode	+'</td>');
			document.write('<td id="SpeedId">'+ geInfos[uiExtEthId].Speed	+'</td>');
			document.write('<td id="StatusId">'+ geInfos[uiExtEthId].Status	+'</td>');
			document.write('<td id="RxBId">'+ userEthInfos[uiExtEthId].rxBytes	+'</td>');
			document.write('<td id="RxFId">'+ userEthInfos[uiExtEthId].rxPackets	+'</td>');

			if (1 == TelMexFlag)
			{
				document.write('<td id="RxEId">'+ incorrectPortStats[uiExtEthId].rxErrorPackets	+'</td>');
				document.write('<td id="RxDId">'+ incorrectPortStats[uiExtEthId].rxDiscardPackets +'</td>');
			}

			document.write('<td id="TxBId">'+ userEthInfos[uiExtEthId].txBytes	+'</td>');
			document.write('<td id="TxFId">'+ userEthInfos[uiExtEthId].txPackets	+'</td>');	

			if (1 == TelMexFlag)
			{
				document.write('<td id="TxEId">'+ incorrectPortStats[uiExtEthId].txErrorPackets	+'</td>');
				document.write('<td id="TxDId">'+ incorrectPortStats[uiExtEthId].txDiscardPackets +'</td>');
			}

			document.write("</tr>");
		}
			
        if (1 != NatieFlag && null != WanEthInfos[0])
        {
            document.write("<tr class=\"tabal_02\" id=\"wanstatistics\">");

			document.write('<td>' + status_ethinfo_language['amp_port_wan'] + '</td>');
			document.write('<td>'+ WanEthInfos[0].Mode	+'</td>');
			document.write('<td>'+ WanEthInfos[0].Speed	+'</td>');
			document.write('<td>'+ WanEthInfos[0].Status	+'</td>');
			document.write('<td>'+WanEthStats[0].BytesReceived	+'</td>');
			document.write('<td>'+WanEthStats[0].PacketsReceived	+'</td>');
			document.write('<td>'+WanEthStats[0].BytesSent	+'</td>');
			document.write('<td>'+WanEthStats[0].PacketsSent	+'</td>');
			document.write("</tr>");
        }
	}
	</script>
</table>
</div>

<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height_10p"></td></tr>
</table>
</body>

</html>