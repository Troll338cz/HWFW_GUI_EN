<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<title></title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var appName = navigator.appName;
var selctOptionIndex = -1;
var UpportId = '<%HW_WEB_Upportid();%>';

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
        b.innerHTML = dot1x_port_language[b.getAttribute("BindText")];
    }
}

function TopoInfo(Domain, EthNum, SSIDNum)
{   
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;

function stLayer3Enable(domain, lay3enable)
{
    this.domain = domain;
    this.lay3enable = lay3enable;
}

var Lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 

function stPAE(domain,Enable,ActionRegister,AuthenticationMethod,GuestVlan,Restrictvlan,QuietPeriod,ServerRetryTimes,ServerTimeout,HandShakeEnable,HandShakePeriod,HandShakeTime,AuthLogicUnit,ReAuthEnable,ReAuthPeriod,PAEState,AuthenticationState,LastUpTime,CriticalVlan,MacBypassEnable,DynamicServiceVlan,RadiusAccountReportInterval,PreAuthAclID)
{
    this.domain               = domain;
    this.Enable               = Enable;
    this.ActionRegister       = ActionRegister;
    this.AuthenticationMethod = AuthenticationMethod;
    this.GuestVlan            = GuestVlan;
    this.Restrictvlan         = Restrictvlan;
    this.QuietPeriod          = QuietPeriod;
    this.ServerRetryTimes     = ServerRetryTimes;
    this.ServerTimeout        = ServerTimeout;
    this.HandShakeEnable      = HandShakeEnable;
    this.HandShakePeriod      = HandShakePeriod;
    this.HandShakeTime        = HandShakeTime;
    this.AuthLogicUnit        = AuthLogicUnit;
    this.ReAuthEnable         = ReAuthEnable;
    this.ReAuthPeriod         = ReAuthPeriod;
    this.PAEState             = PAEState;
    this.AuthenticationState  = AuthenticationState;
    this.LastUpTime           = LastUpTime;
	this.CriticalVlan         = CriticalVlan;
    this.MacBypassEnable      = MacBypassEnable;
    this.DynamicServiceVlan   = DynamicServiceVlan;
    this.RadiusAccountReportInterval = RadiusAccountReportInterval;
    this.PreAuthAclID         = PreAuthAclID;
}
var PAE = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X.PAE.{i}, Enable|ActionRegister|AuthenticationMethod|GuestVlan|Restrictvlan|QuietPeriod|ServerRetryTimes|ServerTimeout|HandShakeEnable|HandShakePeriod|HandShakeTime|AuthLogicUnit|ReAuthEnable|ReAuthPeriod|PAEState|AuthenticationState|LastUpTime|CriticalVlan|MacBypassEnable|DynamicServiceVlan|RadiusAccountReportInterval|PreAuthAclID, stPAE);%>;
var PAENum = 0;
var PAEInst = new Array();

function stPAEStats(domain,ReceivedFrames,TransmittedFrames,ReceivedStartFrames,ReceivedLogoffFrames,ReceivedInvalidFrames,ReceivedResponseIdFrames,ReceivedResponseFrames,TransmittedRequestIdFrames,TransmittedRequestFrames,ReceivedLengthErrorFrames,FallbackSuccessFrames,FallbackFailFrames)
{
    this.domain                     = domain;
    this.ReceivedFrames             = ReceivedFrames;
    this.TransmittedFrames          = TransmittedFrames;
    this.ReceivedStartFrames        = ReceivedStartFrames;
    this.ReceivedLogoffFrames       = ReceivedLogoffFrames;
    this.ReceivedInvalidFrames      = ReceivedInvalidFrames;
    this.ReceivedResponseIdFrames   = ReceivedResponseIdFrames;
    this.ReceivedResponseFrames     = ReceivedResponseFrames;
    this.TransmittedRequestIdFrames = TransmittedRequestIdFrames;
    this.TransmittedRequestFrames   = TransmittedRequestFrames;
    this.ReceivedLengthErrorFrames  = ReceivedLengthErrorFrames;
    this.FallbackSuccessFrames      = FallbackSuccessFrames;
    this.FallbackFailFrames         = FallbackFailFrames;
}

var PAEStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X.PAE.{i}.Stats, ReceivedFrames|TransmittedFrames|ReceivedStartFrames|ReceivedLogoffFrames|ReceivedInvalidFrames|ReceivedResponseIdFrames|ReceivedResponseFrames|TransmittedRequestIdFrames|TransmittedRequestFrames|ReceivedLengthErrorFrames|FallbackSuccessFrames|FallbackFailFrames, stPAEStats);%>;
var PAEStatInst = new Array();

