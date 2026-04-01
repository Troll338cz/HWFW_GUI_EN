<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/wanipv6state.asp"></script>
<script language="javascript" src="/html/bbsp/common/wanaddressacquire.asp"></script>
<script language="JavaScript" type="text/javascript">

var WanList = GetWanList();
var curUserType = '<%HW_WEB_GetUserType();%>';
var sysUserType = '0';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>';
var gponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT.State);%>';
var eponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT.State);%>';
var GUIDE_NULL = "--";
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var IPProtVerMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_IPProtocolVersion.Mode);%>';
var InformStatus =  '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.X_HW_InformStatus);%>';

var curWebMode = '<%HW_WEB_GetWebMode();%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var XDProductType = '2';
var IsSupportBridgeWan = '<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>';
var isTurkcell2xdFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_XD_NODISPLAY);%>';
var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var supportDSL = '<%HW_WEB_GetFeatureSupport(HW_FT_DSL_SURPPORT);%>';
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';

function MaskXdslFeature()
{
    if (productName == 'DN8245V-55') {
        return true;
    } else {
        return false;
    }
}

function GEInfo(domain,Mode,Speed,Status)
{
    this.domain     = domain;
    this.Mode       = Mode;
    if(Mode==0)this.Mode = status_ethinfo_language['amp_port_halfduplex'];
    if(Mode==1)this.Mode = status_ethinfo_language['amp_port_fullduplex'];

    this.Speed      = Speed;
    if(Speed==0)this.Speed = status_ethinfo_language['amp_port_10M'];
    if(Speed==1)this.Speed = status_ethinfo_language['amp_port_100M'];
    if(Speed==2)this.Speed = status_ethinfo_language['amp_port_1000M'];
    if(Speed==3)this.Speed = status_ethinfo_language['amp_port_2500M'];
    if(Speed==4)this.Speed = status_ethinfo_language['amp_port_10000M'];
    if(Speed==6)this.Speed = status_ethinfo_language['amp_port_5000M'];

    this.Status     = Status;
    if(Status==0)this.Status = status_ethinfo_language['amp_port_linkdown'];
    if(Status==1)this.Status = status_ethinfo_language['amp_port_linkup'];
}

function GetAccessMode()
{
    var accModes = new Array(["not initial", "NOT INITIAL"], ["gpon", "GPON"], ["epon", "EPON"],
                        ["10g-gpon", "XG-PON"], ["Asymmetric 10g-epon", "Asymmetric 10G EPON"],
                        ["Symmetric 10g-epon", "Symmetric 10G EPON"], ["ge", "GE"],["Symmetric 10g-gpon", "Symmetric 10G GPON"]);

    var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.XG_AccessMode);%>';

    var i=0;

    for( ; i<accModes.length; i++)
    {
        if(ontPonMode == accModes[i][0])
            return accModes[i][1];
    }

    return "--";
}

function getEthLinkState()
{
    var ethStatus='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.3.WANEthernetInterfaceConfig.Status);%>';
    if (IsSupportBridgeWan == 0) {
        var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Duplex|Speed|Link, GEInfo);%>;
        var ethTypes = '<%GetEthServiceTypes();%>';
        if (ethTypes !== '') {
          ethTypes = JSON.parse(ethTypes);
        }
        for (var i = 0; i < ethTypes.length; i++) {
            if ((typeof ethTypes == "undefined") || (ethTypes[i] != 2)) {
                continue;
            }
            if (geInfos[i] == null) {
                continue;
            }
            ethStatus = geInfos[i].Status;
            if (status_ethinfo_language['amp_port_linkdown'] != geInfos[i].Status) {
                ethStatus = ethStatus + '<br>' + geInfos[i].Speed + '<br>' + geInfos[i].Mode;
            }
        }
    }
    return ethStatus;
}

function  getDslLinkState()
{
    return '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Status);%>';
}

function GetLteLinkState()
{
    if (isSupportLte == 1) {
        var lteStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.5.WANConnectionDevice.1.WANIPConnection.1.ConnectionStatus);%>';
        if (lteStatus.toUpperCase() == "CONNECTED") {
            return "Up";
        } else {
            var lteIpv6Status = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.5.X_HW_ShowInterface.4.ConnectionStatus);%>';
            if (lteIpv6Status.toUpperCase() == "CONNECTED") {
                return "Up";
            } else {
                return "Down";
            }
        }
    }

    return "";
}


