<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>

<title>LLDP</title>
<script language="JavaScript" type="text/javascript">

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var selctIndex = -1;
var TableName = "RadiusFrom"

function LoadFrame() 
{ 
    displayDot1xsGlobal();
}

function stDot1xGlobal(domain,Enable,VoiceNotCtrol)
{  
    this.domain     = domain;
    this.Enable     = Enable;
    this.VoiceNotCtrol = VoiceNotCtrol;
}
var Dot1xsGlobals = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X,Enable|VoiceNotCtrol,stDot1xGlobal);%>;
var Dot1xsGlobal = Dot1xsGlobals[0];

function stRadius(domain,Authserver1,SharedSecretAuth1,Authserver2,SharedSecretAuth2,AuthUserNameFormat,AccountingServer,NasPortID,AccountServer1,AccountServer2,DASServerPort,ServerMode, SerDetName, SerDetPass, SerDetPeriod)
{  
    this.domain             = domain;
    this.Authserver1        = Authserver1;
    this.SharedSecretAuth1  = '**********************';
    this.Authserver2        = Authserver2;
    this.SharedSecretAuth2  = '**********************';
    this.AuthUserNameFormat = AuthUserNameFormat;
    this.AccountingServer   = AccountingServer;
    this.NasPortID          = NasPortID;
    this.AccountServer1     = AccountServer1;
    this.AccountServer2     = AccountServer2;
    this.DASServerPort      = DASServerPort;
    this.ServerMode         = ServerMode;
    this.SerDetName         = SerDetName;
    this.SerDetPass         = '**********************';
    this.SerDetPeriod       = SerDetPeriod;
}

function stRadiusvlan(domain,ClientAddress,SharedSecret)
{
    this.domain = domain;
    this.ClientAddress = ClientAddress;
    this.SharedSecret = "**********************";
}

var radiusinfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X.Radius.AuthorizationClient.{i},ClientAddress|SharedSecret,stRadiusvlan);%>;

var Radius = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X.Radius,Authserver1|SharedSecretAuth1|Authserver2|SharedSecretAuth2|AuthUserNameFormat|AccountingServer|NasPortID|AccountServer1|AccountServer2|DASServerPort|ServerMode|SerDetName|SerDetPass|SerDetPeriod,stRadius);%>;
var Radiu = Radius[0];

function stRadiusStats(domain,TransmittedRequestPackets,ReTransmittedRequestPackets,ReceivedChallengePackets,ReceivedAcceptPackets,ReceivedRejectPackets,ReceivedInvalidPackets,AccountReqPacketsSent,AccountReqPacketsResent,AccountRspRecevied,DisconnectReqRecevied,DisconnectACKSent,DisconnectNAKSent,ReceiveCoaRequestFrames,TransmittedCoaAckFrames,TransmittedCoaNackFrames)
{  
    this.domain                      = domain;
    this.TransmittedRequestPackets   = TransmittedRequestPackets;
    this.ReTransmittedRequestPackets = ReTransmittedRequestPackets;
    this.ReceivedChallengePackets    = ReceivedChallengePackets;
    this.ReceivedAcceptPackets       = ReceivedAcceptPackets;
    this.ReceivedRejectPackets       = ReceivedRejectPackets;
    this.ReceivedInvalidPackets      = ReceivedInvalidPackets;
    this.AccountReqPacketsSent       = AccountReqPacketsSent;
    this.AccountReqPacketsResent     = AccountReqPacketsResent;
    this.AccountRspRecevied          = AccountRspRecevied;
    this.DisconnectReqRecevied       = DisconnectReqRecevied;
    this.DisconnectACKSent           = DisconnectACKSent;
    this.DisconnectNAKSent           = DisconnectNAKSent;
    this.ReceiveCoaRequestFrames     = ReceiveCoaRequestFrames;
    this.TransmittedCoaAckFrames     = TransmittedCoaAckFrames;
    this.TransmittedCoaNackFrames    = TransmittedCoaNackFrames;
}

var RadiusStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X.Radius.Stats,TransmittedRequestPackets|ReTransmittedRequestPackets|ReceivedChallengePackets|ReceivedAcceptPackets|ReceivedRejectPackets|ReceivedInvalidPackets|AccountReqPacketsSent|AccountReqPacketsResent|AccountRspRecevied|DisconnectReqRecevied|DisconnectACKSent|DisconnectNAKSent|ReceiveCoaRequestFrames|TransmittedCoaAckFrames|TransmittedCoaNackFrames,stRadiusStats);%>;
var RadiusStat = RadiusStats[0];