for (var i = 0; i < PAE.length - 1; i++)  
{
    PAEInst[PAENum++] = PAE[i];
    PAEStatInst[i]    = PAEStats[i];
}

function stUserInfo(domain,UserName,DomainName,UserMac,UserIp,AccessTime,AuthState,RadiusVlan,AccessType,AclInfo)
{
    this.domain     = domain;
    this.UserName   = UserName;
    this.DomainName = DomainName;
    this.UserMac    = UserMac;
    this.UserIp     = UserIp;
    this.AccessTime = AccessTime;
    this.AuthState  = AuthState;
    this.RadiusVlan = RadiusVlan;
    this.AccessType = AccessType;
    this.AclInfo    = AclInfo;
}

var UserInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IEEE8021X.PAE.{i}.UserInfo.{i}, UserName|DomainName|UserMac|UserIp|AccessTime|AuthState|RadiusVlan|AccessType|AclInfo, stUserInfo);%>;

var UserInfoinst = new Array();

for (var j = 0; j < UserInfo.length - 1; j++)
{
    UserInfoinst[j] = UserInfo[j];
}

function AddSubmitParam(SubmitForm,type)
{
	
    var inst = selectedIndex + 1;
    SubmitForm.addParameter('x.Enable', getCheckVal("Enable"));
    SubmitForm.addParameter('x.ActionRegister', getSelectVal("ActionRegister"));
    SubmitForm.addParameter('x.AuthenticationMethod', getSelectVal("AuthenticationMethod"));    
    SubmitForm.addParameter('x.AuthLogicUnit', getSelectVal("AuthLogicUnit"));
    SubmitForm.addParameter('x.QuietPeriod', getElById("QuietPeriod").value);
    SubmitForm.addParameter('x.ServerRetryTimes', getElById("ServerRetryTimes").value);
    SubmitForm.addParameter('x.ServerTimeout', getElById("ServerTimeout").value); 
    SubmitForm.addParameter('x.HandShakeEnable', getCheckVal("HandShakeEnable"));
    SubmitForm.addParameter('x.HandShakeTime', getElById("HandShakeTime").value);
    SubmitForm.addParameter('x.HandShakePeriod', getElById("HandShakePeriod").value);	
    SubmitForm.addParameter('x.MacBypassEnable', getCheckVal("MacBypassEnable"));
    SubmitForm.addParameter('x.ReAuthEnable', getCheckVal("ReAuthEnable"));
    SubmitForm.addParameter('x.ReAuthPeriod', getElById("ReAuthPeriod").value);

    if(getValue("GuestVlan") == "")
    {
        SubmitForm.addParameter('x.GuestVlan', "65535");
    }
    else
    {
        SubmitForm.addParameter('x.GuestVlan', getValue("GuestVlan"));              
    }

    if(getValue("Restrictvlan") == "")
    {
        SubmitForm.addParameter('x.Restrictvlan', "65535"); 
    }
    else
    {                   
        SubmitForm.addParameter('x.Restrictvlan', getValue("Restrictvlan"));              
    }

	if(getElById("CriticalVlan").value == "")
	{
		SubmitForm.addParameter('x.CriticalVlan', "65535");	
	}
	else
	{					
		SubmitForm.addParameter('x.CriticalVlan', getElById("CriticalVlan").value);				
	}
	
    if (getValue("ChargingTimeing") == "")
    {
        SubmitForm.addParameter('x.RadiusAccountReportInterval', "600"); 
    }
    else
    {
        SubmitForm.addParameter('x.RadiusAccountReportInterval', getValue("ChargingTimeing"));                   
    }

    url = 'set.cgi?x=InternetGatewayDevice.X_HW_IEEE8021X.PAE.' + inst
                   + '&&RequestFile=html/bbsp/8021x/8021x_port.asp';
    
    SubmitForm.setAction(url);    
    setDisable('btnApply1', 1);
    setDisable('cancelValue', 1);
	
}