function GetLinkState()
{
    var State = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;

    if (State == 1 || State == "1")
    {
        return  SmartOntdes["smart003"];
    }
    else
    {
        return SmartOntdes["smart004"];
    }
}

function GetLinkTime()
{
    var LinkTime = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.EPONLinkInfo.PONLinkTime);%>';
    var LinkDesc;

    LinkDesc = parseInt(LinkTime/3600) + SmartOntdes["smart006"] + parseInt((LinkTime%3600)/60) + SmartOntdes["smart007"];
    if (GetLinkState() == SmartOntdes["smart004"])
    {
        LinkDesc = GUIDE_NULL;
    }

    return LinkDesc;
}

function GetIPv6Address(wan)
{
    var AddressList = GetIPv6AddressList(wan.MacId);
    var AddressAcquire = GetIPv6AddressAcquireInfo(wan.domain);
    var PrefixList = GetIPv6PrefixList(wan.MacId);
    var Prefix = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].Prefix:'') :(PrefixList[0].Prefix));
    Prefix = (wan.Enable == "1") ? Prefix : "";
    var PrefixAcquire = GetIPv6PrefixAcquireInfo(wan.domain);
    PrefixAcquire = ((PrefixAcquire==null) ? '' : PrefixAcquire.Origin);
    var AddressHtml = "";
    for (var m = 0; m < AddressList.length; m++)
    {
        if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
        {
            if (wan.Enable == "1")
            {
                if(AddressHtml == '')
                    AddressHtml += AddressList[m].IPAddress;
                else
                    AddressHtml += "<br>" + AddressList[m].IPAddress;
            }
        }
    }
    if((AddressHtml == "")&&(IsPTVDFFlag == 1))
    {
        if(AddressAcquire != null)
        {
            if((AddressAcquire.Origin == "None")&&(Prefix != ""))
            {
                var PrefixTemp = Prefix.split("::")[0];
                AddressHtml = PrefixTemp + "::1";
            }
        }
    }

    return AddressHtml;
}

function SetIPv4Addr(wan,id)
{
    if(("CONNECTED" == wan.Status.toUpperCase()) && ('' != wan.IPv4IPAddress) )
    {
        document.getElementById(id).innerHTML = htmlencode(wan.IPv4IPAddress);
    }
    else
    {
        document.getElementById(id).innerHTML = "--";
    }
}

function SetIPv6Addr(wan,id)
{
    var ipv6Wan = GetIPv6WanInfo(wan.MacId);
    var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());
    if("CONNECTED" == ipv6wanStatus)
    {
        document.getElementById(id).innerHTML = htmlencode(GetIPv6Address(wan));
    }
    else
    {
        document.getElementById(id).innerHTML = "--";
    }
}

function IsInternetWanUp(wan)
{
    if ('IPv4' == wan.ProtocolType)
    {
        return ("CONNECTED" == wan.Status.toUpperCase()) ? true : false;
    }
    else if ('IPv6' == wan.ProtocolType)
    {
        var ipv6Wan = GetIPv6WanInfo(wan.MacId);
        var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());
        return ("CONNECTED" == ipv6wanStatus) ? true : false;
    }
    else if ('IPv4/IPv6' == wan.ProtocolType)
    {
        var ipv6Wan = GetIPv6WanInfo(wan.MacId);
        var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());
        if("CONNECTED" == wan.Status.toUpperCase() || "CONNECTED" == ipv6wanStatus)
        {
            return true;
        }

        return false;
    }
    else
    {
        return false;
    }
}

function wandisPtvdfcurUser(Currentwan)
{
    setDisplay('iptypeinfo', 0);

    if (null == Currentwan)
    {
        document.getElementById("internetip").innerHTML = '--';
        setDisplay('internetipRow',1);
        setDisplay('internetipv4Row',0);
        setDisplay('internetipv6Row',0);
        return;
    }

    if (('IPv4' == Currentwan.ProtocolType)
        ||(('1' == IPProtVerMode) && ('IPv4/IPv6' == Currentwan.ProtocolType)))
    {
        SetIPv4Addr(Currentwan,'internetip');
        setDisplay('internetipRow',1);
        setDisplay('internetipv4Row',0);
        setDisplay('internetipv6Row',0);
    }
    else if (('IPv6' == Currentwan.ProtocolType)
        ||(('2' == IPProtVerMode) && ('IPv4/IPv6' == Currentwan.ProtocolType)))
    {
        SetIPv6Addr(Currentwan,'internetip');
        setDisplay('internetipRow',1);
        setDisplay('internetipv4Row',0);
        setDisplay('internetipv6Row',0);
    }
    else
    {
        SetIPv4Addr(Currentwan,'internetipv4');
        SetIPv6Addr(Currentwan,'internetipv6');
        setDisplay('internetipRow',0);
        setDisplay('internetipv4Row',1);
        setDisplay('internetipv6Row',1);
    }
}