var RadiusInfo = new Array();

for (var i=0;i<radiusinfo.length-1;i++)
{
    RadiusInfo.push(radiusinfo[i]);
}

function setControl(index)
{
    var radiusvlaninfo;
    selctIndex = index;
    if (index == -1)
    {
        radiusvlaninfo = new stRadiusvlan("","","");
        AddFlag = true;
        setDisplay('RadiusForm', 1);
        setCtlDisplay(radiusvlaninfo);
     }
    else if (index == -2)
    {
        setDisplay('RadiusForm', 0);
    }
    else
    {
        radiusvlaninfo = RadiusInfo[index];
        AddFlag = false;
        setDisplay('RadiusForm', 1);
        setCtlDisplay(radiusvlaninfo);
    }

    setDisable('btnSubmit',0);
    setDisable('CancelRadius',0);
}

function setCtlDisplay(radiusvlan)
{
    setText('RadiusIP',radiusvlan.ClientAddress);
    setText('RadiussharePassword',radiusvlan.SharedSecret);
}

function AddSubmitParam(SubmitForm,type)
{
    var url;
    
    SubmitForm.addParameter('x.Enable', getCheckVal("Enable"));
    SubmitForm.addParameter('x.VoiceNotCtrol', getCheckVal("VoiceVLANEnable"));    
    SubmitForm.addParameter('y.Authserver1', getElById("Authserver1").value);
    
    if (getValue("SharedSecretAuth1") != "**********************")
    {
        SubmitForm.addParameter('y.SharedSecretAuth1', getValue("SharedSecretAuth1"));
    }


    SubmitForm.addParameter('y.Authserver2', getElById("Authserver2").value);

    if (getValue("SharedSecretAuth2") != "**********************")
    {
        SubmitForm.addParameter('y.SharedSecretAuth2', getValue("SharedSecretAuth2"));
    }

    if (getValue("SerDetPass") != "**********************")
    {
        SubmitForm.addParameter('y.SerDetPass', getValue("SerDetPass"));
    }
    SubmitForm.addParameter('y.SerDetName', getValue("SerDetName"));
    SubmitForm.addParameter('y.SerDetPeriod', getValue("SerDetPeriod"));

    SubmitForm.addParameter('y.AuthUserNameFormat', getSelectVal("AuthUserNameFormat"));
    SubmitForm.addParameter('y.AccountServer1', getValue("chargingserber"));
    SubmitForm.addParameter('y.AccountServer2', getValue("chargingsecondserber"));
    SubmitForm.addParameter('y.DASServerPort', getValue("radiusport"));

    url = 'set.cgi?x=InternetGatewayDevice.X_HW_IEEE8021X' 
        + '&y=InternetGatewayDevice.X_HW_IEEE8021X.Radius' 
        + '&RequestFile=html/bbsp/8021x/8021x_global.asp';
                
    SubmitForm.setAction(url);
    
    setDisable('btnApplyEx', 1);
    setDisable('cancelValue', 1);
}


function SubmitRadius()
{
    var Form = new webSubmitForm();    
    var clientip = getValue("RadiusIP");
    var sharevalue = getValue("RadiussharePassword");
    var SubmitParaForm = "",url ="";
    if (!isValidIpAddress(clientip))
    {
        AlertEx("IP is invalid.")
        return false;
    }

    if (selctIndex == -1)
    {
        Form.addParameter('x.SharedSecret', sharevalue);

        url = "add.cgi?x=InternetGatewayDevice.X_HW_IEEE8021X.Radius.AuthorizationClient&RequestFile=html/bbsp/8021x/8021x_global.asp";
    }
    else
    {
        url = "set.cgi?x=" + RadiusInfo[selctIndex].domain +"&RequestFile=html/bbsp/8021x/8021x_global.asp";
        if (sharevalue != "**********************")
        {
            Form.addParameter('x.SharedSecret', sharevalue);
        }      
    }


    Form.addParameter('x.ClientAddress', clientip);

    Form.addParameter('x.X_HW_Token', getValue('hwonttoken'));

    Form.setAction(url);

    Form.submit();   

}

function OnDeleteButtonClick(TableID)
{
    var CheckBoxList = document.getElementsByName(TableName+'rml');
    var Form = new webSubmitForm();
    var Count = 0;
    for (var i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }
        
        Count++;
        Form.addParameter(CheckBoxList[i].value,'');
    }
    setDisable('DeleteButton',1);
    setDisable('btnSubmit',1);
    Form.addParameter('x.X_HW_Token', getValue('hwonttoken'));
    Form.setAction('del.cgi?'+'x=InternetGatewayDevice.X_HW_IEEE8021X.Radius.AuthorizationClient&RequestFile=html/bbsp/8021x/8021x_global.asp');
    Form.submit();
} 

