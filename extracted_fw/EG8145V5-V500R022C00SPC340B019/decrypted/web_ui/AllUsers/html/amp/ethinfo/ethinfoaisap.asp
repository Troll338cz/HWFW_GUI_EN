<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/lanuserinfo.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>

<title>Eth Port Information</title>
<script language="JavaScript" type="text/javascript">

var apUpMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var acEthType = '<%HW_WEB_GetEthTypeList();%>'; 
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var intMax = 4294967296;

function stConfigPort(domain, X_HW_MainUpPort)
{
    this.domain = domain;
    this.X_HW_MainUpPort = X_HW_MainUpPort;
}

var PortConfigInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,X_HW_MainUpPort,stConfigPort);%>;
var PortConfigInfo = PortConfigInfos[0];
var MainUpPort = PortConfigInfo.X_HW_MainUpPort;

function LoadFrame() 
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i < all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }

        b.innerHTML = status_ethinfo_language[b.getAttribute("BindText")];
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

var userEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.Statistics,SendFrame|SendFrame_H|SendGoodPktOcts|SendGoodPktOcts_H|SendBadPktOcts|SendBadPktOcts_H|RcvFrame|RcvFrame_H|RcvGoodPktOcts|RcvGoodPktOcts_H|RcvBadPktOcts|RcvBadPktOcts_H,LANStats);%>;

function IncorrectStats(domain, RcvFrame_Undersize, RcvTooLong, RcvFragmentFrame, RcvJabbersFrame, RcvFcsErrFrame, RcvAlignErrFrame, MacRxErrFrame, CarrierSenseErrCnt,ExcessCollisionFrame, MacSendErrFrame)
{
    var delta = 0;
    if ((parseInt(RcvTooLong) >= parseInt(RcvJabbersFrame)) && (parseInt(RcvFcsErrFrame) >= parseInt(RcvJabbersFrame))) {
        delta = parseInt(RcvTooLong) + parseInt(RcvFcsErrFrame) - parseInt(RcvJabbersFrame);
    }
    else {
        delta = parseInt(RcvTooLong) + parseInt(RcvFcsErrFrame);
    }

    this.domain = domain;

    this.rxDiscardPackets = parseInt(RcvFrame_Undersize) + parseInt(RcvAlignErrFrame) + parseInt(MacRxErrFrame) + delta;

    this.txDiscardPackets = parseInt(CarrierSenseErrCnt) + parseInt(ExcessCollisionFrame) + parseInt(MacSendErrFrame);

    this.rxErrorPackets = parseInt(RcvFrame_Undersize) + parseInt(MacRxErrFrame) + delta;

    this.txErrorPackets = 0; 
}

var incorrectPortStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.Statistics, RcvFrame_Undersize|RcvTooLong|RcvFragmentFrame|RcvJabbersFrame|RcvFcsErrFrame|RcvAlignErrFrame|MacRxErrFrame|CarrierSenseErrCnt|ExcessCollisionFrame|MacSendErrFrame, IncorrectStats);%>;

function GEInfo(domain,Mode,Speed,Status)
{
    this.domain = domain;
    this.Mode = Mode;
    this.Speed = Speed;
    this.Status = Status;

    if (Status == 1) {
        if (Mode == 0) this.Mode = status_ethinfo_language['amp_port_halfduplex'];
        if (Mode == 1) this.Mode = status_ethinfo_language['amp_port_fullduplex'];

        if (Speed == 0) this.Speed = status_ethinfo_language['amp_port_10M'];
        if (Speed == 1) this.Speed = status_ethinfo_language['amp_port_100M'];
        if (Speed == 2) this.Speed = status_ethinfo_language['amp_port_1000M'];
        if (Speed == 3) this.Speed = status_ethinfo_language['amp_port_2500M'];
        if (Speed == 4) this.Speed = status_ethinfo_language['amp_port_10000M'];
        if (Speed == 6) this.Speed = status_ethinfo_language['amp_port_5000M'];

        this.Status = status_ethinfo_language['amp_port_linkup'];
    }
    else {
        this.Mode = "--";
        this.Speed = "--";
        this.Status = status_ethinfo_language['amp_port_linkdown'];
    }
}