function GetInternetWanstate()
{
    var Currentwan = null;
    for (var i = 0; i < WanList.length; i++)
    {
        if(('IP_Routed' == WanList[i].Mode)
            && (WanList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
            && ("1" == WanList[i].Enable)
            && IsInternetWanUp(WanList[i]))
        {
            Currentwan = WanList[i];
            break;
        }
    }

    if ((curUserType != sysUserType) && (1 == IsPTVDFFlag))
    {
        wandisPtvdfcurUser(Currentwan);
        return;
    }

    if (null == Currentwan)
    {
        document.getElementById("internettypevalue").innerHTML = '--';
        document.getElementById("internetip").innerHTML = '--';
        setDisplay('internetipRow',1);
        setDisplay('internetipv4Row',0);
        setDisplay('internetipv6Row',0);
        return;
    }

    document.getElementById("internettypevalue").innerHTML = htmlencode(Currentwan.ProtocolType);

    if ('IPv4' == Currentwan.ProtocolType)
    {
        SetIPv4Addr(Currentwan,'internetip');
        setDisplay('internetipRow',1);
        setDisplay('internetipv4Row',0);
        setDisplay('internetipv6Row',0);
    }
    else if ('IPv6' == Currentwan.ProtocolType)
    {
        SetIPv6Addr(Currentwan,'internetip');
        setDisplay('internetipRow',1);
        setDisplay('internetipv4Row',0);
        setDisplay('internetipv6Row',0);
    }
    else if ('IPv4/IPv6' == Currentwan.ProtocolType)
    {
        SetIPv4Addr(Currentwan,'internetipv4');
        SetIPv6Addr(Currentwan,'internetipv6');
        setDisplay('internetipRow',0);
        setDisplay('internetipv4Row',1);
        setDisplay('internetipv6Row',1);
    }
    return;
}

function SetItmsInfoStatus()
{
    if( '0' == InformStatus )
    {
        document.write(SmartOntdes["smart016"]);
    }
    else if( '1' == InformStatus )
    {
        document.write(SmartOntdes["smart015"]);
    }
    else if( '2' == InformStatus || '3' == InformStatus )
    {
        document.write(SmartOntdes["smart017"]);
    }
    else
    {
        document.write(SmartOntdes["smart015"]);
    }
}

var bondingInfo = '';

function getBondingInfo() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "bondingInfo.asp",
        success : function(data) {
            bondingInfo = dealDataWithFun(data);
        }
    });
}

function GetBondingstate()
{
    var ipv4Address = "";
    var ipv6Address = "";

    getBondingInfo();
    for (var i = 0; i < bondingInfo.length - 1; i++) {
        if (bondingInfo[i].Status == "Up") {
            ipv4Address = bondingInfo[i].IPv4Address;
            ipv6Address = bondingInfo[i].IPv6Address;
            break;
        }
    }

    if ((ipv4Address == '') && (ipv6Address == '')) {
        document.getElementById("internettypevalue").innerHTML = '--';
        document.getElementById("internetip").innerHTML = '--';
        setDisplay('internetipRow', 1);
        setDisplay('internetipv4Row', 0);
        setDisplay('internetipv6Row', 0);
        return;
    }

    if ((ipv4Address != '') && (ipv6Address == '')) {
        document.getElementById("internettypevalue").innerHTML = 'Ipv4';
        document.getElementById("internetip").innerHTML = htmlencode(ipv4Address);
        setDisplay('internetipRow', 1);
        setDisplay('internetipv4Row', 0);
        setDisplay('internetipv6Row', 0);
        return;
    }

    if ((ipv4Address == '') && (ipv6Address != '')) {
        document.getElementById("internettypevalue").innerHTML = 'Ipv6';
        document.getElementById("internetip").innerHTML = htmlencode(ipv6Address);
        setDisplay('internetipRow', 1);
        setDisplay('internetipv4Row', 0);
        setDisplay('internetipv6Row', 0);
        return;
    }

    if ((ipv4Address != '') && (ipv6Address != '')) {
        document.getElementById("internettypevalue").innerHTML = 'Ipv4/Ipv6';
        document.getElementById("internetipv4").innerHTML = htmlencode(ipv4Address);
        document.getElementById("internetipv6").innerHTML = htmlencode(ipv6Address);
        setDisplay('internetipRow', 0);
        setDisplay('internetipv4Row', 1);
        setDisplay('internetipv6Row', 1);
        return;
    }

}

