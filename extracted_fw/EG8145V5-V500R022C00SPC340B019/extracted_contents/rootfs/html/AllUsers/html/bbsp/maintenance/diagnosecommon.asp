<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, diagnose_language);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<style>
    #EquipCheck{
        width:280px;
        white-space: nowrap;
    }
</style>
<script language="JavaScript" type="text/javascript">
var DATA_BLOCK_DEFAULT=56;
var REPEATE_TIME_DEFAULT=4;
var DSCP_DEFAULT=0;
var MaxTimeout_DEFAULT = 10;
var TraceRoute_DATA_BLOCK_DEFAULT = 38;

var PING_FLAG="Ping";
var TRACEROUTE_FLAG="Traceroute";
var EQUIPTEST_FLAG="EquipTest";
var NSLOOKUP_FLAG="Nslookup";

var CLICK_INIT_FLAG="None";
var CLICK_START_FLAG="START";
var CLICK_TERMINAL_FLAG="TERMIANL";

var STATE_INIT_FLAG="None";
var STATE_DOING_FLAG="Doing";
var STATE_DONE_FLAG="Done";

var TimerHandle ;
var TimerHandlePing;
var TimerHandlePingDns;
var TimerHandleEquip;
var TimerHandleNslookup;

var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var CurBinMode = '<%HW_WEB_GetBinMode();%>';

var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var IsTELECOMFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_TELECOM);%>';
var IsAPFlagfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var XDProductType = '2';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsSupportBridgeWan = "<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>";

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var cntLever2UserType = '2';
var APType ='<%HW_WEB_GetApMode();%>'; 
var Is8011_21V5 = "<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>";
var isTurkcell2xdFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_XD_NODISPLAY);%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var supportDSL = '<%HW_WEB_GetFeatureSupport(HW_FT_DSL_SURPPORT);%>';
var nceEnable = '<%WLAN_GetNceRemoteStatus();%>';
var fttrFt = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var fttrApFt = '<%HW_WEB_GetFeatureSupport(FT_FTTR_EDGE_ONT);%>';
var specIppingHost = '<%HW_WEB_GetSPEC(BBSP_SPEC_WEB_IPPING_HOST.string);%>';
var mapEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Enable);%>';

if (CfgModeWord.toUpperCase() == 'DNOVA2WIFI') {
    curUserType = sysUserType;
}

function MaskXdslFeature()
{
    if (productName == 'DN8245V-55') {
        return true;
    } else {
        return false;
    }
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
        setObjNoEncodeInnerHtmlValue(b, diagnose_language[b.getAttribute("BindText")]);
    }
}

function IsPOLNETIAUser()
{
    if (('POLNETIA' == CfgModeWord.toUpperCase()) && (!IsAdminUser())) {
        return true;
    } else {
        return false;
    }
}

function Br0IPAddressItem(domain, IPAddress, SubnetMask)
{
    this.domain = domain;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;
}
function PingResultClass(domain, DiagnosticsState,Interface,Host,NumberOfRepetitions,Timeout,DataBlockSize,DSCP,FailureCount, SuccessCount,MinimumResponseTime,MaximumResponseTime,AverageResponseTime)
{
    this.domain = domain;
    this.DiagnosticsState = DiagnosticsState;
    this.Interface = Interface;
    this.Host = Host;
    if (1 > NumberOfRepetitions)
    {
        this.NumberOfRepetitions = 1;
    }
    else if (3600 < NumberOfRepetitions)
    {
        this.NumberOfRepetitions = 3600;
    }
    else
    {
        this.NumberOfRepetitions = NumberOfRepetitions;
    }
    if (Timeout < 1000)
    {
        this.Timeout = 1000;
    }
    else
    {
        this.Timeout = Timeout;
    }
    if (32 > DataBlockSize)
    {
        this.DataBlockSize = 32;
    }
    else if (65500 < DataBlockSize)
    {
        this.DataBlockSize = 65500;
    }
    else
    {
        this.DataBlockSize = DataBlockSize;
    }
    this.DSCP = DSCP;
    this.FailureCount = FailureCount;
    this.SuccessCount = SuccessCount;
    this.MinimumResponseTime = MinimumResponseTime;
    this.MaximumResponseTime = MaximumResponseTime;
    this.AverageResponseTime = AverageResponseTime;
}

function TracertResultClass(domain,DiagnosticsState,Interface,Host,NumberOfTries,Timeout,DataBlockSize,DSCP,MaxHopCount,ResponseTime,RouteHopsNumberOfEntries,X_HW_ProtocolType)
{
    this.domain = domain;
    this.DiagnosticsState = DiagnosticsState;
    this.Interface = Interface;
    this.Host = Host;
    this.NumberOfTries = NumberOfTries;
    this.Timeout = Timeout;
    this.DataBlockSize = DataBlockSize;
    this.DSCP = DSCP;
    this.MaxHopCount = MaxHopCount;
    this.ResponseTime = ResponseTime;
    this.RouteHopsNumberOfEntries = RouteHopsNumberOfEntries;
    this.ProtocolType = X_HW_ProtocolType;
}

var LanHostInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress|IPInterfaceSubnetMask,Br0IPAddressItem);%>;
var LanHostInfo = LanHostInfos[0];
var PingResultList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetPingResult, InternetGatewayDevice.IPPingDiagnostics,DiagnosticsState|Interface|Host|NumberOfRepetitions|Timeout|DataBlockSize|DSCP|FailureCount|SuccessCount|MinimumResponseTime|MaximumResponseTime|AverageResponseTime, PingResultClass);%>;
var PingResult = PingResultList[0];
var TracertResultList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.TraceRouteDiagnostics,DiagnosticsState|Interface|Host|NumberOfTries|Timeout|DataBlockSize|DSCP|MaxHopCount|ResponseTime|RouteHopsNumberOfEntries|X_HW_ProtocolType, TracertResultClass);%>;
var TracerResult = TracertResultList[0];
var curUplinkMode = "<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.UplinkMode);%>";
var splitobj = "[@#@]";
var dnsString = "";
var NslookupOpInfo;

var PingClickFlag= "<%HW_WEB_GetRunState("Ping");%>";
var TracerouteClickFlag= "<%HW_WEB_GetRunState("Traceroute");%>";
var EquipTestClickFlag= "<%HW_WEB_GetRunState("EquipTest");%>";
var NslookupClickFlag= "<%HW_WEB_GetRunState("Nslookup");%>";

function maptInfoArry(domain, Enable, Name, ConfigMode, Status, WANInterface, BRIPv6Prefix, MappedIPv4Address, MappedIPv6Address, PortSegments) {
    this.domain = domain;
    this.Enable = Enable;
    this.Name = Name;
}

var maptableInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Domain.{i},Enable|Name,maptInfoArry);%>;

var PingState=STATE_INIT_FLAG;
var TraceRouteState=STATE_INIT_FLAG;
var EquipCheckState=STATE_INIT_FLAG;
var NslookupState=STATE_INIT_FLAG;

function staliasInterfaceList(domain, Alias, ObjectPath)
{
    this.domain = domain;
    this.Alias = Alias;
    this.ObjectPath  = ObjectPath;
}

var aliasInterfaceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_InterfaceList.{i}, Alias|ObjectPath, staliasInterfaceList);%>;
function InitAliasInterfaceList(aliasInterfaceId)
{
    for (var i = 0; i < aliasInterfaceList.length - 1; i++) {
        var OptionBr0 = document.createElement("Option");
        OptionBr0.value = aliasInterfaceList[i].ObjectPath;
        OptionBr0.innerText = aliasInterfaceList[i].Alias;
        OptionBr0.text = aliasInterfaceList[i].Alias;
        getElById(aliasInterfaceId).appendChild(OptionBr0);
    }
}

function OnApply()
{
    var IPAddress = getValue("IPAddress");
    var WanName = getSelectVal("WanNameList");

    IPAddress = removeSpaceTrim(IPAddress);
    if (IPAddress.length == 0)
    {
        AlertEx(diagnose_language['bbsp_taraddrisreq']);
        return false;
    }
    
    var DataBlockSize = getValue("DataBlockSize");
    DataBlockSize = removeSpaceTrim(DataBlockSize);
    if(DataBlockSize!="")
    {
       if ( false == CheckNumber(DataBlockSize,32, 65500) )
       {
         AlertEx(diagnose_language['bbsp_pingdatablocksizeinvalid']);
         return false;
       }
    }
    else
    {
         DataBlockSize=DATA_BLOCK_DEFAULT;
    }
    
    var NumberOfRepetitions = getValue("NumOfRepetitions");
    NumberOfRepetitions = removeSpaceTrim(NumberOfRepetitions);
    if(NumberOfRepetitions!="")
    {
       var maxRepetitions = ("1" == GetCfgMode().TELMEX) ? 300000 : 3600;
       if (((CfgModeWord.toUpperCase() == 'CNT') || (CfgModeWord.toUpperCase() == 'CNT2')) && (curUserType == cntLever2UserType)) {
            maxRepetitions = 100;
       }
       if ( false == CheckNumber(NumberOfRepetitions,1, maxRepetitions) )
       {
            if ("1" == GetCfgMode().TELMEX) {
                AlertEx(diagnose_language['bbsp_numofrepetitionsinvalid_telmex']);
                return false;
            } else if ((CfgModeWord.toUpperCase() == 'CNT') || (CfgModeWord.toUpperCase() == 'CNT2')) {
                AlertEx(diagnose_language['bbsp_numofrepetitionsinvalid_cnt']);
                return false;
            } else {
                AlertEx(diagnose_language['bbsp_numofrepetitionsinvalid']);
                return false;
            }
       }
    }
    else
    {
       NumberOfRepetitions=REPEATE_TIME_DEFAULT;
    }

    var DSCP = getValue("DscpValue");
    DSCP = removeSpaceTrim(DSCP);
    if(DSCP!="")
    {
       if ( false == CheckNumber(DSCP,0, 63) )
       {
         AlertEx(diagnose_language['bbsp_dscpvalueinvalid']);
         return false;
       }
  }else
  {
         DSCP=DSCP_DEFAULT;
  }

    var MaxTimeout = getValue("MaxTimeout");
    MaxTimeout = removeSpaceTrim(MaxTimeout);
    if(MaxTimeout != "")
    {
       if ( false == CheckNumber(MaxTimeout,1, 4294967) )
       {
         AlertEx(diagnose_language['bbsp_maxtimeoutinvalid']);
         return false;
       }
  }else
  {
         MaxTimeout = MaxTimeout_DEFAULT;
  }
    MaxTimeout = MaxTimeout*1000;

    top.pingTestFlag = 1;

    setDisable("ButtonApply", "1");    
    setDisable("ButtonStopPing", "1");
    setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
    setNoEncodeInnerHtmlValue('DnsTitle', "");
    setNoEncodeInnerHtmlValue('DnsText', "");
    setNoEncodeInnerHtmlValue('PingTitle', "");
    setNoEncodeInnerHtmlValue('PingText', "");
    
    var Form = new webSubmitForm();

    Form.addParameter('x.Host', IPAddress);
    Form.addParameter('x.DiagnosticsState','Requested');
    Form.addParameter('x.NumberOfRepetitions',NumberOfRepetitions);
    if(DSCP != "" && false == IsSonetUser())
    {
       Form.addParameter('x.DSCP',DSCP);
    }
    Form.addParameter('x.DataBlockSize',DataBlockSize);
    Form.addParameter('x.Timeout',MaxTimeout);

    if (WanName != "")
    {
       Form.addParameter('x.Interface',WanName); 
    }
    
    Form.addParameter('RUNSTATE_FLAG.value',CLICK_START_FLAG);
    Form.addParameter('x.X_HW_Token', getValue('onttoken')); 
    Form.setAction('complex.cgi?x=InternetGatewayDevice.IPPingDiagnostics&RUNSTATE_FLAG='+PING_FLAG+'&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');   
 
    Form.submit(); 
}