function CheckForm(type)
{
    if((getElById("GuestVlan").value < 0) || (getElById("GuestVlan").value > 4094))
    {
        AlertEx(dot1x_port_language['dot1x_port_GuestVlan'] +getElById("GuestVlan").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("Restrictvlan").value < 0) || (getElById("Restrictvlan").value > 4094))
    {
        AlertEx(dot1x_port_language['dot1x_port_Restrictvlan'] +getElById("Restrictvlan").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("CriticalVlan").value < 0) || (getElById("CriticalVlan").value > 4094))
    {	
        AlertEx(dot1x_port_language['dot1x_port_Criticalvlan'] +getElById("CriticalVlan").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("QuietPeriod").value < 1) || (getElById("QuietPeriod").value > 3600))
    {
        AlertEx(dot1x_port_language['dot1x_port_QuietPeriod'] +getElById("QuietPeriod").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("ServerRetryTimes").value < 1) || (getElById("ServerRetryTimes").value > 5))
    {
        AlertEx(dot1x_port_language['dot1x_port_ServerRetryTimes'] +getElById("ServerRetryTimes").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("ServerTimeout").value < 1) || (getElById("ServerTimeout").value > 20))
    {
        AlertEx(dot1x_port_language['dot1x_port_ServerTimeout'] +getElById("ServerTimeout").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("HandShakeTime").value < 1) || (getElById("HandShakeTime").value > 10))
    {
        AlertEx(dot1x_port_language['dot1x_port_HandShakeTime'] +getElById("HandShakeTime").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("HandShakePeriod").value < 1) || (getElById("HandShakePeriod").value > 86400))
    {
        AlertEx(dot1x_port_language['dot1x_port_HandShakePeriod'] +getElById("HandShakePeriod").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if((getElById("ReAuthPeriod").value < 1) || (getElById("ReAuthPeriod").value > 86400))
    {
        AlertEx(dot1x_port_language['dot1x_port_ReAuthPeriod'] +getElById("ReAuthPeriod").value + dot1x_port_language['dot1x_port_invalid']);
        return false;
    }
    if ((getValue("ChargingTimeing")<60 && getValue("ChargingTimeing") !=0 ) || getValue("ChargingTimeing")>36000)
    {
        AlertEx(dot1x_port_language['dot1x_port_BillingTimeing'] + '"' + getValue("ChargingTimeing") + '"'+ dot1x_port_language['dot1x_port_invalid']);
        return false;
    }    
    return true;
}

function LoadFrame()
{
    setDisplay('ConfigForm', 0);
    loadlanguage();
}


function setCtlDisplay(option)
{
}

var selectedIndex = -1;  

function PAEstatus(value)
{
    var paesatus = "";
    switch(value)
    {
        case "0":
            paesatus = dot1x_port_language["dot1x_port_Initialize"];
            break;
        case "1":
            paesatus = dot1x_port_language["dot1x_port_Disconnected"];
            break;
        case "2":
            paesatus = dot1x_port_language["dot1x_port_Connecting"];
            break;
        case "3":
            paesatus = dot1x_port_language["dot1x_port_Authenticating"];
            break;
        case "4":
            paesatus = dot1x_port_language["dot1x_port_Authenticated"];
            break;
        case "5":
            paesatus = dot1x_port_language["dot1x_port_Aborting"];
            break;
        case "6":
            paesatus = dot1x_port_language["dot1x_port_Held"];
            break;
        case "7":
            paesatus = dot1x_port_language["dot1x_port_Forceauth"];
            break;
        case "8":
            paesatus = dot1x_port_language["dot1x_port_Forceunauth"];
            break;
        case "9":
            paesatus = dot1x_port_language["Restart"];
            break;
        default:
            break;
    }
    return paesatus;    
}

function AuthLogicUnitSelect() 
{
    var ismac = getValue("AuthLogicUnit");
    if (ismac == 1) {
        setDisplay('userinfo', 0);
    } else {
        setDisplay('userinfo', 1);
    }
}

function InitAuthPapWarning()
{
  var AUTH_SELECT_PAP = 3
  var authMethod = getValue("AuthenticationMethod");
  if (authMethod != AUTH_SELECT_PAP) {
    setDisplay('papWarnText', 0);
    return;
  }

  var papwarn = document.getElementById("papWarnText");
  var warnText = dot1x_port_language['dot1x_port_PapWarn'];
  if (warnText == null) {
    return;
  }

  papwarn.innerHTML = warnText
  setDisplay('papWarnText', 1);
  return;
}

function OnSelectPapWarning()
{
  var AUTH_SELECT_PAP = 3
  var authMethod = getValue("AuthenticationMethod");
  if (authMethod != AUTH_SELECT_PAP) {
    return;
  }

  var alertText = dot1x_port_language['dot1x_port_PapAlert'];
  if (alertText == null) {
    return;
  }

  alert(alertText);
}

function setControl(index)
{
    var option1;
    selctOptionIndex = index;
    var uindex = 0;
	
    if (index == -1)
    {
        setDisplay('ConfigForm', 1);
    }
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
    else
    {		
        option1 = "InternetGatewayDevice.X_HW_IEEE8021X.PAE." +(index+1);
		for ( var i = 0; i < PAENum; i++)
		{
			
			if (PAEInst[i].domain == option1 )
			{				
				if(Lay3Enables.length > i && Lay3Enables[i] != null && Lay3Enables[i].lay3enable == 1)
				{   
				    AlertEx(dot1x_port_language['dot1x_port_layer3']);
					setDisplay('ConfigForm', 0);
				}
				else
				{
                    setDisplay('ConfigForm', 1);
				}
				
				
			    setCheck('Enable', PAEInst[i].Enable);
				setCheck('MacBypassEnable', PAEInst[i].MacBypassEnable);
		        setSelect('ActionRegister', PAEInst[i].ActionRegister);
                setSelect('AuthenticationMethod', PAEInst[i].AuthenticationMethod);
				setSelect('AuthLogicUnit', PAEInst[i].AuthLogicUnit);
                
                AuthLogicUnitSelect();
                InitAuthPapWarning();

				if(PAEInst[i].GuestVlan == 65535)
				{
					setText('GuestVlan', "");
				}
				else
				{
					setText('GuestVlan', PAEInst[i].GuestVlan);
				}
				
				if(PAEInst[i].Restrictvlan == 65535)
				{
					setText('Restrictvlan', "");
				}
				else
				{
					setText('Restrictvlan', PAEInst[i].Restrictvlan);
				}	
				if(PAEInst[i].CriticalVlan == 65535)
				{					
					setText('CriticalVlan', "");					
				}
				else
				{					
					setText('CriticalVlan', PAEInst[i].CriticalVlan);					
				}
				
				setText('QuietPeriod', PAEInst[i].QuietPeriod);
				setText('ServerRetryTimes', PAEInst[i].ServerRetryTimes);
				setText('ServerTimeout', PAEInst[i].ServerTimeout);
				setCheck('HandShakeEnable', PAEInst[i].HandShakeEnable);
				setText('HandShakeTime', PAEInst[i].HandShakeTime);
				setText('HandShakePeriod', PAEInst[i].HandShakePeriod);				
				
                setCheck('ReAuthEnable', PAEInst[i].ReAuthEnable);
                setText("ReAuthPeriod",PAEInst[i].ReAuthPeriod);

                if(PAEInst[i].AuthLogicUnit == 1)
                {
                    SetDivValue("PAEState",PAEstatus(PAEInst[i].PAEState));
                    SetDivValue("LastUpTime",PAEInst[i].LastUpTime);
                } else
                {
                    SetDivValue("PAEState",'-');
                    SetDivValue("LastUpTime",'-');
                }

                if (PAEInst[i].PreAuthAclID > 65535)
                {
                    SetDivValue("PreAuthAclID","-");
                } else 
                {
                    SetDivValue("PreAuthAclID",PAEInst[i].PreAuthAclID);
                }				
													
				if(PAEInst[i].DynamicServiceVlan == 65535)
				{
                    SetDivValue("DynamicServiceVlan","-");					
				}
				else
				{	
                    SetDivValue("DynamicServiceVlan",PAEInst[i].DynamicServiceVlan);										
				}

                setText("ChargingTimeing",PAEInst[i].RadiusAccountReportInterval); 

                SetDivValue("ReceivedFrames",PAEStatInst[i].ReceivedFrames);		

                SetDivValue("ReceivedStartFrames",PAEStatInst[i].ReceivedStartFrames);

                SetDivValue("ReceivedLogoffFrames",PAEStatInst[i].ReceivedLogoffFrames);

                SetDivValue("ReceivedInvalidFrames",PAEStatInst[i].ReceivedInvalidFrames);

                SetDivValue("ReceivedResponseIdFrames",PAEStatInst[i].ReceivedResponseIdFrames);

                SetDivValue("ReceivedResponseFrames",PAEStatInst[i].ReceivedResponseFrames);

                SetDivValue("ReceivedLengthErrorFrames",PAEStatInst[i].ReceivedLengthErrorFrames);

                SetDivValue("TransmittedFrames",PAEStatInst[i].TransmittedFrames);

                SetDivValue("TransmittedRequestIdFrames",PAEStatInst[i].TransmittedRequestIdFrames);

                SetDivValue("TransmittedRequestFrames",PAEStatInst[i].TransmittedRequestFrames);

                //每个pae下最多4个用户
                for (var uindex = 0; uindex < 4; uindex++) {
                    option2 = "InternetGatewayDevice.X_HW_IEEE8021X.PAE." +(index+1) +".UserInfo." +(uindex+1);
                    for (var k = 0; k < UserInfo.length - 1; k++) {
                        if (UserInfoinst[k].domain == option2) {

                            var username = "Username" + (uindex+1);

                            var domainname = "Domainname" + (uindex+1);

                            var usermac = "Usermac" + (uindex+1);

                            var userip = "Userip" + (uindex+1);

                            var radiusassignvlan = "Radiusassignvlan" + (uindex+1);

                            var authenticationState = "AuthenticationState" + (uindex+1);

                            var useraccesstime = "Useraccesstime" + (uindex+1);

                            var useraccesstype = "Useraccesstype" + (uindex+1);

                            var dynamicacldesc = "Dynamicacldesc" + (uindex+1);

                            SetDivValue(username, htmlencode(UserInfoinst[k].UserName));
                            SetDivValue(domainname,UserInfoinst[k].DomainName);
                            SetDivValue(usermac,UserInfoinst[k].UserMac);
                            SetDivValue(userip,UserInfoinst[k].UserIp);
                            SetDivValue(radiusassignvlan,UserInfoinst[k].RadiusVlan);
                            SetDivValue(useraccesstime,UserInfoinst[k].AccessTime);

                            if (UserInfoinst[k].RadiusVlan == 65535)
                            {
                                SetDivValue(radiusassignvlan,"-");
                            }

                            if (UserInfoinst[k].AuthState == 1)
                            {
                                SetDivValue(authenticationState,"Authorized");
                            } else {
                                SetDivValue(authenticationState,"Unauthorized");
                            }

                            if (UserInfoinst[k].AccessType == 0)
                            {
                                SetDivValue(useraccesstype,"dot1x");
                            } else {
                                SetDivValue(useraccesstype,"mab");
                            }

                            var a = UserInfoinst[k].AclInfo.split("#");
                            
                            var aclinfo = "";
                            
                            for (var aclnum = 0; aclnum < a.length - 1; aclnum++) {

                                a[aclnum] = a[aclnum].replace("$","");

                                aclinfo += "NO." + (aclnum + 1) + ": " + a[aclnum] + "<br/>";
                            }

                            SetDivValue(dynamicacldesc,aclinfo);
                        }
                    }
                }
                UserTableControl(index);

				selectedIndex = i;	
				
			}
		}
	}
	
    setDisable('btnApply1', 0);
    setDisable('cancelValue', 0);
}

function UserTableControl(index)
{
    var num = 0;
    var pindex = index + 1;
    var tempPath = "InternetGatewayDevice.X_HW_IEEE8021X.PAE." + pindex;

    for (var tempIndex = 0; tempIndex < UserInfoinst.length; ++tempIndex) {
        var tempUserInfo = UserInfoinst[tempIndex];
        if (tempUserInfo.domain.indexOf(tempPath) != -1) {
            num++;
        }
    }
    TableDisplay(num);
}

function TableDisplay(num)
{
    switch(num)
    {
        case 0:
            setDisplay("usertable1",0);
            setDisplay("usertable2",0);
            setDisplay("usertable3",0);
            setDisplay("usertable4",0);
            break;
        case 1:
            setDisplay("usertable1",1);
            setDisplay("usertable2",0);
            setDisplay("usertable3",0);
            setDisplay("usertable4",0);
            break;
        case 2:
            setDisplay("usertable1",1);
            setDisplay("usertable2",1);
            setDisplay("usertable3",0);
            setDisplay("usertable4",0);
            break;
        case 3:
            setDisplay("usertable1",1);
            setDisplay("usertable2",1);
            setDisplay("usertable3",1);
            setDisplay("usertable4",0);
            break;
        default:
            setDisplay("usertable1",1);
            setDisplay("usertable2",1);
            setDisplay("usertable3",1);
            setDisplay("usertable4",1);
            break;
    }
}

function CancelConfig()
{
    setDisplay("ConfigForm", 0);
    LoadFrame();
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<form id="CoForm" action="../application/set.cgi"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("wandhcpparatitle", GetDescFormArrayById(dot1x_port_language, "dot1x_port"), GetDescFormArrayById(dot1x_port_language, "dot1x_port_title"), false);
</script> 
<div class="title_spread"></div>
<table class="tabal_bg" id="POEOptionInst" width="100%"  cellpadding="0" cellspacing="1"> 
  <tr class="head_title"> 
    <td class="tabal_left width_15p"  BindText='dot1x_port_port'></td> 
    <td class="tabal_left width_15p" BindText='dot1x_port_Enable1'></td>  
	<td class="tabal_left width_15p" BindText='dot1x_port_MACBypassEnable1'></td> 
    <td class="tabal_left width_20p" BindText='dot1x_port_ActionRegister1'></td>  
    <td class="tabal_left width_25p"  BindText='dot1x_port_AuthenticationMethod1'></td>
    <td class="tabal_left width_25p"  BindText='dot1x_port_AuthLogicUnit1'></td>
    <td class="tabal_left width_25p" BindText='dot1x_port_AuthenticationState1'></td>
  </tr> 
    <script language="JavaScript" type="text/javascript">
        if (PAENum == 0)
        {
            document.write('<TR id="record_no"' +' class="tabal_center01 " onclick="selectLine(this.id);">');
            document.write('<TD >--</TD>');
            document.write('<TD >--</TD>');
            document.write('<TD >--</TD>');
            document.write('<TD >--</TD>');
            document.write('<TD >--</TD>');
            document.write('<TD >--</TD>');
            document.write('<TD >--</TD>');
            document.write('</TR>');
        }
        else
        {
            for (var i = 0; i < PAENum; i++) 
            {
                if (i >= TopoInfo.EthNum || (i+1) == UpportId)
                {
                    setDisplay("record_" + i, 0);					
                }
                else
                {
                    var seq = i+1;					
                    document.write('<TR id="record_' + i +'" value="' + PAEInst[i].domain +'" class="tabal_center01 restrict_dir_ltr" onclick="selectLine(this.id);">');

                    document.write('<TD >' + "LAN" + seq + '</TD>');					
                    if(PAEInst[i].Enable == 1)
                    {
                        document.write('<TD >enable</TD>');
                    }
                    else
                    {
                        document.write('<TD >disable</TD>'); 
                    }	
					if(PAEInst[i].MacBypassEnable == 1)
                    {
                        document.write('<TD >enable</TD>');
                    }
                    else
                    {
                        document.write('<TD >disable</TD>'); 
                    }
                    if(PAEInst[i].ActionRegister == 1)
                    {
                        document.write('<TD >' + dot1x_port_language['dot1x_port_control1'] + '</TD>');
                    }
                    else if(PAEInst[i].ActionRegister == 2)
                    {
                        document.write('<TD >' + dot1x_port_language['dot1x_port_control3'] + '</TD>'); 
                    }
                    else
                    {
                        document.write('<TD >' + dot1x_port_language['dot1x_port_control2'] + '</TD>'); 
                    }
                    
                    if(PAEInst[i].AuthenticationMethod == 1)
                    {
                        document.write('<TD >EAP</TD>');
                    }
                    else if(PAEInst[i].AuthenticationMethod == 2)
                    {
                        document.write('<TD >CHAP</TD>'); 
                    }
                    else
                    {
                        document.write('<TD >PAP</TD>'); 
                    }

                    if(PAEInst[i].AuthLogicUnit == 1)
                    {
                        document.write('<TD >PORT</TD>');
                        document.write('<TD >' + PAEstatus(PAEInst[i].PAEState) + '</TD>');
                    }
                    else
                    {
                        document.write('<TD >MAC</TD>'); 
                        document.write('<TD >-</TD>');
                    }

                    document.write('</TR>');					
                }				
            }			
        }
    </script> 
</table> 
<div class="func_spread"></div>
<div id="ConfigForm" > 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="tabal_head">
    <td BindText='dot1x_port_Config'></td>
    </tr>                  
</table>
<table cellpadding="0" cellspacing="1" width="100%" class="tabal_bg">
    <tr class="table_title">
        <td class="table_title width_25p" BindText='dot1x_port_Enable'></td>
        <td class="table_right width_25p"> 
            <input id='Enable' type='checkbox' name='Enable'></span>
        </td> 
    </tr>
    <tr class="table_title">
        <td class="table_title width_25p" BindText='dot1x_port_MACBypassEnable'></td>
        <td class="table_right width_25p"> 
            <input id='MacBypassEnable' type='checkbox' name='MacBypassEnable'>
        </td> 
    </tr>    
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_ActionRegister'></td>
        <td class="table_right">
            <select name="ActionRegister" id="ActionRegister" style="width:200px"> 
                <option value=1 ><script>document.write(dot1x_port_language['dot1x_port_control1']);</script></option>
                <option value=2 ><script>document.write(dot1x_port_language['dot1x_port_control3']);</script></option> 
                <option value=3 ><script>document.write(dot1x_port_language['dot1x_port_control2']);</script></option> 
            </select>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_AuthenticationMethod'></td>
        <td class="table_right">
            <select name="AuthenticationMethod" id="AuthenticationMethod" style="width:200px" onChange='OnSelectPapWarning(this.value)'>
                <option value=1 >EAP</option>  
                <option value=2 >CHAP</option>
                <option value=3 >PAP</option> 
            </select>
            <font color="red" id="papWarnText" ></font>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_AuthLogicUnit'></td>
        <td class="table_right">
            <select name="AuthLogicUnit" id="AuthLogicUnit" style="width:200px" onChange='AuthLogicUnitSelect(this.value)'> 
                <option value=1 >PORT</option>  
                <option value=2 >MAC</option>
            </select>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_GuestVlan'></td>
        <td class="table_right">
            <input id='GuestVlan' type='text' name='GuestVlan' maxlength='256'  style="width:200px">
            <span class="gray" BindText="dot1x_port_vlanmh"></span>
        </td>
    </tr> 
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_Restrictvlan'></td>
        <td class="table_right">
            <input id='Restrictvlan' type='text' name='Restrictvlan' maxlength='256'  style="width:200px">
            <span class="gray" BindText="dot1x_port_vlanmh"></span>
        </td>
    </tr> 
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_Criticalvlan'></td>
        <td class="table_right">
            <input id='CriticalVlan' type='text' name='CriticalVlan' maxlength='256'  style="width:200px">
            <span class="gray" BindText="dot1x_port_vlanmh"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_Dynamicservicevlan'></td>
        <td class="table_right" id='DynamicServiceVlan'></td>
    </tr> 
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_QuietPeriod'></td>
        <td class="table_right">
            <input id='QuietPeriod' type='text' name='QuietPeriod' maxlength='256'  style="width:200px"> 
            <font color="red">*</font> 
            <span class="gray" BindText="dot1x_port_QuietPeriodmh"></span>
        </td>
    </tr> 
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_ServerRetryTimes'></td> 
        <td class="table_right">
            <input id='ServerRetryTimes' type='text' name='ServerRetryTimes' maxlength='256'  style="width:200px">
            <font color="red">*</font> 
            <span class="gray" BindText="dot1x_port_ServerRetryTimesmh"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_ServerTimeout'></td>
        <td class="table_right">
            <input id='ServerTimeout' type='text' name='ServerTimeout' maxlength='256'  style="width:200px">
            <font color="red">*</font> 
            <span class="gray" BindText="dot1x_port_ServerTimeoutmh"></span>
        </td>
    </tr>
    <tr class="table_title width_per25">
        <td class="table_title" BindText='dot1x_port_HandShakeEnable'></td>
        <td class="table_right"> 
            <input id='HandShakeEnable' type='checkbox' name='HandShakeEnable'>
        </td> 
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_HandShakeTime'></td>
        <td class="table_right">
            <input id='HandShakeTime' type='text' name='HandShakeTime' maxlength='256'  style="width:200px">
            <font color="red">*</font> 
            <span class="gray" BindText="dot1x_port_HandShakeTimeml"></span>
        </td> 
    </tr>   
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_HandShakePeriod'></td>
        <td class="table_right">
            <input id='HandShakePeriod' type='text' name='HandShakePeriod' maxlength='256'  style="width:200px">
            <font color="red">*</font> 
            <span class="gray" BindText="dot1x_port_HandShakePeriodmh"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText='dot1x_port_ChargingTimeing'></td>
        <td class="table_right">
            <input id='ChargingTimeing' type='text' name='ChargingTimeing' maxlength='256'  style="width:200px">
            <font color="red">*</font> 
            <span class="gray" BindText="dot1x_port_ChargingTimeingl"></span>
        </td> 
    </tr>     
    <tr class="table_title width_per25">
        <td class="table_title" BindText='dot1x_port_ReAuthEnable'></td>
        <td class="table_right">
            <input id='ReAuthEnable' type='checkbox' name='ReAuthEnable'></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReAuthPeriod"></td>
        <td class="table_right">
            <input id='ReAuthPeriod' type='text' name='ReAuthPeriod' maxlength='256'  style="width:200px">
            <span class="gray" BindText="dot1x_port_ReAuthPeriodmh"></span>
        </td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_AuthenticationState"></td>
        <td class="table_right width_per70" id='PAEState'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_PreAuthAclID"></td>
        <td class="table_right" id='PreAuthAclID'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_LastUpTime"></td>
        <td class="table_right" id='LastUpTime'></td>
    </tr>
</table>
<table cellpadding="0" cellspacing="1" width="100%" class="table_button"> 
    <tr> 
        <td class="width_per25" >
        </td> 
        <td class="table_submit">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
            <input id="btnApply1" name="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(2);" BindText="dot1x_port_app"> 
            <input name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();" BindText="dot1x_port_cancel"> 
        </td> 
    </tr> 
</table> 
<div id="userinfo">
<div class="func_spread"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="tabal_head">
        <td BindText='dot1x_port_Userinfo'></td>
    </tr>                  
</table>

<table id="usertable1" cellpadding="0" cellspacing="1" width="100%" class="tabal_bg"> 
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Username"></td>
        <td class="table_right width_per80" id='Username1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Domainname"></td>
        <td class="table_right" id='Domainname1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Usermac"></td>
        <td class="table_right" id='Usermac1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Userip"></td>
        <td class="table_right" id='Userip1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Radiusassignvlan"></td>
        <td class="table_right" id='Radiusassignvlan1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_AuthenticationState"></td>
        <td class="table_right" id='AuthenticationState1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstime"></td>
        <td class="table_right" id='Useraccesstime1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstype"></td>
        <td class="table_right" id='Useraccesstype1'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Dynamicacldesc"></td>
        <td class="table_right" id='Dynamicacldesc1'></td>
    </tr>
 </table>

 <div class="func_spread"></div>
 <table id="usertable2" cellpadding="0" cellspacing="1" width="100%" class="tabal_bg"> 
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Username"></td>
        <td class="table_right width_per80" id='Username2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Domainname"></td>
        <td class="table_right" id='Domainname2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Usermac"></td>
        <td class="table_right" id='Usermac2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Userip"></td>
        <td class="table_right" id='Userip2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Radiusassignvlan"></td>
        <td class="table_right" id='Radiusassignvlan2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_AuthenticationState"></td>
        <td class="table_right" id='AuthenticationState2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstime"></td>
        <td class="table_right" id='Useraccesstime2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstype"></td>
        <td class="table_right" id='Useraccesstype2'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Dynamicacldesc"></td>
        <td class="table_right" id='Dynamicacldesc2'></td>
    </tr>
 </table>

 <div class="func_spread"></div>
 <table id="usertable3" cellpadding="0" cellspacing="1" width="100%" class="tabal_bg"> 
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Username"></td>
        <td class="table_right width_per80" id='Username3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Domainname"></td>
        <td class="table_right" id='Domainname3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Usermac"></td>
        <td class="table_right" id='Usermac3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Userip"></td>
        <td class="table_right" id='Userip3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Radiusassignvlan"></td>
        <td class="table_right" id='Radiusassignvlan3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_AuthenticationState"></td>
        <td class="table_right" id='AuthenticationState3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstime"></td>
        <td class="table_right" id='Useraccesstime3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstype"></td>
        <td class="table_right" id='Useraccesstype3'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Dynamicacldesc"></td>
        <td class="table_right" id='Dynamicacldesc3'></td>
    </tr>
 </table>

 <div class="func_spread"></div>
 <table id="usertable4" cellpadding="0" cellspacing="1" width="100%" class="tabal_bg"> 
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Username"></td>
        <td class="table_right width_per80" id='Username4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Domainname"></td>
        <td class="table_right" id='Domainname4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Usermac"></td>
        <td class="table_right" id='Usermac4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Userip"></td>
        <td class="table_right" id='Userip4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Radiusassignvlan"></td>
        <td class="table_right" id='Radiusassignvlan4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_AuthenticationState"></td>
        <td class="table_right" id='AuthenticationState4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstime"></td>
        <td class="table_right" id='Useraccesstime4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Useraccesstype"></td>
        <td class="table_right" id='Useraccesstype4'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_Dynamicacldesc"></td>
        <td class="table_right" id='Dynamicacldesc4'></td>
    </tr>
 </table>

</div>

 <div class="func_spread"></div>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr class="tabal_head">
         <td BindText='dot1x_port_Statistics'></td>
     </tr>                  
 </table>

<table cellpadding="0" cellspacing="1" width="100%" class="tabal_bg"> 
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedFrames"></td>
        <td class="table_right width_per60" id='ReceivedFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedStartFrames"></td>
        <td class="table_right" id='ReceivedStartFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedLogoffFrames"></td>
        <td class="table_right" id='ReceivedLogoffFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedInvalidFrames"></td>
        <td class="table_right" id='ReceivedInvalidFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedResponseIdFrames"></td>
        <td class="table_right" id='ReceivedResponseIdFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedResponseFrames"></td>
        <td class="table_right" id='ReceivedResponseFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_ReceivedLengthErrorFrames"></td>
        <td class="table_right" id='ReceivedLengthErrorFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_TransmittedFrames"></td>
        <td class="table_right" id='TransmittedFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_TransmittedRequestIdFrames"></td>
        <td class="table_right" id='TransmittedRequestIdFrames'></td>
    </tr>
    <tr class="table_title">
        <td class="table_title" BindText="dot1x_port_TransmittedRequestFrames"></td>
        <td class="table_right" id='TransmittedRequestFrames'></td>
    </tr>
 </table>
<div class="func_spread"></div>
</div>
</form>
<script>
    ParseBindTextByTagName(dot1x_port_language, "span", 1);
    ParseBindTextByTagName(dot1x_port_language, "input", 2);
    ParseBindTextByTagName(dot1x_port_language, "td", 1);
    ParseBindTextByTagName(dot1x_port_language, "div", 1);
</script> 
</body>
</html>