function LoadFrame()
{
    var bondingEnable = 0;
    if (isSupportHybrid == 1) {
        bondingEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_Bonding.Enable);%>';
    }
    if ((isSupportHybrid == 1) && (bondingEnable == 1)) {
        GetBondingstate();
    } else {
        GetInternetWanstate();
    }

    if(smartlanfeature == 1)
    {
        document.getElementById('PONinfo').style.display="none";
        document.getElementById('oltinfo').style.display="none";

        if(apcmodefeature == 1)
        {
            document.getElementById('modeinfo').style.display="none";
            
            if('1'==curChangeMode)
            {
                document.getElementById("1").checked=true;
            }
            else if('2'==curChangeMode)
            {
                document.getElementById("2").checked=true;
            }
            else if('3'==curChangeMode)
            {
                document.getElementById("3").checked=true;
            }
        }
    }

    if (GetAccessMode() ==  "GE")
    {
        document.getElementById('PONinfo').style.display="none";
    }
    
    if (ProductType == XDProductType) {
        document.getElementById('ONTinfo').style.display="none";
        if (!DSLLinkInfoVisible()) {
            document.getElementById('dsllinkinfo').style.display="none";
        }
        if (IsSupportBridgeWan == 1)
        {
            document.getElementById('ethlinkinfo').style.display="none";
            document.getElementById('internetinfo').style.display="none";
        }
    }
    else
    {
        document.getElementById('DSLinfo').style.display="none";
    }

    if (notSupportPON == "1") {
        document.getElementById('PONinfo').style.display="none";
        document.getElementById('oltinfo').style.display="none";
    }

    if (MaskXdslFeature()) {
        document.getElementById('dsllinkinfo').style.display = "none";
    }

    if (isDnzvdf == 1) {
        setDisplay("registerinfoDsl", 0);
    }
}

function DSLLinkInfoVisible()
{
    if (isTurkcell2xdFlag == 1) {
        return false;
    }
    var invisibleCfgWordList = ["DSTCOACCESS"];
    for (var loop = 0; loop < invisibleCfgWordList.length; loop++) {
        if (CfgModeWord.toUpperCase() == invisibleCfgWordList[loop]) {
            return false;
        }
    }
    return supportDSL == 1;
}