function OnStopPing()
{
    var IPAddress = getValue("IPAddress");
    var WanName = getSelectVal("WanNameList");

    if (IPAddress.length == 0)
    {
        return false;
    }
    
    setDisable("ButtonApply", "1");    
    setDisable("ButtonStopPing", "1");
    
    var Form = new webSubmitForm();

    Form.addParameter('x.Host', IPAddress);    
    
    Form.addParameter('x.NumberOfRepetitions',PingResult.NumberOfRepetitions);
    if(true != IsSonetUser())
    {
        Form.addParameter('x.DSCP',PingResult.DSCP);
      }
    Form.addParameter('x.DataBlockSize',PingResult.DataBlockSize);
    Form.addParameter('x.Timeout',PingResult.Timeout);
    if (WanName != "")
    {
       Form.addParameter('x.Interface',WanName); 
    }

    Form.addParameter('RUNSTATE_FLAG.value',CLICK_TERMINAL_FLAG);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));    
    Form.setAction('complex.cgi?x=InternetGatewayDevice.IPPingDiagnostics&RUNSTATE_FLAG='+PING_FLAG+'&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');   
    Form.submit(); 
}

function showPingDnsInfo(dnsTitle, dnsText)
{
    if (dnsString.indexOf("NONE") == -1)
    {
        setNoEncodeInnerHtmlValue('DnsTitle', dnsTitle);
        var DnsStringnew = htmlencode(dnsText.replace(new RegExp(/(\n)/g),'<br>'));
        var newpingResult = DnsStringnew.replace(new RegExp(/(&lt;br&gt;)/g), '<br>');
        setNoEncodeInnerHtmlValue('DnsText', newpingResult);
    }
}

function replaceSpace(str)
{ 
    var Result = str.split("\n");
    var str_encode = "";
    
    for(var i=0; i<Result.length; i++)
    {
        str_encode += $('<div/>').text(Result[i]).html() + '<br>';
    }
    
    return str_encode;    
}
function ParsePingResult(pingString)
{   
     var subString = pingString.split(splitobj);
     var result = "";
     var status = "";
     if (subString.length >= 2)
     {

         if ("\n" == subString[1])
        {
            status = subString[0];
            setNoEncodeInnerHtmlValue('PingTestTitle', '');
            showPingDnsInfo('', '');
            setNoEncodeInnerHtmlValue('PingTitle', '');
            setNoEncodeInnerHtmlValue('PingText', '');
            substring=null;
            return;
        }
        else
        {
            status = subString[1];
            result = subString[0];
        }
     }
     else
     {
          substring=null;
          return ;
     }
     if ( status.indexOf("Requested") >= 0)
     {
         if (CLICK_START_FLAG == PingClickFlag)
         {
            if("1" == GetCfgMode().TELMEX || "1" == GetCfgMode().COMMON)
            {
                var requestResult = "";
                if(dnsString.indexOf("NONE") == -1)
                {
                    requestResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
                }
                requestResult += diagnose_language['bbsp_pingtitle'] + '\n';
                if(result.indexOf("NONE") == -1)
                {
                    requestResult += result;
                }
                getElement("PingResultArea").value = requestResult;    
            }
            else
            {
                result = ChangeRetsult(result);
                setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
            }
            PingState=STATE_DOING_FLAG;
            top.pingTestFlag = 1;
         }
         else if(CLICK_INIT_FLAG == PingClickFlag)
         {
            PingState=STATE_INIT_FLAG;
         }        
          
         showPingDnsInfo('', '');
         setNoEncodeInnerHtmlValue('PingTitle', '');
         setNoEncodeInnerHtmlValue('PingText', '');
     }
     else if( status.indexOf("Complete_Err") >= 0)
     {
        PingState=STATE_DONE_FLAG;        
        setDisable('ButtonApply',0);        
        setDisable("ButtonStopPing", 1);    
        setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_fail']+ '</FONT><B>');
        showPingDnsInfo(diagnose_language['bbsp_dnstitle'], replaceSpace(dnsString));
        setNoEncodeInnerHtmlValue('PingTitle', diagnose_language['bbsp_pingtitle']);
        setNoEncodeInnerHtmlValue('PingText', diagnose_language['bbsp_pingfail1']);
        
        var errResult = "";
        if(dnsString.indexOf("NONE") == -1)
        {
            errResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
        }
        errResult += diagnose_language['bbsp_pingtitle'] + '\n' + result;
        getElement("PingResultArea").value = errResult;
     }
     else if( status.indexOf("Complete") >= 0)
     {
        PingState=STATE_DONE_FLAG;        
        setDisable('ButtonApply',0);        
        setDisable("ButtonStopPing", 1);    
        var tmpResult = ChangeRetsult(result);
        var SubStatisticResult = tmpResult.split("ping statistics ---<br/>");
        var StatisticResult = SubStatisticResult[1];
        var Result = StatisticResult.split("<br/>");
        
        setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_result']+ '</FONT><B>');
        showPingDnsInfo(diagnose_language['bbsp_dnstitle'], replaceSpace(dnsString));
        setNoEncodeInnerHtmlValue('PingTitle', diagnose_language['bbsp_pingtitle']);
        setNoEncodeInnerHtmlValue('PingText', Result[0] + '<br/>' + Result[1]);
        
        var completeResult = "";
        if(dnsString.indexOf("NONE") == -1)
        {
            completeResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
        }
        completeResult += diagnose_language['bbsp_pingtitle'] + '\n' + result;
        getElement("PingResultArea").value = completeResult;        
     }
     else if ( status.indexOf("None") >= 0)
     {         
        PingState=STATE_DONE_FLAG;        
        setDisable('ButtonApply',0);    
        setDisable("ButtonStopPing", 1);    

        setNoEncodeInnerHtmlValue('PingTestTitle', '');
        showPingDnsInfo('', '');
        setNoEncodeInnerHtmlValue('PingTitle', '');
        setNoEncodeInnerHtmlValue('PingText', '');
     }
     else 
     {
        PingState=STATE_DONE_FLAG;        
        var otherResult = "";
        setDisable('ButtonApply',0);
        setDisable("ButtonStopPing", 1);    
        setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_fail']+ '</FONT><B>');
        if( false == CheckIsIpOrNot(removeSpaceTrim(getValue("IPAddress"))) )
        {
            if (dnsString.indexOf("NONE") == -1)
            {
                setNoEncodeInnerHtmlValue('DnsTitle', diagnose_language['bbsp_dnstitle']);
                var DnsStringnew = htmlencode(dnsString);
                var newpingResult = DnsStringnew.replace(new RegExp(/(&lt;br&gt;)/g), '<br>');
                setNoEncodeInnerHtmlValue('DnsText', newpingResult);
                otherResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
            }
            else
            {
                setNoEncodeInnerHtmlValue('DnsTitle', diagnose_language['bbsp_dnstitle']);
                setNoEncodeInnerHtmlValue('DnsText', diagnose_language['bbsp_pingfail1']);
                otherResult = diagnose_language['bbsp_dnstitle'] + '\n' + diagnose_language['bbsp_pingfail1'] + '\n';
            }
        }
        setNoEncodeInnerHtmlValue('PingTitle', diagnose_language['bbsp_pingtitle']);
        setNoEncodeInnerHtmlValue('PingText', diagnose_language['bbsp_pingfail1']);
        
        otherResult += diagnose_language['bbsp_pingtitle'] + '\n' + diagnose_language['bbsp_pingfail1'];
        getElement("PingResultArea").value = otherResult;
     }
     otherResult = null;
     completeResult = null;
     errResult = null;
     tmpResult=null;
     SubStatisticResult=null;
     Result=null;

     if (CfgModeWord.toUpperCase() == 'IDNLINKNETAP' && top.pingTestFlag != 1 && PingState != STATE_DOING_FLAG) {
        setText("IPAddress", specIppingHost);
        setText('DataBlockSize', '56');
        setText('NumOfRepetitions', '4');
        setText('MaxTimeout', '10');
        setText('DscpValue', '0');
        setDisplay("PingTestTitle", 0);
        setDisplay("DnsTitle", 0);
        setDisplay("DnsText", 0);
        setDisplay("PingTitle", 0);
        setDisplay("PingText", 0);

        for (var i = 0; i < document.getElementById("WanNameList").length; i++) {
            if (document.getElementById("WanNameList")[i].text.toUpperCase().indexOf("TR069") >= 0 &&
            document.getElementById("WanNameList")[i].text.toUpperCase().indexOf("INTERNET") >= 0) {
                try {
                    document.getElementById("WanNameList")[i].selected = true;
                } catch(Exception) {
                }
            }
        }
    }

     return ;
}

