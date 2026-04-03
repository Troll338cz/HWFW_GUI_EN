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
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>GPON INFO</title>
<style>
.h3-content {
  margin-left: 40px;
  width: 90%;
  padding-bottom: 20px;
  display: table;
}
</style>
<script language="JavaScript" type="text/javascript">

var isOpticUpMode = '<%HW_WEB_IsOpticUpMode();%>';
var intMax = 4294967296;
function stDevInfo(domain, serialnumber)
{
    this.domain = domain;
    this.serialnumber = serialnumber;    
}

function ONTInfo(domain,ONTID,Status)
{
    this.domain = domain;
    this.ONTID  = ONTID;
    this.Status = Status;
}
function stOpticInfo(domain,transOpticPower,revOpticPower)
{
    this.domain = domain;
    this.transOpticPower = transOpticPower;
    this.revOpticPower = revOpticPower;
}
    
var stDevInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber, stDevInfo);%>;
var stDevinfo = stDevInfos[0];

var ontInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT,Ontid|State,ONTInfo);%>;
var ontInfo = ontInfos[0];

var opticInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic,TxPower|RxPower, stOpticInfo);%>;
var opticInfo = opticInfos[0];

function tcontAllocid(domain, id)
{  
    this.domain = domain;
    this.id = parseInt(id);
}
var tcontAllocids = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.OmciMibShowAllocId.{i}.allocid, id, tcontAllocid);%>;

function PONStats(domain, TxPackets, TxOmci, TxDrop, BipErr, RxPackets, RxOmci, RxDrop)
{  
    this.domain   = domain;
    this.TxPackets = parseInt(TxPackets);
    this.TxOmci  = parseInt(TxOmci);
    this.TxDrop  = parseInt(TxDrop);
    this.BipErr  = parseInt(BipErr);
    this.RxPackets = parseInt(RxPackets);
    this.RxOmci  = parseInt(RxOmci);
    this.RxDrop  = parseInt(RxDrop);
}
function GEMStats(domain, gemId, tcontId, txPackets, txPackets_H, txBytes, txBytes_H, rxPackets, rxPackets_H, rxBytes, rxBytes_H, discard, direction, type)
{  
    this.domain = domain;
    this.gemId = parseInt(gemId);
    this.tcontId = parseInt(tcontId);
    this.txPackets = parseInt(txPackets_H)*intMax + parseInt(txPackets);
    this.txBytes  = parseInt(txBytes_H)*intMax + parseInt(txBytes);
    this.rxPackets = parseInt(rxPackets_H)*intMax + parseInt(rxPackets);
    this.rxBytes  = parseInt(rxBytes_H)*intMax + parseInt(rxBytes);
    this.discard = discard;
    this.direction = direction;
    this.type = type;
}
var userPonInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.Pon.GetPonStats, TxPackets|TxOmci|TxDrop|BipErr|RxPackets|RxOmci|RxDrop, PONStats);%>;
var gemportInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.Gemport.GemInfo.{i}.Stats, gemId|tcontId|txPackets|txPackets_H|txBytes|txBytes_H|rxPackets|rxPackets_H|rxBytes|rxBytes_H|discard|direction|type, GEMStats);%>;

var userPonInfo = userPonInfos[0];

function TCONTInfo(domain, tcontId, allocId, txGemFrame)
{
    this.domain = domain;
    this.tcontId = tcontId;
    this.allocId = allocId;
    this.txGemFrame = txGemFrame;
}

var tcontInfos = new Array();

function clacTcontStatistic()
{
    var tcontIds;
    var txGemFrames = 0;
    var i;
    var j;
    var temp = 4096;
    for (i=0; i < gemportInfos.length - 1; i++)
    {
        tcontIds = gemportInfos[i].tcontId;
        txGemFrames = 0;
        if (tcontIds == temp)
            continue;

        for(j=i; j < gemportInfos.length - 1; j++)
        {
            if (tcontIds == gemportInfos[j].tcontId)
            {
                txGemFrames = txGemFrames + gemportInfos[j].txPackets;
                temp = tcontIds;
            }
        }
        tcontInfos[tcontIds] = new TCONTInfo(1, gemportInfos[i].tcontId, tcontAllocids[tcontIds].id, txGemFrames);
    }

}