var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Duplex|Speed|Link,GEInfo);%>;

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">

<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("amp_ethinfo_desc", 
    GetDescFormArrayById(status_ethinfo_language, "amp_ethinfo_desc_head"), 
    GetDescFormArrayById(status_ethinfo_language, "amp_ethinfo_desc"), false);
</script>

<div class="title_spread"></div>

<div style="overflow:auto;overflow-y:hidden"> 

<div class="func_title"><SCRIPT>document.write(status_ethinfo_language["amp_ethinfo_title"]);</SCRIPT></div>

<table id="eth_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr class="head_title">
    <td colspan="1" rowspan="2" BindText='amp_ethinfo_portnum'></td>
    <td colspan="3" BindText='amp_ethinfo_portstatus'></td>
    <script type="text/javascript" language="javascript">

    document.write('<td colspan="2">' + status_ethinfo_language['amp_ethinfo_rx'] + '</td>');
    document.write('<td colspan="2">' + status_ethinfo_language['amp_ethinfo_tx'] + '</td>');

    </script>
    </tr>

    <tr class="head_title">
    <td BindText='amp_ethinfo_duplex'></td>
    <td BindText='amp_ethinfo_speed'></td>
    <td BindText='amp_ethinfo_link'></td>
    <script type="text/javascript" language="javascript">

    document.write('<td>' + status_ethinfo_language['amp_ethinfo_bytes'] + '</td>');        
    document.write('<td>' + status_ethinfo_language['amp_ethinfo_pkts'] + '</td>');

    document.write('<td>' + status_ethinfo_language['amp_ethinfo_bytes'] + '</td>');        
    document.write('<td>' + status_ethinfo_language['amp_ethinfo_pkts'] + '</td>');

    </script>

    </tr>
    <script type="text/javascript" language="javascript">
    if( 1 == userEthInfos.length || null == userEthInfos)
    {
        document.write("<tr class=\"tabal_01\">");
        document.write('<td>'+'&nbsp '    +'</td>');
        document.write('<td>'+'&nbsp '    +'</td>');
        document.write('<td>'+'&nbsp '    +'</td>');
        document.write('<td>'+'&nbsp '    +'</td>');
        
        document.write('<td>'+'&nbsp '    +'</td>');
        document.write('<td>'+'&nbsp '    +'</td>');

        document.write('<td>'+'&nbsp '    +'</td>');
        document.write('<td>'+'&nbsp '    +'</td>');

        document.write("</tr>");
    }

    var lanid;
    var ethNum = parseInt(acEthType.charAt(0), 10);
    for(i=0; i<userEthInfos.length - 1; i++)
    {
        lanid = i+1;

        if(i%2 == 0)
        {
            document.write("<tr class=\"tabal_01\">");
        }
        else
        {
            document.write("<tr class=\"tabal_02\">");
        }

        if (lanid == UpUserPortID) {
            document.write('<td>'+  status_ethinfo_language['amp_port_wan']    +'</td>');
        } else {
            document.write('<td>'+  lanid    +'</td>');
        }

        document.write('<td>'+geInfos[i].Mode    +'</td>');
        document.write('<td>'+geInfos[i].Speed    +'</td>');
        document.write('<td>'+geInfos[i].Status    +'</td>');

        document.write('<td>'+userEthInfos[i].rxBytes    +'</td>');
        document.write('<td>'+userEthInfos[i].rxPackets    +'</td>');

        document.write('<td>'+userEthInfos[i].txBytes    +'</td>');
        document.write('<td>'+userEthInfos[i].txPackets    +'</td>');

        document.write("</tr>");
    }
    </script>
</table>
</div>

<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height_10p"></td></tr>
</table>
</body>

</html>