function GetPingResult()
{
    var PingContent="";
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "./GetPingResult.asp",
        success : function(data) {

            if ((data.length > 8) && ('\\n" + ' == data.substr(2,6)))
            {
                data = data.substr(8);
            }
            PingContent = dealDataWithFun(data);
            ParsePingResult(PingContent);
        },
        complete: function (XHR, TS) { 
            PingContent=null;            
            XHR = null;
        }
    });
}

function GetPingDnsResult()
{
    var PingDnsContent="";
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "./GetPingDnsResult.asp",
        success : function(data) {

            if ((data.length > 8) && ('\\n" + ' == data.substr(2,6)))
            {
                data = data.substr(8);
            }
            PingDnsContent = dealDataWithFun(data);
            dnsString = PingDnsContent;
        },
        complete: function (XHR, TS) { 
            PingDnsContent = null;            
            XHR = null;
        }
    });
}

function GetPingAllResult()
{
    GetPingDnsResult();
    GetPingResult();
    
    if (CLICK_START_FLAG  ==  PingClickFlag && STATE_DOING_FLAG == PingState)
    {     
        if(TimerHandlePing == undefined)
        {            
            TimerHandlePing = setInterval("GetPingAllResult()", 10000);
        }
    }
    
    if ((CLICK_START_FLAG  ==  PingClickFlag && STATE_DONE_FLAG == PingState)
        || (CLICK_TERMINAL_FLAG  ==  PingClickFlag) )
    {     
        if(TimerHandlePing != undefined)
        {
            clearInterval(TimerHandlePing);
        }
    }   
}

function setAllDisable()
{
    setDisable('IPAddress',1);
    setDisable('WanNameList',1);
    setDisable('DataBlockSize',1);
    setDisable('NumOfRepetitions',1);
    setDisable('ButtonApply',1);
    setDisable('ButtonStopPing',1);
    setDisable('wanname',1);
    setDisable('urladdress',1);
    setDisable('btnTraceroute',1);
    setDisable('btnStopTraceroute',1);
    setDisable('Timeout',1);
    setDisable('DSCP',1);
    setDisable('nslookup_target',1);
    setDisable('nslookup_wanname',1);
    setDisable('nslookup_srv',1);
    setDisable('btnNsLookupStart',1);
}