function isSafeStringSN(val)
{
    for ( var j = 0 ; j < val.length ; j++ )
    {
        if ( !isSafeCharSN(val.charAt(j)) )
        {
            return false;
        }
    }

    return true;
}

function CheckUrlForm(URL)
{
    if (!isSafeStringSN(URL))
    {
        AlertEx(dot1x_global_language['dot1x_global_serverAdd'] + URL + dot1x_global_language['dot1x_global_s0d02']);
        return false;
    }

    if (!checkUrlPort(URL))
    {
        AlertEx(dot1x_global_language['dot1x_global_serverAdd'] + URL + dot1x_global_language['dot1x_global_s0d2d']);
        return false;
    }

    if ('' != isValidAscii(URL))
    {
        AlertEx(dot1x_global_language['dot1x_global_serverAdd'] + URL + dot1x_global_language['dot1x_global_s0d2e']);
        return false;
    }
    
    return true;
}

function CheckBillingParameter(str)
{
    if (str.split(":").length == 2)
    {
        var ipaddress = str.split(":")[0];
        var port = str.split(":")[1];
        if (!isValidIpAddress(ipaddress))
        {
            AlertEx(dot1x_global_language['dot1x_global_ipinvalid']);
            return false;
        }
        if (!isValidPort(port))
        {
            AlertEx(dot1x_global_language['dot1x_global_port1'] +'"'+ port + '"'+dot1x_global_language['dot1x_global_port2']);
            return false;
        }
    }
    else
    {
        AlertEx(dot1x_global_language['dot1x_global_address']);
        return false;        
    }
    return true;
}

function CheckChargingServer(str)
{
    var urlvalue = str;
    if (urlvalue.indexOf("://")  != -1)
    {
        var protocolvalue = urlvalue.split("://");
        if (protocolvalue[0].toUpperCase() != "UDP")
        {
            AlertEx(dot1x_global_language['dot1x_global_portorl']);
            return false;  
        }
        else
        {
            if (!CheckBillingParameter(protocolvalue[1]))
            {
                return false;
            }
        }
    }
    else
    {
        if (!CheckBillingParameter(urlvalue))
        {
            return false;
        }
        
    }
    return true;
}

function CheckForm()
{
    if (getCheckVal("Enable") == 0)
    {
        return true;
    }

    if (!CheckUrlForm(getElById("Authserver1").value))
    {
        return false;
    }

    if (getElById("Authserver1").value == '')
    {
        AlertEx(dot1x_global_language['dot1x_global_serverAdd'] + getElById("Authserver1").value + dot1x_global_language['dot1x_global_s0d01']);
        return false;
    }

    if (!CheckUrlForm(getElById("Authserver2").value))
    {
        return false;
    }
   
  
    if (!CheckChargingServer(getValue("chargingserber")))
    {
        return false;
    }
    if (getValue("chargingsecondserber") != "")
    {
        if (!CheckChargingServer(getValue("chargingsecondserber")))
        {
            return false;
        }        
    }

    if ((getValue("SerDetName") == "") != (getValue("SerDetPass") == ""))
    {
        AlertEx(dot1x_global_language['dot1x_global_Password_Waring']);
        return false;
    }

    var serDetPeriodValue = getValue("SerDetPeriod");
    if ((serDetPeriodValue != '') && (CheckNumber(serDetPeriodValue, 10, 600) == false)) {
        AlertEx(dot1x_global_language['dot1x_global_interval'] + dot1x_global_language['dot1x_global_intervalDesc']);
        return false;
    }

    var radiusPortValue = getValue("radiusport");
    if ((radiusPortValue != '') && (CheckNumber(radiusPortValue, 0, 65535) == false)) {
        AlertEx(dot1x_global_language['dot1x_global_radiusportinvalid']);
        return false;
    }

    setDisable('btnApplyEx', 1);
    setDisable('cancelValue', 1);
    return true;
}