function resetGemPonStatistics()
{
    var parainfo="";

    for(i=1;i<gemportInfos.length;i++)
    {
        parainfo='x.X_HW_Token=' + getValue('hwonttokenResetGem');
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : parainfo,
            url : "setajax.cgi?x=InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.Gemport.GemInfo."+ i +".ClearStats&RequestFile=html/amp/gponinfo/newvdfgponinfo.asp",
            success : function(data) {
            },
        });
    }
    parainfo='x.X_HW_Token=' + getValue('hwonttokenResetGem');
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : parainfo,
        url : "setajax.cgi?x=InternetGatewayDevice.X_HW_DEBUG.WAP_AMP.Pon.ClearPonStats&RequestFile=html/amp/gponinfo/newvdfgponinfo.asp",
        success : function(data) {
        },
    });
    location.reload();
}

function LoadFrame() 
{
    
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">

<div>
    <h1 style="font-family:'Arial';">
        <span><script>document.write(status_gponinfo_language['amp_gponinfo_head']);</script></span>
    </h1>
    <div>
        <h3>
            <span><script>document.write(status_gponinfo_language['amp_gponinfo_title']);</script></span>
        </h3>
        
        <div class="h3-content">
            <div class="row">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(status_gponinfo_language['amp_gponinfo_SN']);</script></span>  
                </div>
                <div class="right deviceStatus padding20">
                    <span >
                        <script>document.write(stDevinfo.serialnumber);</script>
                    </span>
                </div>
            </div>
            <div class="left line"> </div>
            <div class="row">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(status_gponinfo_language['amp_gponinfo_Status']);</script></span>  
                </div>
                <div class="right line deviceStatus padding20">
                    <span>
                        <script>document.write(ontInfo.Status);</script>
                    </span>
                </div>
            </div>
        </div>
        
        <h3>
            <span><script>document.write(status_gponinfo_language['amp_gponpower_title']);</script></span>
        </h3>
        <div class="h3-content">
            <div class="row">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(status_gponinfo_language['amp_gponpower_Rx']);</script></span>  
                </div>
                <div class="right deviceStatus padding20">
                    <span >
                        <script>document.write(opticInfo.revOpticPower +'dBm');</script>
                    </span>
                </div>
            </div>
            <div class="left line"> </div>
            <div class="row">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(status_gponinfo_language['amp_gponpower_Tx']);</script></span>  
                </div>
                <div class="right line deviceStatus padding20">
                    <span>
                        <script>document.write(opticInfo.transOpticPower+'dBm');</script>
                    </span>
                </div>
            </div>
        </div>
        
        <h3>
            <span><script>document.write(status_gponinfo_language['amp_tcontstate_title']);</script></span>
        </h3>
        <!-- TCONT State -->
        <div class="h3-content">
            <table>
                <tr> 
                    <th><script>document.write(status_gponinfo_language['amp_tcontstate_tID']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_tcontstate_aID']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_tcontstate_gem']);</script></th>
                    <th id="ref_head"><script>document.write(status_gponinfo_language['amp_tcontstate_BW']);</script></th>
                </tr>
                <script type="text/javascript" language="javascript">
                    clacTcontStatistic();
                    var i;
                    for(i=0; i < tcontInfos.length; i++)
                    {
                        document.write("<tr>");
                        document.write('<td>'+ tcontInfos[i].tcontId +'</td>');
                        document.write('<td>'+ tcontInfos[i].allocId +'</td>');
                        document.write('<td>'+ tcontInfos[i].txGemFrame +'</td>');
                        document.write('<td>'+ '0%' +'</td>');
                        document.write("</tr>");
                    }
                </script>
            </table>
        </div>
        <!-- Gem Port State -->
        <h3>
            <span><script>document.write(status_gponinfo_language['amp_gemstate_title']);</script></span>
        </h3>
        <div class="h3-content">
            <table>
                <tr> 
                    <th><script>document.write(status_gponinfo_language['amp_gemstate_pID']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstate_dir']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstate_type']);</script></th>
                    <th id="ref_head"><script>document.write(status_gponinfo_language['amp_gemstate_tID']);</script></th>
                </tr>
                <script type="text/javascript" language="javascript">
                    var lanid,duplexModeid,portSpeedid;
                    for(i=0; i < gemportInfos.length - 1; i++)
                    {
                        document.write("<tr>");
                        document.write('<td>'+  gemportInfos[i].gemId	+'</td>');
                        document.write('<td>'+  gemportInfos[i].direction	+'</td>');
                        document.write('<td>'+  gemportInfos[i].type	+'</td>');
                        document.write('<td>'+  gemportInfos[i].tcontId	+'</td>');
                        document.write("</tr>");
                    }
                </script>
            </table>
        </div>
        <!--  PON Statistics -->
        <h3>
            <span><script>document.write(status_gponinfo_language['amp_ponstat_title']);</script></span>
        </h3>
        <div class="h3-content">
            <table>
                <tr> 
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_up']);</script></th>
                    <th></th>
                    <th></th>
                    <th id="ref_head"><script>document.write(status_gponinfo_language['amp_ponstat_down']);</script></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    
                </tr>
                <tr> 
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_frames']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_omci']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_drop']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_frames']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_omci']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_ponstat_crc']);</script></th>
                    <th id="ref_head"><script>document.write(status_gponinfo_language['amp_ponstat_drop']);</script></th>
                </tr>
                <script type="text/javascript" language="javascript">
                    document.write("<tr>");
                    document.write('<td>'+  userPonInfo.TxPackets	+'</td>');
                    document.write('<td>'+  userPonInfo.TxOmci	+'</td>');
                    document.write('<td>'+  userPonInfo.TxDrop	+'</td>');
                    document.write('<td>'+  userPonInfo.RxPackets	+'</td>');
                    document.write('<td>'+  userPonInfo.RxOmci	+'</td>');
                    document.write('<td>'+  userPonInfo.BipErr	+'</td>');
                    document.write('<td>'+  userPonInfo.RxDrop	+'</td>');
                    document.write("</tr>");
                </script>
            </table>
        </div>
        <!-- Gem Port Statistics --> 
        <h3>
            <span><script>document.write(status_gponinfo_language['amp_gemstatis_title']);</script></span>
        </h3>
        <div class="h3-content">
            <table>
                <tr> 
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_gemport']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_egresst']);</script></th>
                    <th></th>
                    <th id="ref_head"><script>document.write(status_gponinfo_language['amp_gemstatis_ingress']);</script></th>
                    <th></th>
                    <th></th>
                </tr>
                <tr> 
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_gemID']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_frames']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_Bytes']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_discard']);</script></th>
                    <th><script>document.write(status_gponinfo_language['amp_gemstatis_frames']);</script></th>
                    <th id="ref_head"><script>document.write(status_gponinfo_language['amp_gemstatis_Bytes']);</script></th>
                </tr>
                <script type="text/javascript" language="javascript">
                    var lanid,duplexModeid,portSpeedid;
                    for(i=0; i < gemportInfos.length - 1; i++)
                    {
                        document.write("<tr>");
                        document.write('<td>'+  gemportInfos[i].gemId	+'</td>');
                        document.write('<td>'+  gemportInfos[i].txPackets	+'</td>');
                        document.write('<td>'+  gemportInfos[i].txBytes	+'</td>');
                        document.write('<td>'+  gemportInfos[i].discard	+'</td>');
                        document.write('<td>'+  gemportInfos[i].rxPackets	+'</td>');
                        document.write('<td>'+  gemportInfos[i].rxBytes	+'</td>');
                        document.write("</tr>");
                    }
                </script>
            </table>
        </div>
        
        
        <!-- 横线+ refresh + reset -->
        <tr>
            <table width="100%" cellspacing="1" class="line">
                <td width="20%"></td>
            </table>
        </tr>
        <div style="text-align:right;height:50px;" id="TblApply">
            <input type="hidden" name="onttoken" id="hwonttokenResetGem" value="<%HW_WEB_GetToken();%>">
            <button id="cancelValue2" class="button button-pri-cancel" onclick="resetGemPonStatistics()">
                <script>document.write(status_gponinfo_language['amp_gemstatis_reset']);</script>
            </button>
            <button id="btnApply_ex2" class="button button-pri-apply"  onClick="location.reload()"  style="background:#9c2aa0;">
                <script>document.write(status_gponinfo_language['amp_gemstatis_refresh']);</script>
            </button>
        </div>
    </div>
</body>

</html>