function IsPOLNETIAUserSpecialWan(wandomain)
{
    var WanName = GetWanInstByDomain(wandomain);
    if (WanName != null) {
        if ((WanName.ServiceList.toString().toUpperCase() == "TR069_VOIP") ||
            (WanName.ServiceList.toString().toUpperCase() == "VOIP") ||
            (WanName.ServiceList.toString().toUpperCase() == "TR069")) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

function XDSLDiagnoseVisible()
{
    var invisibleCfgWordList = ["DTURKCELL2WIFI", "DGECOMMON2WIFI", "TTNET2", "DSTCOACCESS"];
    for (var loop = 0; loop < invisibleCfgWordList.length; loop++) {
        if (CfgModeWord.toUpperCase() == invisibleCfgWordList[loop]) {
            return false;
        }
    }
    return (ProductType == XDProductType) && (supportDSL == 1);
}

var controlPingTraceRoute = function(displayFlag) {
    setDisplay('table_ping_title', displayFlag);
    setDisplay('table_ping', displayFlag);
    setDisplay('TraceRouteForm', displayFlag); 
}

function LoadFrame()
{
    if (curUserType == sysUserType)
    {
        setDisplay("space",0);
        if( "CMCC" == CurBinMode.toUpperCase() )
        {
            setDisplay("mainend",1);
        }
        else
        {
            setDisplay("mainend",0);
        }
    }
    else
    {
        setDisplay("mainend",0);
        setDisplay("space",1);
    }
    setDisplay("TraceRoute",1);

    if (CLICK_START_FLAG == TracerouteClickFlag) {
        if (IsPOLNETIAUser() && IsPOLNETIAUserSpecialWan(TracerResult.Interface)) {
            setDisable('btnTraceroute',0);
            setDisable('btnStopTraceroute',1);
            setText("urladdress","");
        } else {
            setDisable('btnTraceroute',1);
            setDisable('btnStopTraceroute',0);
            GetRouteResult();
        }
    }
    else if  (CLICK_TERMINAL_FLAG == TracerouteClickFlag)
    {
        var href = window.location.href.split('&');
        if( (href.length == 3) && (href[2] == 1) )
        {
            setNoEncodeInnerHtmlValue('traceRouteresult', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
        }
        setDisable('btnTraceroute',0);
        setDisable("btnStopTraceroute", 1);     
    }
    else if(CLICK_INIT_FLAG == TracerouteClickFlag)
    {
        setDisable('btnTraceroute',0);
        setDisable("btnStopTraceroute", 1);
    }

    if (CLICK_START_FLAG == EquipTestClickFlag)
    {
        setNoEncodeInnerHtmlValue('equipTestResult', '<B><FONT color=red>'+diagnose_language['selftestwait']+ '</FONT><B>');
        setDisable('EquipCheck',1);
    }
    else
    {
        setNoEncodeInnerHtmlValue('equipTestResult', "");
        setNoEncodeInnerHtmlValue('EquipTestText', "");
    }
   
    var Tr069Enable = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_TR069);%>';
    if(Tr069Enable != 1)
    {
        setDisplay("mainend",0);
    }

    if("1" != GetCfgMode().TELMEX && "1" != GetCfgMode().COMMON)
    {
        setDisplay("PingTestTitle",1);
        setDisplay("DnsTitle",1);
        setDisplay("DnsTextDiv",1);
        setDisplay("PingTitle",1);
        setDisplay("PingTextDiv",1);
    }
    if(CLICK_START_FLAG == PingClickFlag) {
        if (IsPOLNETIAUser() && IsPOLNETIAUserSpecialWan(PingResult.Interface)) {
            setDisable('ButtonApply',0);
            setDisable("ButtonStopPing", 1);
            setText("IPAddress","");
        } else {
            setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
            setDisable('ButtonApply',1);
            setDisable("ButtonStopPing", 0);
            GetPingAllResult();
        }
        if("1" == GetCfgMode().TELMEX || "1" == GetCfgMode().COMMON)
        {
            setDisplay("PingResultDiv",1);
        }
     }
     else if(CLICK_TERMINAL_FLAG == PingClickFlag)
     {
        var href = window.location.href.split('&');
        if( (href.length == 4) && (href[3] == 1) )
        {
            setNoEncodeInnerHtmlValue('PingTestTitle', '<B><FONT color=red>'+diagnose_language['bbsp_stopping']+ '</FONT><B>');
            
            if("1" == GetCfgMode().TELMEX || "1" == GetCfgMode().COMMON)
            {
                GetPingAllResult();
                setDisplay("PingResultDiv",1);
            }
        }
        else
        {

        }
        setDisable('ButtonApply',0);
        setDisable("ButtonStopPing", 1);     
     }
     else if(CLICK_INIT_FLAG == PingClickFlag)
     {
        setDisable('ButtonApply',0);
        setDisable("ButtonStopPing", 1);
     }
     
    if(ProductType == '2')
    {
        setDisplay('XDSLDiagLogDiv',1);
        if (IsSupportBridgeWan == 1) {
            controlPingTraceRoute(0);
        } else {
            controlPingTraceRoute(1);
        }

        if ((curUplinkMode == 'GPON') || (isTurkcell2xdFlag == 1)) {
            setDisplay('XDSLDiagLogDiv',0);
        }
    }
    else
    {
        setDisplay('XDSLDiagLogDiv',0);
    }

    if (MaskXdslFeature()) {
        setDisplay('XDSLDiagLogDiv', 0);	
    }

    if(IsPTVDFFlag == 1)
    {
        setDisplay('NsLookupForm',1);
        GetNslookupOpResult();
    }
    else
    {
        setDisplay('NsLookupForm',0);
    }
     
     

    loadlanguage();
    
    if((curWebFrame == 'frame_argentina') &&(curUserType != sysUserType))
    {
        setAllDisable();
    }
    
    var FeatureInfo = GetFeatureInfo();
    if (FeatureInfo.Wan != 1)
    {    
        setDisplay('ThirdPlayerPanel',0);
    }
    
    if(IsSonetUser())
    {
        setDisplay('DscpValueRow',0);
    }
    if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
    {
        setAllDisable();
        setDisable('MaxTimeout',1);
        setDisable('DscpValue',1);
        setDisable('TraceRouteDataBlockSize',1);
    }
    
    if (ProductType == '3')
    {
        setDisplay("EquipForm",0);
        setDisplay("EquipDiv",0);
    }

    if ((CfgModeWord.toUpperCase() == 'AMCLARO') && (curUserType != sysUserType)) {
        setDisplay("EquipForm", 0);
    }

    if (!XDSLDiagnoseVisible()) {
        setDisplay('XDSLDiagLogDiv',0);
    }
    
    if(APType == 1 && Is8011_21V5 == 1) {
        controlPingTraceRoute(0);
    } else {
        controlPingTraceRoute(1);
    }

    if (curLanguage.toUpperCase() == 'BRASIL') {
        EquipCheck.style.height = "46px";
    }

    if ((fttrFt == 1) || (fttrApFt == 1)) {
        setDisplay("nceEnableDiv", 1);
        setDisplay("nceEnableDivSpread", 1);
        setCheck("EnableNce", nceEnable);
    }

    if ('DETHMAXIS' == CfgModeWord.toUpperCase()) {
        setDisplay('XDSLDiagLogDiv',0);
    }

    if ((CfgModeWord.toUpperCase() == 'CNT') || (CfgModeWord.toUpperCase() == 'CNT2')) {
        setDisable('TraceRouteDataBlockSize', 1);
        setDisable('DataBlockSize', 1);
    }

    if (curLanguage == 'portuguese') {
        $("#EquipCheck").css("width", "425px");
    }

    if ('<%HW_WEB_GetFeatureSupport(FT_SUPPORT_MAP);%>' === '1') {
        setDisplay('protocolTypeRow', 0);
    }

    if ('<%HW_WEB_GetFeatureSupport(BBSP_FT_TRACEROUTE_ICMP);%>' == '1') {
        setDisplay('protocolTypeRow', 0);
    }
}

function WriteOptionFortraceRoute()
{
    InitAliasInterfaceList("wanname");
       InitWanNameListControl2("wanname", function(item){
        if (SingtelMode == '1')
        {
            if ((item.Mode == 'IP_Routed') && (item.Enable == 1) && (item.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0)){
                return true;
            }
        }
        else if((curUserType != sysUserType) && (CfgModeWord.toUpperCase() == "RDSGATEWAY"))
        {
            if ((item.Mode == 'IP_Routed') && (item.Enable == 1) && (item.Tr069Flag == '0') && (item.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0)){
                return true;
            }
        }
        else if ((curUserType != sysUserType) && ("1" == GetCfgMode().DT_HUNGARY))
        {
            if ((item.Mode == 'IP_Routed') && (item.Enable == 1) && (item.Tr069Flag == '0')
                && (item.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0))
            {
                return true;
            }           
        } else if (IsPOLNETIAUser()) {
            if ((item.Mode == 'IP_Routed') && (item.Enable == 1) && (item.ServiceList.toString().toUpperCase().indexOf("INTERNET") != -1)) {
                return true;
            }
        }
        else
        {
            if (CfgModeWord.toUpperCase() == "TRIPLETAP" || CfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || CfgModeWord.toUpperCase() == "TRIPLETAP6" || CfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
                if (item.domain.indexOf(8) > -1) {
                    return false;
                }
            }
            if(IsRadioWanSupported(item))
            {
                if ((item.Mode == "IP_Routed") && (item.RadioWanPSEnable == 1) && (item.Tr069Flag == '0')){
                    return true;
                }
            }
            else
            {
                if ((item.Mode == 'IP_Routed') && (item.Enable == 1) && (item.Tr069Flag == '0'))
                {
                    return true;
                }
            }
        }
        return false;
       });
}

function isHostName(name) 
{
    var reg = new RegExp("^[a-z|A-Z]\.");
    return reg.test(name);
}


function startTraceroute()
{
    setNoEncodeInnerHtmlValue('TraceRouteText', "");
    with (getElement('TraceRouteForm'))
    {
        var url = getValue('urladdress');
        var wanVal;

        if (url.length == 0)
        {
            AlertEx(diagnose_language['bbsp_taraddrisreq']);
            return false;
        }

        if ((IsIPv6AddressValid(url) == true) && (IsIPv6LinkLocalAddress(url) == true))
        {
            AlertEx(diagnose_language['bbsp_linkLocalnotsup']);
            return false;
        }

        var DataBlockSize = getValue('TraceRouteDataBlockSize');
        DataBlockSize = removeSpaceTrim(DataBlockSize);
        if(DataBlockSize!="")
        {
               if ( false == CheckNumber(DataBlockSize,38, 32768) )
               {
                 AlertEx(diagnose_language['bbsp_tracertdatablocksizeinvalid']);
                 return false;
               }
          }else
          {
                 DataBlockSize = TraceRoute_DATA_BLOCK_DEFAULT;
          }
        setDisable('urladdress',1);
        setDisable('TraceRouteDataBlockSize',1);
        setDisable('btnTraceroute',1);
        setDisable('btnStopTraceroute',1);
        setNoEncodeInnerHtmlValue('traceRouteresult', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
        top.tracerouteTestFlag = 1;

        var Form = new webSubmitForm();
        wanVal = getSelectVal('wanname');
        if (wanVal != "")
        {
            Form.addParameter('x.Interface',wanVal); 
        }
        var proType = getSelectVal('protocolType');
        if (proType != "") {
            Form.addParameter('x.X_HW_ProtocolType', proType);
        }
        Form.addParameter('x.DiagnosticsState',"Requested"); 
        Form.addParameter('x.Host',url);
        Form.addParameter('x.DataBlockSize',DataBlockSize);
        Form.addParameter('RUNSTATE_FLAG.value',CLICK_START_FLAG);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('complex.cgi?x=InternetGatewayDevice.TraceRouteDiagnostics&RUNSTATE_FLAG='+TRACEROUTE_FLAG+'&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');                       
        Form.submit();
    }
    return true;
}

function stopTraceroute()
{
    setNoEncodeInnerHtmlValue('TraceRouteText', "");
    var url = getValue('urladdress');
    var wanVal;
    if (url.length == 0)
    {
        return false;
    }
    setDisable('urladdress',1);
    setDisable('TraceRouteDataBlockSize',1);
    setDisable('btnTraceroute',1);
    setDisable('btnStopTraceroute',1);
    setNoEncodeInnerHtmlValue('traceRouteresult', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
    var Form = new webSubmitForm();
    wanVal = getSelectVal('wanname');
    if (wanVal != "")
    {
        Form.addParameter('x.Interface',wanVal); 
    }

    var proType = getSelectVal('protocolType');
    if (proType != "") {
        Form.addParameter('x.X_HW_ProtocolType', proType);
    }

    Form.addParameter('x.Host',url); 
    Form.addParameter('x.DataBlockSize',TracerResult.DataBlockSize);
    Form.addParameter('RUNSTATE_FLAG.value',CLICK_TERMINAL_FLAG);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('complex.cgi?x=InternetGatewayDevice.TraceRouteDiagnostics&RUNSTATE_FLAG='+TRACEROUTE_FLAG+'&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');                      
    Form.submit();
    return true;
}

function ChangeRetsult(text)
{
    var result = "";
    if (text.toLowerCase() != 'none')
    {
       var str=text.replace("!H"," ");
       res = str.split("\n");
       
       for(i=0;i<res.length;i++)
       {
          result+=res[i]+'<br/>';
       }
    }
    return result;
}

function FindResultEnd(string)
{   
     var newString = string.split(splitobj);
     var status =  newString[1];
     var result =  newString[0];

     if ((status.indexOf("Requested") >= 0) || (status.indexOf("parallel_tracerouting") >= 0)) {
        var result;
        result = ChangeRetsult(result);
        setNoEncodeInnerHtmlValue('traceRouteresult', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
        setNoEncodeInnerHtmlValue('TraceRouteText', result);                        
        TraceRouteState=STATE_DOING_FLAG;
        top.tracerouteTestFlag = 1;
     }
     else if( status.indexOf("Complete") >= 0)
     {
        TraceRouteState=STATE_DONE_FLAG;
        if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
        {
            setDisable('btnTraceroute',1);
        }
        else
        {
            setDisable('btnTraceroute',0);
        }
        setDisable('btnStopTraceroute',1);
        var tmpResult = ChangeRetsult(newString[0]);
        setNoEncodeInnerHtmlValue('traceRouteresult', '<B><FONT color=red>'+diagnose_language['bbsp_result']+ '</FONT><B>');
        if(tmpResult == "" || tmpResult == "<br/>")
        {
            setNoEncodeInnerHtmlValue('TraceRouteText', diagnose_language['bbsp_pingfail1']);
        }
        else
        {
            setNoEncodeInnerHtmlValue('TraceRouteText', tmpResult);
        }
        tmpResult=null;
     }
     else if(status.indexOf("None") >= 0)
     {
        TraceRouteState=STATE_DONE_FLAG;
        if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
        {
            setDisable('btnTraceroute',1);
        }
        else
        {
            setDisable('btnTraceroute',0);
        }
        setDisable('btnStopTraceroute',1);
        setNoEncodeInnerHtmlValue('traceRouteresult', "");
        var tmpResult = ChangeRetsult(newString[0]);
        if(tmpResult == "" || tmpResult == "<br/>")
        {
            setNoEncodeInnerHtmlValue('TraceRouteText', "");
        }
        else
        {
            setNoEncodeInnerHtmlValue('TraceRouteText', tmpResult);
        }
        tmpResult=null;
     }
     else 
     {
        TraceRouteState=STATE_DONE_FLAG;
        if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
        {
            setDisable('btnTraceroute',1);
        }
        else
        {
            setDisable('btnTraceroute',0);
        }
        setDisable('btnStopTraceroute',1);
        setNoEncodeInnerHtmlValue('traceRouteresult', '<B><FONT color=red>'+diagnose_language['bbsp_fail']+ '</FONT><B>');
        var tmpResult = ChangeRetsult(newString[0]);
        if(tmpResult == "" || tmpResult == "<br/>")
        {
            setNoEncodeInnerHtmlValue('TraceRouteText', "");
        }
        else
        {
            setNoEncodeInnerHtmlValue('TraceRouteText', tmpResult);
        }
        tmpResult=null;
     }

    if ((CfgModeWord.toUpperCase() == 'IDNLINKNETAP') && (top.tracerouteTestFlag != 1) && (TraceRouteState != STATE_DOING_FLAG)) {
        setText("urladdress",specIppingHost);
        setText('TraceRouteDataBlockSize', '38');
        setDisplay("traceRouteresult",0);
        setDisplay("TraceRouteTextDiv",0);
        for (var i = 0; i < document.getElementById("wanname").length; i++) {
            if (document.getElementById("wanname")[i].text.toUpperCase().indexOf("TR069") >= 0 &&
                document.getElementById("wanname")[i].text.toUpperCase().indexOf("INTERNET") >= 0) {
                try {
                    document.getElementById("wanname")[i].selected = true;
                } catch(Exception) {
                }
            }
        }
    }

    newString=null;
    result=null;
    return ;
}

function SetFlag(flag,value)
{    
    $.ajax({
     type : "POST",
     async : false,
     cache : false,
     data : "RUNSTATE_FLAG.value="+value +"&x.X_HW_Token="+getValue('onttoken'),
     url : "complex.cgi?RUNSTATE_FLAG="+flag,
     success : function(data) {
     },
     complete: function (XHR, TS) {
        XHR=null;
     }
    });
}

function GetRouteResult()
{
    var traceRouteTxt="";
    $.ajax({
     type : "POST",
     async : true,
     cache : false,
     url : "./GetRouteResult.asp",
     success : function(data) {
        if(data !== '') {
          traceRouteTxt = dealDataWithStr(data);
        }
        FindResultEnd(traceRouteTxt);
     },
     complete: function (XHR, TS) {
        if (CLICK_START_FLAG  ==  TracerouteClickFlag && TraceRouteState == STATE_DOING_FLAG)
        {
            if(TimerHandle == undefined)
            {
                TimerHandle=setInterval("GetRouteResult()", 10000);
            }
        }
        
        if( CLICK_START_FLAG  ==  TracerouteClickFlag && TraceRouteState == STATE_DONE_FLAG )
        {
            if(TimerHandle != undefined)
            {
                clearInterval(TimerHandle);
            }else
            {
            }
        }      
        

        traceRouteTxt=null;

         XHR = null;
     }
    });
}



function WriteOptionForNslookup()
{
    InitWanNameListControl2("nslookup_wanname", function(item){
        if ((curUserType != sysUserType) 
            && ((CfgModeWord.toUpperCase() == "RDSGATEWAY") || ("1" == GetCfgMode().DT_HUNGARY)))
        {
            if ((item.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0) && (item.Mode == "IP_Routed")
                && (item.Enable == 1) && (item.Tr069Flag == '0')){
                return true;
            }
        }
        else
        {
            if (CfgModeWord.toUpperCase() == "TRIPLETAP" || CfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || CfgModeWord.toUpperCase() == "TRIPLETAP6" || CfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
                if (item.domain.indexOf(8) > -1) {
                    return false;
                }
            }
            if(IsRadioWanSupported(item))
            {
                if ((item.Mode == "IP_Routed") && (item.RadioWanPSEnable == 1) && (item.Tr069Flag == '0')){
                    return true;
                }
            }
            else
            {
                if ((item.Mode == "IP_Routed") && (item.Enable == 1) && (item.Tr069Flag == '0')){
                    return true;
                }
            }
        }
        return false;
       });
}

function startNSlookup()
{
    with (getElement('NsLookupForm'))
    {
        var url = getValue('nslookup_target');
        var DNSServer = getValue('nslookup_srv');
        var wanVal = getSelectVal('nslookup_wanname');
    
        if (url.length == 0)
        {
            AlertEx(diagnose_language['bbsp_taraddrisreq']);
            return false;
        }
        
        if(DNSServer != "")
        {
            if(false == CheckIsIpOrNot(DNSServer) || false == CheckIpAddressValid(DNSServer))
            {
                AlertEx(diagnose_language['bbsp_invaliddns']);
                return false;
            }
        }
        
        setDisable('nslookup_target',1);
        setDisable('nslookup_srv',1);
        setDisable('nslookup_wanname',1);
        setDisable('btnNsLookupStart',1);
        setNoEncodeInnerHtmlValue('nslookup_process', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
        setNoEncodeInnerHtmlValue('nslookup_result', "");        
        var Form = new webSubmitForm();
        
        Form.addParameter('x.Interface',wanVal);
        Form.addParameter('x.DiagnosticsState',"Requested"); 
        Form.addParameter('x.HostName',url);  
        Form.addParameter('x.DNSServer',DNSServer);
        Form.addParameter('RUNSTATE_FLAG.value',CLICK_START_FLAG);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('complex.cgi?x=InternetGatewayDevice.DNS.Diagnostics.NSLookupDiagnostics&RUNSTATE_FLAG='+NSLOOKUP_FLAG+'&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');                      
        Form.submit();
    }
    return true;
}

function ParseNslookupInfo( NslookupInfo )
{
    var result = NslookupInfo;
    var text = "";
    var ip_addr = "";
    var ipv4_str = "";
    var ipv6_str = "";
        
    for(var i = 0 ; i < result.length - 1 ; i++ )
    {
        if(result[i].Status.indexOf("NotAvailable") >= 0)
        {
            text +="&nbsp;&nbsp;&nbsp;&nbsp;***Can't find " + NslookupOpInfo.DNSServer + "for" + htmlencode(NslookupOpInfo.HostName) + ": No response from server." + '<br/>';
            if( "" == result[i].DNSServerIP)
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: --"
            }
            else
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: "+result[i].DNSServerIP + '<br/>' + '<br/>';
            }
            continue;
        }
        if(result[i].Status.indexOf("NotResolved") >= 0)
        {
            text +="&nbsp;&nbsp;&nbsp;&nbsp;***Dns server can't find " + htmlencode(NslookupOpInfo.HostName) + ": Non-existent domain." + '<br/>';
            if( "" == result[i].DNSServerIP)
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: --"
            }
            else
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: "+result[i].DNSServerIP + '<br/>' + '<br/>';
            }
            continue;
        }
        if(result[i].Status.indexOf("Timeout") >= 0)
        {
            text +="&nbsp;&nbsp;&nbsp;&nbsp;***Dns requset timed out ." + '<br/>';
            if( "" == result[i].DNSServerIP)
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: --"
            }
            else
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: "+result[i].DNSServerIP + '<br/>' + '<br/>';
            }
            continue;
        }
        if(result[i].Status.indexOf("Other") >= 0)
        {
            text +="&nbsp;&nbsp;&nbsp;&nbsp;***Dns requset error: error other ." + '<br/>' ;
            if( "" == result[i].DNSServerIP)
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: --"
            }
            else
            {
                text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: "+result[i].DNSServerIP + '<br/>' + '<br/>';
            }
            continue;
        }
        
        text +="&nbsp;&nbsp;&nbsp;&nbsp;***Dns request success" + '<br/>' ;
        text +="&nbsp;&nbsp;&nbsp;&nbsp;Server Address: "+result[i].DNSServerIP + '<br/>' + '<br/>';
        
        if(result[i].AnswerType.indexOf("NonAuthoritative") >= 0)
        {
            text +="&nbsp;&nbsp;&nbsp;&nbsp;Non-authoritative answer: " + '<br/>' ;
        }
        else if(result[i].AnswerType.indexOf("Authoritative") >= 0)
        {
            text +="&nbsp;&nbsp;&nbsp;&nbsp;Authoritative answer: " + '<br/>' ;
        }
        else
        {
            
        }        
        text +="&nbsp;&nbsp;&nbsp;&nbsp;Name: "+htmlencode(NslookupOpInfo.HostName) + '<br/>';
        
        text +="&nbsp;&nbsp;&nbsp;&nbsp;Addresses: " ;
        
        ip_addr = result[i].IPAddresses.split(",");

        for(var j = 0 ; j < ip_addr.length ; j++)
        {    
            if( 0 == j)
            {
                text += ip_addr[j]+ '<br/>';
            }
            else
            {
                text +=  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"+ip_addr[j]+ '<br/>';
            }
        }    
        text += '<br/>' ;    
    }
    setNoEncodeInnerHtmlValue('nslookup_result', text);
}