function checkUrlPort(urlinfo)
{
    var url_values = urlinfo.split("://");

    if (url_values.length <= 1)
    {
        var port_value = urlinfo.split(":");

        if (port_value.length <= 1)
        {
            return true;
        }
        else
        {
            var othervalue = port_value[port_value.length-1].split("/");

            if (othervalue.length == 0)
            {
                return true;
            }

            if(true == isNull(othervalue[0]))
            {
                return false;
            }

            if(false == isNum(othervalue[0]))
            {
                return false;
            }

            var port = parseInt(othervalue[0], 10);
            if ((port >= 65536) || ( port < 1))
            {
                return false;
            }
            
            return true;
        }
    }
    else
    {
        var port_value = url_values[url_values.length-1].split(":");
        if (port_value.length <= 1)
        {
            return true;
        }

        var othervalue = port_value[port_value.length-1].split("/");
        if (othervalue.length == 0)
        {
            return true;
        }

        if(true == isNull(othervalue[0]))
        {
            return false;
        }

        if(false == isNum(othervalue[0]))
        {
            return false;
        }

        var port = parseInt(othervalue[0], 10);
        if ((port >= 65536) || ( port < 1))
        {
            return false;
        }
    }

    return true;
}

function displayDot1xsGlobal()
{
    setCheck('Enable', Dot1xsGlobal.Enable);
    setCheck('VoiceVLANEnable', Dot1xsGlobal.VoiceNotCtrol);

    setText('Authserver1', Radiu.Authserver1); 
    setText('SharedSecretAuth1',Radiu.SharedSecretAuth1);
    setText('Authserver2', Radiu.Authserver2);
    setText('SharedSecretAuth2', Radiu.SharedSecretAuth2);
    setSelect('AuthUserNameFormat', Radiu.AuthUserNameFormat);
    setText('chargingserber', Radiu.AccountServer1);
    setText('chargingsecondserber', Radiu.AccountServer2);
    setText('radiusport', Radiu.DASServerPort);

    setText('SerDetPass',Radiu.SerDetPass);
    setText('SerDetName',Radiu.SerDetName);
    setText('SerDetPeriod',Radiu.SerDetPeriod);

    SetDivValue("TransmittedRequestPackets",RadiusStat.TransmittedRequestPackets);

    SetDivValue("ReTransmittedRequestPackets",RadiusStat.ReTransmittedRequestPackets);

    SetDivValue("ReceivedChallengePackets",RadiusStat.ReceivedChallengePackets);

    SetDivValue("ReceivedAcceptPackets",RadiusStat.ReceivedAcceptPackets);

    SetDivValue("ReceivedRejectPackets",RadiusStat.ReceivedRejectPackets);

    SetDivValue("ReceivedInvalidPackets",RadiusStat.ReceivedInvalidPackets);

    SetDivValue("SendAccountPackets",RadiusStat.AccountReqPacketsSent);

    SetDivValue("RetrAccountPackets",RadiusStat.AccountReqPacketsResent);

    SetDivValue("ReceiveAccountPackets",RadiusStat.AccountRspRecevied);

    SetDivValue("ReceiveDisconnectPackets",RadiusStat.DisconnectReqRecevied);

    SetDivValue("SendACKPackets",RadiusStat.DisconnectACKSent);

    SetDivValue("SendNAKPackets",RadiusStat.DisconnectNAKSent);

    SetDivValue("ReceiveCoaRequestFrames",RadiusStat.ReceiveCoaRequestFrames);

    SetDivValue("TransmittedCoaAckFrames",RadiusStat.TransmittedCoaAckFrames);

    SetDivValue("TransmittedCoaNackFrames",RadiusStat.TransmittedCoaNackFrames);
}

function CancelConfig()
{
    LoadFrame();
}