</script>
</head>
<body onLoad="LoadFrame();" style="background-color:#EDF1F2;">
<div id="SmartOntInfo">
    <div id="modeinfo" style="display:none;" >
        <div id="modechange" >
            <div id="modeTitle" class="modeBorderCss" >
                <div id="registerTitle" class="TitleBorderCss">
                    <span id="registerTitleSpan" class="SmartinfoSpan" BindText="smart044"></span>
                </div>
                <div id="cmodetop">
                    <form id="modecars"  style="">
                        <p ><input id="1" type="radio" name="CMode" value="route"></input><span class="Smartinforight" BindText="smart045"></span></p>
                        <p ><input id="2" type="radio" name="CMode" value="lan"></input><span class="Smartinforight" BindText="smart046"></span></p>
                        <p ><input id="3" type="radio" name="CMode" value="wifi"></input><span class="Smartinforight" BindText="smart047"></span></p>
                    </form>
                </div >
            </div>

            <div>
                <input id="Apply" class="whitebuttonBlueBgcss" type="button" BindText="smart048" style="" onclick="showconfirm();" >
            </div>
            <script type="text/javascript">
            $(function(){
                showwifimode();
                $("input[name=CMode]").click(function(){
                    showwifimode();
                });
            });
            function showwifimode(){
                switch($("input[name=CMode]:checked").attr("id")){
                    case "1":
                        window.parent.wifiModehide();
                        document.getElementById("Apply").disabled=false;
                        break;
                    case "2":
                        window.parent.wifiModehide();
                        document.getElementById("Apply").disabled=false;
                        break;
                    case "3":
                        window.parent.wifiModeShow();
                        document.getElementById("Apply").disabled=false;
                        break;
                    default:
                        break;
                }
            }

            function showconfirm(){

                if(($("input[name=CMode]:checked").attr("id"))=='3' ){
                    window.parent.wifiModeShow();
                    document.getElementById("Apply").disabled=false;
                }
                if(($("input[name=CMode]:checked").attr("id"))=='1' || ($("input[name=CMode]:checked").attr("id"))=='2' ){
                    var cmbln = window.confirm(SmartOntdes["smart049"]);

                }
                if (cmbln == true){
                    ModeChangeState();
                    document.getElementById("Apply").disabled=true;
                }
                else{
                    document.getElementById("Apply").disabled=false;
                    if(curChangeMode=='1')
                    {
                        document.getElementById("1").checked=true;
                    }
                    else if(curChangeMode=='2')
                    {
                        document.getElementById("2").checked=true;
                    }
                    else if(curChangeMode=='3')

                    {
                        document.getElementById("3").checked=true;
                    }
                }


            }
            function ModeChangeState()
            {
                if(($("input[name=CMode]:checked").attr("id"))=='1')
                {
                    curChangeMode = '1';
                    var Form = new webSubmitForm();
                    Form.addParameter('cmode', curChangeMode);
                    Form.setAction('apmodechange.cgi?'+'&RequestFile=smatontinfo.asp');
                    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
                    Form.submit();
                }
                else if(($("input[name=CMode]:checked").attr("id"))=='2')
                {
                    curChangeMode = '2';
                    var Form = new webSubmitForm();
                    Form.addParameter('cmode', curChangeMode);
                    Form.setAction('apmodechange.cgi?'+'&RequestFile=smatontinfo.asp');
                    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
                    Form.submit();
                }
                else if(($("input[name=CMode]:checked").attr("id"))=='3')
                {
                    curChangeMode = '3';
                }
            }
            </script>
        </div>
    </div>

    <div id="ONTinfo">
        <div id="PONinfo" class="SmartOntModule" >
            <div id="PONinfoTitle" class="TitleBorderCss">
                <span id="PONinfoTitleSpan" class="SmartinfoSpan" BindText="smart001"></span>
            </div>
            <div id="AccessTypeinfo" class="TitleSpace">
                <div id="accessmodedes" class="SmartinfoLeft" BindText="smart021"></div>
                <div id="accessmodeType" class="Smartinforight"><script type="text/javascript" language="javascript">document.write(htmlencode(GetAccessMode()));</script></div>
            </div>
            <div id="accesslinkinfo" class="TitleSpace">
                <div id="accesslinkdes" class="SmartinfoLeft" BindText="smart002"></div>
                <div id="accesslinkvalue" class="Smartinforight"><script type="text/javascript" language="javascript">document.write(htmlencode(GetLinkState()));</script></div>
            </div>
            <div id="linktimeinfo" class="TitleSpace">
                <div id="linktimedes" class="SmartinfoLeft" BindText="smart005"></div>
                <div id="linktimevalue" class="Smartinforight"><script type="text/javascript" language="javascript">document.write(htmlencode(GetLinkTime()));</script></div>
            </div>
        </div>

        <div id="registerinfo" class="SmartOntModule_PonInfo">
            <div id="registerTitle" class="TitleBorderCss">
                <span id="registerTitleSpan" class="SmartinfoSpan" BindText="smart009"></span>
            </div>
            <div id="oltinfo" class="TitleSpace">
                <div id="oltinfotitle" class="SmartinfoLeft" BindText="smart010"></div>
                <div id="oltinfovalue" class="Smartinforight">
                <script type="text/javascript" language="javascript">
                if(opticInfo == "--" || opticInfo == "")
                {
                    document.write(SmartOntdes["smart029"]);
                }
                else
                {
                    if (ontPonMode.toUpperCase() == 'GPON')
                    {
                        if (gponStatus.toUpperCase() == 'O5')
                        {
                            document.write(SmartOntdes["smart012"]);
                        }
                        else
                        {
                            document.write(SmartOntdes["smart013"]);
                        }
                    }
                    else if (ontPonMode.toUpperCase() == 'EPON')
                    {
                        if (eponStatus.toUpperCase() =="ONLINE" )
                        {
                            document.write(SmartOntdes["smart012"]);
                        }
                        else
                        {
                            document.write(SmartOntdes["smart013"]);
                        }
                    }
                    else
                    {
                        document.write(SmartOntdes["smart013"]);
                    }

                }
                </script>
                </div>
            </div>
            <div id="itmsinfo" class="TitleSpace" style="display:none;">
                <div id="itmsinfotitle" class="SmartinfoLeft" BindText="smart014"></div>
                <div id="itmsinfovalue" class="Smartinforight"><script language="javascript">SetItmsInfoStatus()</script></div>
            </div>
        </div>
    </div>

    <div id="DSLinfo">
        <div id="DSLInfo" class="SmartOntModule">
            <div id="DSLInfoTitle" class="TitleBorderCss"><span id="DSLInfoTitleSpan" class="SmartinfoSpan" BindText="smart001_xd"></span></div>
            <div id="dsllinkinfo" class="TitleSpace">
                <div id="dsllinkdes" class="SmartinfoLeft" BindText="smart045_xd"></div>
                <div id="dsllinkvalue" class="Smartinforight"><script type="text/javascript" language="javascript">document.write(htmlencode(getDslLinkState()));</script></div>
            </div>
            <div id="ethlinkinfo" class="TitleSpace">
                <div id="ethlinkdes" class="SmartinfoLeft" BindText="smart044_xd"></div>
                <div id="ethlinkvalue" class="Smartinforight">
                    <script type="text/javascript" language="javascript">
                        var ethLinkState = getEthLinkState();
                        document.write(ethLinkState);
                        if (ethLinkState == "") {
                            setDisplay("ethlinkinfo", 0);
                        }
                    </script>
                </div>
            </div>
            <script type="text/javascript" language="javascript">
                if (isSupportLte == 1) {
                    document.write('<div id="ltelinkinfo" class="TitleSpace">');
                    document.write('<div id="ltelinkdes" class="SmartinfoLeft" BindText="smart050_xd"></div>');
                    document.write('<div id="ltelinkvalue" class="Smartinforight">');
                    document.write(GetLteLinkState());
                    document.write('</div>');
                    document.write('</div>');
                }
            </script>
        </div>

        <div id="registerinfoDsl" class="SmartOntModule_PonInfo">
            <div id="registerTitle" class="TitleBorderCss"><span id="registerTitleSpan" class="SmartinfoSpan" BindText="smart009"></span></div>
            <div id="itmsinfo_xd" class="TitleSpace" style="display:none;">
                <div id="itmsinfotitle" class="SmartinfoLeft" BindText="smart014"></div>
                <div id="itmsinfovalue" class="Smartinforight"><script language="javascript">SetItmsInfoStatus()</script></div>
            </div>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        if (isSupportLte == 1) {
            document.write('<div id="internetinfo" class="SmartOntModule_InterNet" style="width:30%;">');
        } else {
            document.write('<div id="internetinfo" class="SmartOntModule_InterNet">');
        }
    </script>
        <div id="internetTitle" class="TitleBorderCss">
            <span id="internetTitleSpan" class="SmartinfoSpan" BindText="smart018"></span>
        </div>
        <div id="iptypeinfo" class="TitleSpace">
            <div id="internettypedes" class="SmartinfoLeft" BindText="smart019"></div>
            <div id="internettypevalue" class="Smartinforight"></div>
        </div>
        <div id="internetipRow" class="TitleSpace" style="display:none;">
            <div id="internetipdes" class="SmartinfoLeft" BindText="smart020"></div>
            <div id="internetip" class="Smartinforight"></div>
        </div>
        <div id="internetipv4Row" class="TitleSpace" style="display:none;">
            <div id="internetipv4des" class="SmartinfoLeft" BindText="smart027"></div>
            <div id="internetipv4" class="Smartinforight"></div>
        </div>
        <div id="internetipv6Row" class="TitleSpace" style="display:none;">
            <div id="internetipv6des" class="SmartinfoLeft" BindText="smart028"></div>
            <div id="internetipv6" class="Smartinforight"></div>
            <input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
        </div>
    </div>


</div>
<script>
    ParseBindTextByTagName(SmartOntdes, "span", 1);
    ParseBindTextByTagName(SmartOntdes, "td", 1);
    ParseBindTextByTagName(SmartOntdes, "div", 1);
    ParseBindTextByTagName(SmartOntdes, "input", 2);
    if(parseInt(mngttype, 10) == 1 && curUserType != sysUserType)
    {
        $("#itmsinfo").css("display", "none");
        $("#itmsinfo_xd").css("display", "none");
    }
    else
    {
        $("#itmsinfo").css("display", "block");
        $("#itmsinfo_xd").css("display", "block");
    }
</script>
</div>
</body>
</html>