function ParseNslookupError( )
{
    var result = NslookupOpInfo;
    var text = "";
    if(result.DiagnosticsState.indexOf("Internal") >= 0 )
    {
        text += "&nbsp;&nbsp;&nbsp;&nbsp;Error: Internal "+ '<br/>';
    }
    if(result.DiagnosticsState.indexOf("Other") >= 0 )
    {
        text += "&nbsp;&nbsp;&nbsp;&nbsp;Error: Other "+ '<br/>';
    }
    setNoEncodeInnerHtmlValue('nslookup_result', text);
}

function GetNslookupResult(func)
{
    var NslookupInfoList;
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "./GetNslookupResult.asp",
            success : function(data) {
            
                NslookupInfoList = dealDataWithFun(data);
                
                func(NslookupInfoList);                
            }
    });
            
}    

function GetNslookupOpResult()
{
    var NslookupOpInfoList;
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "./GetNslookupOpResult.asp",
            success : function(data) {
            
                NslookupOpInfoList = dealDataWithFun(data);
                setDisable('btnNsLookupStart',1);
                if(NslookupOpInfoList != null) 
                {
                    NslookupOpInfo = NslookupOpInfoList[0];
                    if(NslookupOpInfo != "" )
                    {    
                        setText("nslookup_target",NslookupOpInfo.HostName);
                        setSelect("nslookup_wanname",NslookupOpInfo.Interface);
                        setText("nslookup_srv",NslookupOpInfo.DNSServer);
                        
                        for (var i=0; i < document.getElementById("nslookup_wanname").length; i++)
                        {
                            if (document.getElementById("nslookup_wanname")[i].value == NslookupOpInfo.Interface)
                            {
                                try
                                {
                                    document.getElementById("nslookup_wanname")[i].selected = true;
                                }
                                catch(Exception)
                                {
                                }
                            }
                        }
                    }
                    if(  NslookupOpInfo.DiagnosticsState.indexOf("Complete") >= 0 || NslookupOpInfo.DiagnosticsState.indexOf("NotResolved") >= 0)
                    {    
                        NslookupState = STATE_DONE_FLAG;
                        setDisable('btnNsLookupStart',0);
                        setNoEncodeInnerHtmlValue('nslookup_process', '<B><FONT color=red>'+diagnose_language['bbsp_result']+ '</FONT><B>');
                        GetNslookupResult(function(para2)
                        {
                            var NslookupInfo = para2;
                            ParseNslookupInfo( NslookupInfo );
                        });
                        
                    }
                    else if( NslookupOpInfo.DiagnosticsState.indexOf("None") >= 0 )
                    {
                        NslookupState = STATE_INIT_FLAG;
                        setDisable('btnNsLookupStart',0);
                    }    
                    else if( NslookupOpInfo.DiagnosticsState.indexOf("Internal") >= 0 || NslookupOpInfo.DiagnosticsState.indexOf("Other") >= 0 )
                    {
                        NslookupState = STATE_DONE_FLAG;
                        setDisable('btnNsLookupStart',0);
                        setNoEncodeInnerHtmlValue('nslookup_process', '<B><FONT color=red>'+diagnose_language['bbsp_result']+ '</FONT><B>');
                        ParseNslookupError( NslookupOpInfo);
                    }    
                    else
                    {
                        NslookupState = STATE_DOING_FLAG;
                        setNoEncodeInnerHtmlValue('nslookup_process', '<B><FONT color=red>'+diagnose_language['bbsp_testing']+ '</FONT><B>');
                    }
                }
            },
            complete: function (XHR, TS) { 
                NslookupOpInfoList = null;
                 XHR = null;
                if(STATE_DOING_FLAG == NslookupState)
                {
                    if(TimerHandleNslookup == undefined)
                    {
                        TimerHandleNslookup = setInterval("GetNslookupOpResult()", 10000);
                    }
                }
                if(STATE_DONE_FLAG == NslookupState)
                {
                    if(TimerHandleNslookup != undefined)
                    {
                        clearInterval(TimerHandleNslookup);
                    }
                }
            }
        });
}