function CancelRadiusConfig()
{
    setDisplay("RadiusForm",0);
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
<div id="ConfigForm">
<div id="PortConfig"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("wandhcpparatitle", GetDescFormArrayById(dot1x_global_language, "dot1x_global"), GetDescFormArrayById(dot1x_global_language, "dot1x_global_title"), false);
</script> 
<div class="func_spread"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="tabal_head">
        <td BindText='dot1x_global_RadiusConfig'>
        </td>
    </tr>
</table>
<table id="eth_status_table" width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr class="table_title">
        <td class="table_title width_per30" BindText='dot1x_global_Enable'></td>
        <td colspan="2" rowspan="1" class="table_right"> 
            <input id='Enable' type='checkbox' name='Enable'>
        </td> 
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_Authserver1'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='Authserver1' type='text' name='Authserver1' maxlength='128'  style="width:200px">
        </td>
        <td>
            <font color="red">*</font> 
            <span BindText="dot1x_global_Authservermh" class="gray"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_Authserver2'></td> 
        <td colspan="1" rowspan="1" class="table_right">
            <input id='Authserver2' type='text' name='Authserver2' maxlength='128'  style="width:200px"></td>
        <td>
            <span class="gray" BindText="dot1x_global_Authservermh"></span>
        </td>
    </tr>         
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_SharedSecretAuth1'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='SharedSecretAuth1' type='Password' name='SharedSecretAuth1' maxlength='25'  style="width:200px">
        </td>
        <td>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_SharedSecretAuth2'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='SharedSecretAuth2' type='Password' name='SharedSecretAuth2' maxlength='25'  style="width:200px">
        </td>
        <td>
        </td>
    </tr>     
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_chargingserver'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='chargingserber' type='text' name='chargingserber' maxlength='25'  style="width:200px">
        </td>
        <td>
            <font color="red">*</font>
            <span class="gray" BindText = "dot1x_global_Authservermh"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_chargsecondserver'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='chargingsecondserber' type='text' maxlength='128'  style="width:200px">
        </td>
        <td>
            <span class="gray" BindText = "dot1x_global_Authservermh"></span>
        </td>
    </tr>           
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_AuthUserNameFormat'></td>
        <td colspan="2" rowspan="1" class="table_right">
            <select name="AuthUserNameFormat" id="AuthUserNameFormat" style="width:200px"> 
                <option value=1>domain-no-included</option>  
                <option value=2>domain-included</option> 
            </select>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_VoiceVLANEnable'></td>
        <td colspan="2" rowspan="1" class="table_right">
            <input id='VoiceVLANEnable' type='checkbox' name='VoiceVLANEnable'>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_userName'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='SerDetName' type='text' maxlength='64'  style="width:200px">
        </td>
        <td>
            <span class="gray" BindText = "dot1x_global_userNameDesc"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_detectPassword'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='SerDetPass' type='Password' name='SerDetPass' maxlength='16'  style="width:200px">
        </td>
        <td>
            <span class="gray" BindText = "dot1x_global_detectPasswordDesc"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_interval'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='SerDetPeriod' type='text' maxlength='128'  style="width:200px">
        </td>
        <td>
            <span class="gray" BindText = "dot1x_global_intervalDesc"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_global_Raduisport'></td>
        <td colspan="1" rowspan="1" class="table_right">
            <input id='radiusport' type='text'  maxlength='128'  style="width:200px">
        </td>
        <td>
            <font color="red">*</font>
            <span class="gray" BindText = "dot1x_global_Raduisportmh"></span>
        </td>        
    </tr>          
</table>
<table cellpadding="0" cellspacing="1" width="100%" class="table_button"> 
    <tr> 
        <td class="width_per25" >
        </td> 
        <td class="table_submit">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
            <input id="btnApplyEx" name="btnApplyEx" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(2);" BindText ="dot1x_global_app">
            <input name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();" BindText = "dot1x_global_cancel">
        </td> 
    </tr> 
</table>
<div class="func_spread"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="tabal_head">
        <td BindText='dot1x_global_RadiusAuthorizedConfig'>
        </td>
    </tr>
</table>
<script language="JavaScript" type="text/javascript">
    var TableClass = new stTableClass("table_title width_per30", "table_right width_per70", "", "Select");    
    var RadiusConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),
                                    new stTableTileInfo("dot1x_global_Raduisip","align_center width_per25","ClientAddress",false,25),
                                        new stTableTileInfo("dot1x_global_Raduiskey","align_center width_per70 restrict_dir_ltr","SharedSecret",false,25),null);                               
    var ColumnNum = RadiusConfiglistInfo.length-1;
    var ShowButtonFlag = true;
    var TableDataInfo = HWcloneObject(RadiusInfo, 1);
    TableDataInfo.push(null);
    HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, RadiusConfiglistInfo, dot1x_global_language, null);
</script>
<form id = "RadiusForm" name = "RadiusForm" style="display:none">      
    <table border="0" cellpadding="0" cellspacing="1"  width="100%">
        <li   id="RadiusIP"           RealType="TextBox"            DescRef="dot1x_global_Raduisipmh"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.ClientAddress"   Elementclass="TextBoxLtr"  InitValue="Empty"  MaxLength="256"/>
        <li   id="RadiussharePassword"           RealType="TextBox"            DescRef="dot1x_global_Raduiskeymh"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.SharedSecret"   Elementclass="TextBoxLtr"   InitValue="Empty"  MaxLength="64"/>
    </table>
    <script>
        RadiusConfigFormList = HWGetLiIdListByForm("RadiusForm",null);
        HWParsePageControlByID("RadiusForm", TableClass, dot1x_global_language, null);
    </script>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button"> 
        <tr> 
            <td class='width_per25'>
            </td> 
            <td class="table_submit" > 
                <input id="btnSubmit" name="btnSubmit" type="button" class="ApplyButtoncss buttonwidth_50px" onClick="SubmitRadius();" BindText ="dot1x_global_app">
                <input name="CancelRadius" id="CancelRadius" type="button" class="CancleButtonCss buttonwidth_50px" onClick="CancelRadiusConfig();" BindText = "dot1x_global_cancel">
            </td>
        </tr> 
    </table> 