if (ProductType != '3')
{
    var EquipTestResultInfo = {};
    var PhyResult = new Array();
    function GetEquipInfo()
    {
        PhyResult[0] = EquipTestResultInfo.Port1Result;
        PhyResult[1] = EquipTestResultInfo.Port2Result;
        PhyResult[2] = EquipTestResultInfo.Port3Result;
        PhyResult[3] = EquipTestResultInfo.Port4Result;
        PhyResult[4] = EquipTestResultInfo.Port5Result;
        PhyResult[5] = EquipTestResultInfo.Port6Result;
    }


    function GetEquipTestResult()
    {
        if (CLICK_START_FLAG  ==  EquipTestClickFlag)
        {
            $.ajax({
                type : "POST",
                async : true,
                cache : false,
                url : "./getEquipTestResult.asp",
                success : function(data) {
                EquipTestResultInfo = dealDataWithFun(data);
                GetEquipInfo();
                EquipTestResult();
                },
                complete: function (XHR, TS) { 

                    traceRouteTxt=null;

                     XHR = null;
              }            
            });        
        }
        else
        {
            if(TimerHandleEquip != undefined)
            {
                clearInterval(TimerHandleEquip);
            }        
        }
    }

    function ParseSelfTestResult(SelfTestResult, PhyResult)
    {
        var result = "";
        var resulttemp = "";
        if (SelfTestResult.SD5113Result.indexOf("Failed") >= 0)
        {
            result += diagnose_language['bbsp_sd5113fail'];
        }

        if ((SelfTestResult.WifiResult.indexOf("Failed") >= 0) || (SelfTestResult.WifiResult.indexOf("FAIL") >= 0))
        {
            result += diagnose_language['bbsp_wififail'];
        }

        if (SelfTestResult.LswResult.indexOf("Failed") >= 0)
        {
            result += diagnose_language['bbsp_lswfailk'];
        }

        if (SelfTestResult.CodecResult.indexOf("Failed") >= 0)
        {
            result += diagnose_language['bbsp_codecfail'];
        }

        if (SelfTestResult.OpticResult.indexOf("Failed") >= 0)
        {
            result += diagnose_language['bbsp_lightfail'];
        }

        if(IsXdProduct())
        {
            var PhyNumber = 4;
        }
        else
        {
            var PhyNumber = 6;
        }

        for (i = 0; i < PhyNumber; i++)
        {
            if (PhyResult[i].indexOf("Failed") >= 0)
            {
                resulttemp = "ETH" + (i+1) + diagnose_language['bbsp_phyfail'] ;
                result += resulttemp;
            }
        }
    
        if (SelfTestResult.ExtRfResult.indexOf("Failed") >= 0)
        {
            result += diagnose_language['bbsp_rffail'];
        }
    
        if (SelfTestResult.DECTResult.indexOf("Failed") >= 0)
        {
            result += diagnose_language['bbsp_dectfail'];
        }
    
        return result;
    }

    function ParseLinkTestResult(rawresult)
    {
        var result = "";
        var resulttemp = "";
        var nochecknum = 0;
        portres = rawresult.split(";");

        for (i =0; i < 12; i++)
        {
            innerres = portres[i].split(":");
            finalres = innerres[1];

            if (finalres.indexOf("NoCheck") >= 0)
            {
                nochecknum++;
                continue;
            }

            if (!(i % 2))
            {
                if (finalres.indexOf("Failed") >= 0)
                {
                    resulttemp = "511X ETH" + (i + 2)/2 + diagnose_language['bbsp_machwabnormal'];
                    result += resulttemp;
                }            
            }
            else
            {
                if (finalres.indexOf("Failed") >= 0)
                {
                    resulttemp = "ETH" + (i + 1)/2 + diagnose_language['bbsp_phyhwabnmormal'];
                    result += resulttemp;
                }
            }
        }

        if (nochecknum == 12)
        {
            result = "NoCheck";
        }    
        return result;
    }

    function EquipTestResult()
    {
        var ShowStr = "";
        var PrifixStr = diagnose_language['bbsp_test'];
        LinkResult = ParseLinkTestResult(EquipTestResultInfo.LinkTestResult);
        EquipFinalStr = ParseSelfTestResult(EquipTestResultInfo, PhyResult) + LinkResult;

        if (EquipFinalStr == "")
        {
            ShowStr = PrifixStr + diagnose_language['bbsp_ok'];
        }
        else
        {
            ShowStr = PrifixStr + EquipFinalStr + "!";
            ShowStr = ShowStr.replace("；!", "");
        }

        if (LinkResult.indexOf("NoCheck") >= 0)
        {
            ShowStr = "";
        }
    
        setNoEncodeInnerHtmlValue('equipTestResult', '<B><FONT color=red>'+diagnose_language['bbsp_result']+ '</FONT><B>');
        setNoEncodeInnerHtmlValue('EquipTestText', ShowStr);
        EquipTestClickFlag = CLICK_TERMINAL_FLAG;
        SetFlag(EQUIPTEST_FLAG,CLICK_TERMINAL_FLAG);
        setDisable('EquipCheck',0);
        return ShowStr;
    }

    function OnEquipCheck()
    {
        var lanid = "";
        setDisable('EquipCheck', 1);
        setNoEncodeInnerHtmlValue('EquipTestText', "");
        setNoEncodeInnerHtmlValue('equipTestResult', '<B><FONT color=red>'+diagnose_language['selftestwait']+ '</FONT><B>');    
        EquipTestClickFlag = CLICK_START_FLAG;        
        EquipTestResultInfo = ajaxGetAspData('/html/bbsp/common/EquipTestResult.asp');
        GetEquipInfo();

        var Form = new webSubmitForm();

        if (EquipTestResultInfo.SD5113Result.indexOf("OK") >= 0)
        {
            for (i = 0; i < 6; i++)
            {
                if (PhyResult[i].indexOf("OK") >= 0)
                {
                    lanid += "" + (i +1);
                }
            }
        }

        Form.addParameter('x.portid', lanid);
        Form.addParameter('RUNSTATE_FLAG.value',CLICK_START_FLAG);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));    
        Form.setAction('complex.cgi?x=InternetGatewayDevice.X_HW_DEBUG.BBSP.ExtendPortTransCheck&RUNSTATE_FLAG='+EQUIPTEST_FLAG+'&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');    
        Form.submit();
    
    }

function OnDownXDSLDiagLog()
{
    var Form = new webSubmitForm();
    Form.setAction('xdsldiaglogDown.cgi?&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}
    function OnEndClick() 
    {
        setDisable('MaintenanceEnd', 1);
        var Form = new webSubmitForm();
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('maintenancend.cgi?FileType=log&RequestFile=html/bbsp/maintenance/diagnosecommon.asp');
        Form.submit();
    }

    if (ApModeValue > 0|| GhnDevFlag == "1")
    {
        diagnose_language['bbsp_wannamemh'] = diagnose_language['bbsp_interfacenamemh'];
    }
}

function SubmitNceEnable() {
    var enable = getCheckVal("EnableNce");
    if (enable == 1) {
        if (ConfirmEx(diagnose_language['bbsp_nceenablenotes']) == false) {
            setCheck("EnableNce", 0);
            return;
        }
    }

    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data :"stats="+enable,
        url : "./GetNceStatus.asp",
        success : function(data) {
            window.location.reload();
        }
    });
}

</script>
<title>Diagnose Ping Configuration</title>
</head>
<body  class="mainbody pageBg" onLoad="LoadFrame();"> 
<form> 
<form> </form> 
<div id="ThirdPlayerPanel">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("DCpingtitle", GetDescFormArrayById(diagnose_language, "bbsp_maint"), GetDescFormArrayById(diagnose_language, ""), false);
    if (IsAdminUser() == true)
    {
        if ('2' == ApModeValue || '3' == ApModeValue)
        {
            setNoEncodeInnerHtmlValue("DCpingtitle_content", diagnose_language["bbsp_diagnose_title8"] + diagnose_language["bbsp_diagnose_title6"] + diagnose_language["bbsp_diagnose_title7"]);
        }
        else
        {
            if (IsSupportBridgeWan == 1)
            {
                setNoEncodeInnerHtmlValue("DCpingtitle_content", diagnose_language["bbsp_diagnose_title3"] + '<br>' + diagnose_language["bbsp_diagnose_title8"] + diagnose_language["bbsp_diagnose_title6"] + diagnose_language["bbsp_diagnose_title7"]);
            }
            else
            {
                setNoEncodeInnerHtmlValue("DCpingtitle_content", diagnose_language["bbsp_diagnose_titleadmin"] + '<br>' + diagnose_language["bbsp_diagnose_title8"] + diagnose_language["bbsp_diagnose_title6"] + diagnose_language["bbsp_diagnose_title7"]);
            }
        }
    }
    else
    {
        setNoEncodeInnerHtmlValue("DCpingtitle_content", diagnose_language["bbsp_diagnose_titleuser"]);
    }
</script>
<div class="title_spread"></div>

<table width="100%" border="0" cellpadding="0" id="table_ping_title" cellspacing="0" class="func_title" style="display:none;"> 
  <tr> 
    <td  class="width_per100 align_left" BindText='bbsp_pingtest'>
    </td> 
    <td>
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
    </td>
  </tr> 
</table> 

<form id="table_ping" style="display:none;"> 
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
        <li id="IPAddress" RealType="TextOtherBox" DescRef="Empty" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.Host"  Elementclass="width_254px restrict_dir_ltr" 
            InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'PingResult'},{AttrName:'class', AttrValue:'width_per20x'}]}]"/>    
        <li id="WanNameList" RealType="DropDownList" DescRef="bbsp_wannamemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Interface" Elementclass="width_260px restrict_dir_ltr"/>
        <li id="DataBlockSize" RealType="TextBox" DescRef="bbsp_datablocksize" RemarkRef="bbsp_pingdatablocksizerange" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DataBlockSize" Elementclass="width_254px" InitValue="56"/>
        <li id="NumOfRepetitions" RealType="TextBox" DescRef="bbsp_numofrepetitions" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NumberOfRepetitions" Elementclass="width_254px" InitValue="4"/>
        <li id="MaxTimeout" RealType="TextBox" DescRef="bbsp_maxtimeout" RemarkRef="bbsp_pingmaxtimeoutrange" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Timeout" Elementclass="width_254px" InitValue="10"/>
        <li id="DscpValue" RealType="TextBox" DescRef="bbsp_dscpvalue" RemarkRef="bbsp_dscpPrompt" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DSCP" Elementclass="width_254px" InitValue="0"/>
    </table>
    <script>
        var TableClass = new stTableClass("width_per25", "width_per75 fontSize_12", "ltr");
        var PingConfigFormList = new Array();
        PingConfigFormList = HWGetLiIdListByForm("table_ping", null);
        var formid_hide_id = null;
        HWParsePageControlByID("table_ping", TableClass, diagnose_language, formid_hide_id);
        if (IsPTVDFFlag == 1)
        {
            setNoEncodeInnerHtmlValue("IPAddressColleft", diagnose_language['bbsp_targetmh1']);
        }
        else
        {
            setNoEncodeInnerHtmlValue("IPAddressColleft", diagnose_language['bbsp_targetmh']);
        }
        setText('DataBlockSize', '56');
        if ("1" == GetCfgMode().TELMEX) {
            setNoEncodeInnerHtmlValue("NumOfRepetitionsRemark", diagnose_language['bbsp_repetitionsPromptTelmex']);
        } else if ((CfgModeWord.toUpperCase() == 'CNT') || (CfgModeWord.toUpperCase() == 'CNT2')) {
            setNoEncodeInnerHtmlValue("NumOfRepetitionsRemark", diagnose_language['bbsp_repetitionsPromptCnt']);
        } else {
            setNoEncodeInnerHtmlValue("NumOfRepetitionsRemark", diagnose_language['bbsp_repetitionsPrompt']);
        }
        setText('NumOfRepetitions', '4');
        setText('MaxTimeout', '10');
        setText('DscpValue', '0');
    </script>
    <table id="OperatorPanel" class="table_button" style="width: 100%;"> 
      <tr> 
        <td class="table_submit width_per25" ></td> 
        <td class="table_submit width_per75">
        <button id="ButtonApply"  type="button" onclick="javascript: OnApply();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(diagnose_language['bbsp_start']);</script></button>
        <button id="ButtonStopPing"  type="button" onclick="javascript: OnStopPing();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(diagnose_language['bbsp_stop']);</script></button>
        </td> 
      </tr> 
    </table> 
    <div name="PingTestTitle" id="PingTestTitle" style="display:none;"></div> 
    <div name="DnsTitle" id="DnsTitle" style="display:none;"></div> 
    <div name="DnsTextDiv" id="DnsTextDiv" style="display:none;word-break:break-all"><table><tr><td id="DnsText" class="restrict_dir_ltr"></td></tr></table></div> 
     <div name="PingTitle" id="PingTitle" style="display:none;"></div> 
     <div name="PingTextDiv" id="PingTextDiv" style="display:none;"><table><tr><td id="PingText" class="restrict_dir_ltr"></td></tr></table></div>
     <div id="PingResultDiv" style="display:none;"> 
      <textarea name="PingResultArea" id="PingResultArea"  wrap="off" readonly="readonly" style="width: 100%;height: 150px;margin-top: 10px;">
      </textarea> 
     </div>      
<div class="func_spread"></div>    
</form> 

<div id="TraceRouteForm" style="display: none;"> 
  <div id ="TraceRoute"> 
    <table width="100%" border="0" id="TraceRoute_title" cellpadding="0" cellspacing="0" class="func_title"> 
      <tr> 
        <td  class="width_per100 align_left" BindText='bbsp_tracertest'> </td> 
      </tr> 
    </table> 
    
    <form id="table_trace" style="display:block;"> 
        <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
            <li id="urladdress" RealType="TextBox" DescRef="Empty" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="y.Host" Elementclass="width_254px restrict_dir_ltr"/>
            <li id="wanname" RealType="DropDownList" DescRef="bbsp_wannamemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="y.Interface" Elementclass="width_260px restrict_dir_ltr"/>
            <li id="TraceRouteDataBlockSize" RealType="TextBox" DescRef="bbsp_datablocksize" RemarkRef="bbsp_tracertdatablocksizerange" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Timeout" Elementclass="width_254px" InitValue="38"/>
            <li id="protocolType" RealType="DropDownList" DescRef="bbsp_protocoltype" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_ProtocolType" Elementclass="width_260px restrict_dir_ltr"/>
        </table>
        <script>
            var TraceRouteConfigFormList = new Array();
            TraceRouteConfigFormList = HWGetLiIdListByForm("table_trace", null);
            var formid_hide_id = null;
            HWParsePageControlByID("table_trace", TableClass, diagnose_language, formid_hide_id);
            if (IsPTVDFFlag == 1)
            {
                setNoEncodeInnerHtmlValue("urladdressColleft", diagnose_language['bbsp_targetmh1']);
            }
            else
            {
                setNoEncodeInnerHtmlValue("urladdressColleft", diagnose_language['bbsp_targetmh']);
            }
            $("#wanname").append('<option value=""></option>');
            if (SingtelMode == '1')
            {
                $("#wanname").append('<option value="br0">'
                            + "LAN" + '</option>');
            }
            else if(!((curUserType != sysUserType) && ((CfgModeWord.toUpperCase() == "RDSGATEWAY")||("1" == GetCfgMode().DT_HUNGARY))))
            {
                $("#wanname").append('<option value="br0">'
                            + "br0" + '</option>');
            }
            WriteOptionFortraceRoute();
            if (mapEnable === '1') {
                for (var loop = 0; loop < maptableInfo.length - 1; loop++) {
                    if (maptableInfo[loop].Enable == 1) {
                        var OptionMap = document.createElement("Option");
                        OptionMap.value = maptableInfo[loop].domain;
                        OptionMap.innerText = htmlencode(maptableInfo[loop].Name);
                        OptionMap.text = htmlencode(maptableInfo[loop].Name);
                        getElById("wanname").appendChild(OptionMap);
                    }
                }
            }
            WriteOptionForPktType("protocolType");
            setText('TraceRouteDataBlockSize', '38');
        </script>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" id="table_trace_button" class="table_button">  
            <td class="table_submit width_per25" ></td> 
        <td class="table_submit width_per75">
        <button  class="ApplyButtoncss buttonwidth_100px" name="btnTraceroute" id= "btnTraceroute" type="button" onClick="startTraceroute();"><script>document.write(diagnose_language['bbsp_start']);</script> </button>
        <button  class="CancleButtonCss buttonwidth_100px" name="btnStopTraceroute" id= "btnStopTraceroute" type="button" onClick="stopTraceroute();"><script>document.write(diagnose_language['bbsp_stop']);</script> </button>
        </td> 
      </tr> </table> 
    <div name="traceRouteresult" id="traceRouteresult"></div> 
    <div name="TraceRouteTextDiv" id="TraceRouteTextDiv"><table><tr><td id="TraceRouteText" class="restrict_dir_ltr"></td></tr></table></div> 
    <div id="space"> 
    </div>
    <div class="func_spread"></div>
    </form> 
  </div> 
</div>

<div id="NsLookupForm" style="display:none;">
  <div id ="NsLookup"> 
    <table width="100%" border="0" id="NsLookup_title" cellpadding="0" cellspacing="0" class="func_title"> 
      <tr> 
        <td  class="width_per100 align_left" BindText='bbsp_nl_fullname'> </td> 
      </tr> 
    </table> 
   
   <form id="table_nslookup" style="display:block;"> 
        <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
            <li id="nslookup_target" RealType="TextBox" DescRef="bbsp_URL" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="z.HostName" Elementclass="width_254px"/>
            <li id="nslookup_wanname" RealType="DropDownList" DescRef="bbsp_wannamemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="y.Interface" Elementclass="width_260px"/>
            <li id="nslookup_srv" RealType="TextBox" DescRef="bbsp_nl_dns_srv" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DNSServer" Elementclass="width_254px"/>
        </table>
        <script>
            var NslookupConfigFormList = new Array();
            NslookupConfigFormList = HWGetLiIdListByForm("table_nslookup", null);
            var formid_hide_id = null;
            HWParsePageControlByID("table_nslookup", TableClass, diagnose_language, formid_hide_id);
            $("#nslookup_wanname").append('<option value=""></option>');
            WriteOptionForNslookup();
        </script>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" id="table_nslookup_button" class="table_button">  
            <td class="table_submit width_per25" ></td> 
        <td class="table_submit align_left width_per10"> <button  class="ApplyButtoncss buttonwidth_100px" name="btnNsLookupStart" id= "btnNsLookupStart" type="button" onClick="startNSlookup();"><script>document.write(diagnose_language['bbsp_start']);</script> </button></td> 
        <td class="table_submit align_left"></td> 
      </tr> </table> 
    <div name="nslookup_process" id="nslookup_process"></div>
    <div name="nslookup_result" id="nslookup_result"></div> 
  </div> 
  <div class="func_spread"></div>