</form>
<div class="func_spread"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="tabal_head">
    <td BindText='dot1x_global_RadiusStatistics'></td>
    </tr>                  
</table>
<form id="PacketsinfoForm" name="PacketsinfoForm">
    <table id="deviceInfoFormPanel" width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
        <li id="TransmittedRequestPackets" RealType="HtmlText" DescRef="dot1x_global_TransmittedRequestPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.TransmittedRequestPackets" InitValue="Empty" />

        <li id="ReTransmittedRequestPackets" RealType="HtmlText" DescRef="dot1x_global_ReTransmittedRequestPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ReTransmittedRequestPackets" InitValue="Empty" />

        <li id="ReceivedChallengePackets" RealType="HtmlText" DescRef="dot1x_global_ReceivedChallengePackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ReceivedChallengePackets" InitValue="Empty" />

        <li id="ReceivedAcceptPackets" RealType="HtmlText" DescRef="dot1x_global_ReceivedAcceptPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ReceivedAcceptPackets" InitValue="Empty" />

        <li id="ReceivedRejectPackets" RealType="HtmlText" DescRef="dot1x_global_ReceivedRejectPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ReceivedRejectPackets" InitValue="Empty" />

        <li id="SendAccountPackets" RealType="HtmlText" DescRef="dot1x_global_SendAccountPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.AccountReqPacketsSent" InitValue="Empty" /> 

        <li id="RetrAccountPackets" RealType="HtmlText" DescRef="dot1x_global_RetrAccountPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.AccountReqPacketsResent" InitValue="Empty" /> 

        <li id="ReceiveAccountPackets" RealType="HtmlText" DescRef="dot1x_global_ReceiveAccountPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.AccountRspRecevied" InitValue="Empty" /> 

        <li id="ReceiveDisconnectPackets" RealType="HtmlText" DescRef="dot1x_global_ReceiveDisconnectPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DisconnectReqRecevied" InitValue="Empty" /> 

        <li id="SendACKPackets" RealType="HtmlText" DescRef="dot1x_global_SendACKPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DisconnectACKSent" InitValue="Empty" /> 

        <li id="SendNAKPackets" RealType="HtmlText" DescRef="dot1x_global_SendNAKPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DisconnectNAKSent" InitValue="Empty" />

        <li id="ReceivedInvalidPackets" RealType="HtmlText" DescRef="dot1x_global_ReceivedInvalidPackets" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ReceivedInvalidPackets" InitValue="Empty" />                

        <li id="ReceiveCoaRequestFrames" RealType="HtmlText" DescRef="dot1x_global_ReceiveCoaRequestFrames" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ReceiveCoaRequestFrames" InitValue="Empty" />                

        <li id="TransmittedCoaAckFrames" RealType="HtmlText" DescRef="dot1x_global_TransmittedCoaAckFrames" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.TransmittedCoaAckFrames" InitValue="Empty" />                

        <li id="TransmittedCoaNackFrames" RealType="HtmlText" DescRef="dot1x_global_TransmittedCoaNackFrames" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.TransmittedCoaNackFrames" InitValue="Empty" />                
    </table>
    <script>
        var TableClass2 = new stTableClass("table_title width_per70", "table_right width_per30", "", "Select");
        PackeConfigFormList = HWGetLiIdListByForm("PacketsinfoForm",null);
        HWParsePageControlByID("PacketsinfoForm",TableClass2,dot1x_global_language,null);    
    </script>
</form>
<div class="func_spread"></div>
</div>  
</div>  
<script>
    ParseBindTextByTagName(dot1x_global_language, "span", 1);
    ParseBindTextByTagName(dot1x_global_language, "input", 2);
    ParseBindTextByTagName(dot1x_global_language, "td", 1);
    ParseBindTextByTagName(dot1x_global_language, "div", 1);
</script> 
</body>
</html> 
       