</form>
</div>
</div>
<div id="nceEnableDiv" style="display:none;">
    <table width="100%" cellpadding="0" cellspacing="0" class="tabal_noborder_bg">
        <tbody>
            <tr border="1">
                <td class="table_title width_per25">
                    <script>document.write(diagnose_language['bbsp_nceenabletitle'])</script>
                </td>
                <td class="table_right width_per75">
                    <input id="EnableNce" type="checkbox" realtype="CheckBox" class="CheckBox" onclick="SubmitNceEnable(this);">
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div id="nceEnableDivSpread" style="display:none;" class="func_spread"></div>
<form id="EquipForm"> 
<div id ="EquipDiv"> 
  <table id="EquipTitle" width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
    <tr> 
      <td  class="align_left width_per100" BindText='bbsp_hwtest'></td> 
    </tr> 
  </table> 
  
  <table id= "EquipButton"  width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button"> 
    <tr > 
      <td class="table_submit width_per1" > </td> 
      <td class="table_submit width_per99"> <button id="EquipCheck" name="EquipCheck" type="button" class="ApplyButtoncss buttonwidth_150px_300px"  onclick="OnEquipCheck();"><script>document.write(diagnose_language['bbsp_starthwtest']);</script> </button></td> 
         </tr> 
       </table> 
        <div name="equipTestResult" id="equipTestResult"></div> 
            <div name="EquipTestText" id="EquipTestText"></div> 
            <div id="equipTestSpace"> 
              <div class="func_spread"></div>
            </div>
</div>
<div id ="XDSLDiagLogDiv">
    <table id="XDSLDiagTitle" width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
        <tr>
            <td  class="align_left width_per100" BindText='bbsp_dsldiaglogTitle'></td>
        </tr>
    </table>

    <table id= "XDSLDiagButton"  width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
        <tr>
            <td class="table_submit width_per1" > </td>
            <td class="table_submit width_per99"> <button id="XDSLDiag" name="DownXDSLDiagLog" type="button" class="ApplyButtoncss buttonwidth_150px_300px"  onclick="OnDownXDSLDiagLog();"><script>document.write(diagnose_language['bbsp_dsldiaglogDown']);</script> </button></td>
        </tr>
    </table>
</div>
</form> 
<div id="mainend" style="display:none;"> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
    <tr> 
      <td  class="align_left width_per100" BindText='bbsp_maint'></td> 
    </tr> 
  </table> 
  <table  id="MaintenanceButton" class="table_button" style="width: 100%;"> 
    <tr> 
      <td class="table_submit width_per1" ></td> 
      <td class="table_submit width_per99 align_left"><button id="MaintenanceEnd"  type="button"  onclick="javascript:OnEndClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(diagnose_language['bbsp_maintend']);</script></button></td> 
    </tr> 
  </table> 
  
  <script>
  	if (rosunionGame == "1") {
		$("#ButtonApply").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
		$("#btnTraceroute").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
		$("#EquipCheck").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
	}
    function IsValidWan(Wan)
    {
        if (SingtelMode == '1')
        {
            if ((Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0) && (Wan.Enable == 1) && (Wan.Mode == "IP_Routed")){
                return true;
            }
        }
        else if ((curUserType != sysUserType) 
            && ((CfgModeWord.toUpperCase() == "RDSGATEWAY") || ("1" == GetCfgMode().DT_HUNGARY)))
        {
            if ((Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0) && (Wan.Enable == 1) && (Wan.Mode == "IP_Routed")) {
                return true;
            }
        } else if (IsPOLNETIAUser()) {
            if ((Wan.Mode == "IP_Routed") && (Wan.Enable == 1) && (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") != -1)) {
                return true;
            }
        }
        else
        {
            if (CfgModeWord.toUpperCase() == "TRIPLETAP" || CfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || CfgModeWord.toUpperCase() == "TRIPLETAP6" || CfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
                if (Wan.domain.indexOf(8) > -1) {
                    return false;
                }
            }
            if(IsRadioWanSupported(Wan))
            {
                if ((Wan.Mode == "IP_Routed") && (Wan.RadioWanPSEnable == 1)){
                    return true;
                }
            }
            else
            {
                if ((Wan.Mode == "IP_Routed") && (Wan.Enable == 1)){
                    return true;
                }
            }
        }
        return false;
    }
    function InitWanList()
    {
        var Option = document.createElement("Option");
        Option.value = "";
        Option.innerText = "";
        Option.text = "";
        getElById("WanNameList").appendChild(Option);
        if (SingtelMode == '1')
        {
            if (LanHostInfo != null)
            {
                var OptionBr0 = document.createElement("Option");
                OptionBr0.value = LanHostInfo.domain;
                OptionBr0.innerText = "LAN";
                OptionBr0.text = "LAN";
                getElById("WanNameList").appendChild(OptionBr0);            
            }
        }
        else if(!((curUserType != sysUserType) && (("1" == GetCfgMode().DT_HUNGARY) || (CfgModeWord.toUpperCase() == "RDSGATEWAY"))))
        {
            if (LanHostInfo != null)
            {
                var OptionBr0 = document.createElement("Option");
                OptionBr0.value = LanHostInfo.domain;
                OptionBr0.innerText = "br0";
                OptionBr0.text = "br0";
                getElById("WanNameList").appendChild(OptionBr0);            
            }
        }
        
        InitAliasInterfaceList("WanNameList");
        InitWanNameListControl2("WanNameList", IsValidWan);

        if (mapEnable == 0) {
            return;
        }

        for (var loop = 0; loop < maptableInfo.length - 1; loop++) {
            if (maptableInfo[loop].Enable == 1) {
                var OptionMap = document.createElement("Option");
                OptionMap.value = maptableInfo[loop].domain;
                OptionMap.innerText = maptableInfo[loop].Name;
                OptionMap.text = maptableInfo[loop].Name;
                getElById("WanNameList").appendChild(OptionMap);
            }
        }
    }

    function ShowPingResult()
    {
        var Text = GetPageParameter("queryFlag");
        var Success;

        if (Text == null)
        {
            return;
        }

        if (PingResult == null)
        {
            return;
        }

        setNoEncodeInnerHtmlValue('PingResult', ((parseInt(PingResult.SuccessCount,10) > 0) ? ("<B><FONT class='color_red'>" + diagnose_language['bbsp_pingpass'] + "</FONT><B>") : ("<B><FONT class='color_red'>" + diagnose_language['bbsp_pingfail'] + "</FONT><B>")));
    }

    InitWanList();

    if (!((IsPOLNETIAUser() && IsPOLNETIAUserSpecialWan(TracerResult.Interface)))) {
        if (CfgModeWord.toUpperCase() == 'IDNLINKNETAP' && top.tracerouteTestFlag != 1 && TracerouteClickFlag != CLICK_START_FLAG) {
            setText("urladdress",specIppingHost);
        } else {
            setText("urladdress",TracerResult.Host);
            setText("TraceRouteDataBlockSize",TracerResult.DataBlockSize);
        }
        setSelect("wanname",TracerResult.Interface);
        setSelect('protocolType', TracerResult.ProtocolType);
    }

    for (var i=0; i < document.getElementById("wanname").length; i++)
    {
        if (domainTowanname(document.getElementById("wanname")[i].value) == TracerResult.Interface)
        {
            try
            {
                document.getElementById("wanname")[i].selected = true;
            }
            catch(Exception)
            {
            }
        }
        if ((top.tracerouteTestFlag != 1) && (TracerouteClickFlag != CLICK_START_FLAG) && (CfgModeWord.toUpperCase() == 'IDNLINKNETAP') && 
            (document.getElementById("wanname")[i].text.toUpperCase().indexOf("TR069") >= 0) &&
            (document.getElementById("wanname")[i].text.toUpperCase().indexOf("INTERNET") >= 0)) {
            try {
                document.getElementById("wanname")[i].selected = true;
            } catch(Exception) {
            }
            break;
        }
    }
    if (IsPOLNETIAUser() && IsPOLNETIAUserSpecialWan(PingResult.Interface)) {
        PingResult.Host = "";
    }

    if (CfgModeWord.toUpperCase() == 'IDNLINKNETAP' && top.pingTestFlag != 1 && PingClickFlag != CLICK_START_FLAG) {
        setText("IPAddress",specIppingHost);
    } else if (PingResult.Host!="") {
        setText("IPAddress",PingResult.Host);
        setText("DataBlockSize", PingResult.DataBlockSize);
        setText("NumOfRepetitions",PingResult.NumberOfRepetitions);
        setText("DscpValue",PingResult.DSCP);
        setText("MaxTimeout",parseInt(PingResult.Timeout/1000,10));
        setSelect("WanNameList",PingResult.Interface);
    }

    
    for (var i=0; i < document.getElementById("WanNameList").length; i++)
    {
        if (domainTowanname(document.getElementById("WanNameList")[i].value) == PingResult.Interface)
        {
            try
            {
                document.getElementById("WanNameList")[i].selected = true;
            }
            catch(Exception)
            {
            }
        }
        if ((top.pingTestFlag != 1) && (PingClickFlag != CLICK_START_FLAG) && (CfgModeWord.toUpperCase() == 'IDNLINKNETAP') && 
            (document.getElementById("WanNameList")[i].text.toUpperCase().indexOf("TR069") >= 0) &&
            (document.getElementById("WanNameList")[i].text.toUpperCase().indexOf("INTERNET") >= 0)) {
            try {
                document.getElementById("WanNameList")[i].selected = true;
            } catch(Exception) {
            }
            break;
        }
    }
    function GetWanInstByDomain(wandomain)
    {
        var WanInstList = GetWanList();
        for (var i = 0; i < WanInstList.length; i++) {
            if(wandomain == WanInstList[i].domain) {
                return WanInstList[i];
            }
        }
        return null;
    }
  </script> 
  </form> 
  <table width="100%" height="20" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
</div> 
<table width="100%" height="20" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
<script language="JavaScript" type="text/javascript">
TimerHandleEquip = setInterval("GetEquipTestResult()", 30000);
</script> 
</body>
</html>
