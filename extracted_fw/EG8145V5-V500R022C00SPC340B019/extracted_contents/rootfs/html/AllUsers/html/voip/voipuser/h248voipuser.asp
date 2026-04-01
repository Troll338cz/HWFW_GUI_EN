<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>VOIP User</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248user, sipuser);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/srvnummapping_list.asp"></script>
<script language="javascript" src="../common/voip_disableallelement.asp"></script>
<style>
.TextBox
{
width:150px;  
}

.Select
{
width:157px;  
}
	
.impedancetextareaclass
{
	font-size:11px;
	width:99%;
}

.impedancetextclass
{
	font-size:12px;
	width:80%;
	color:#767676;	
}

.selectdefcss
{
width:150px;
}

.interfacetextclass{
	width:300px;
	height:50px;
	color:black;
}
.interfacerosgametextclass{
    width:300px;
    height:50px;
    color:white;
}


</style>

<script language="JavaScript" type="text/javascript">
var selctIndex = -1;
var selctLindex = 0;
var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";
var rosUnionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

var BhartiMode = 0;
if (CfgMode.toUpperCase() == 'BHARTI')
{
    BhartiMode = 1;
}

var RussianMode = 0;
if (CfgMode.toUpperCase() == 'ROSUNION')
{
    RussianMode = 1;
}

function stLine(Domain, Enable, PhyReferenceList )
{
    this.Domain = Domain;
    this.PhyReferenceList = PhyReferenceList;

    if (Enable.toLowerCase() == 'enabled')
    {
        this.Enable = 1;
    }
    else
    {
        this.Enable = 0;
    }     
    
    this.LineName = '';
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i},Enable|PhyReferenceList,stLine);%>;
var Line = new Array();
for (var i = 0; i < AllLine.length-1; i++)
    Line[i] = AllLine[i];

function stLineName(Domain, LineName)
{
    this.Domain = Domain;
    this.LineName = LineName;
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllLineName = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i}.X_HW_H248,LineName,stLineName);%>;
var LineName = new Array();
for (var i = 0; i < AllLineName.length-1; i++)
    LineName[i] = AllLineName[i];

AssociateParam(Line, LineName, 'LineName');

var recordLineName;

function SelectLineRecord(index)
{	
	selctLindex = index;
	setPhyList("PhyList");
    setPhyInterfaceParams();
    setDspTemplatePara();
}

function stRtpExtend(Domain, EchoCancellationEnable,OffhookDtasAckInterval)
{
    this.Domain = Domain;
    this.EchoCancellationEnable = EchoCancellationEnable;
	this.OffhookDtasAckInterval = OffhookDtasAckInterval;
}
var RtpExtendAlls = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP.X_HW_Extend, EchoCancellationEnable|OffhookDtasAckInterval, stRtpExtend);%>;
var RtpExtendAll = RtpExtendAlls[0];

function stFaxT38(Domain,Enable)
{
    this.Domain = Domain;
    this.Enable = Enable;
}
var FaxT38s = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.FaxT38,Enable,stFaxT38);%>;
var FaxT38 = FaxT38s[0];

function stFaxModem(Domain,FaxNego)
{
    this.Domain = Domain;
    this.FaxNego = FaxNego;
}
var FaxModems = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_FaxModem,FaxNego,stFaxModem);%>;
var FaxModem = FaxModems[0];

function stH248Extend(Domain,ProfileIndex,SoftwareParameters,Topversion,HeartBeatTimer,HeartBeatRetransTimer,HeartBeatRetransTimes)
{
    this.Domain = Domain;
    this.ProfileIndex = ProfileIndex;
    this.SoftwareParameters = SoftwareParameters;
    this.Topversion = Topversion;
	this.HeartBeatTimer = HeartBeatTimer;
	this.HeartBeatRetransTimer = HeartBeatRetransTimer;
	this.HeartBeatRetransTimes = HeartBeatRetransTimes;
}
var H248Extends = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Extend,ProfileIndex|SoftwareParameters|Topversion|HeartBeatTimer|HeartBeatRetransTimer|HeartBeatRetransTimes|,stH248Extend);%>;
var H248Extend = H248Extends[0];


function stH248(Domain,HeartbeatMode)
{
    this.Domain = Domain;
    this.HeartbeatMode = HeartbeatMode;
}
var H248s =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248,HeartbeatMode,stH248);%>;
var H248 = H248s[0];

function stH248Profile(Domain,ProfileBody)
{   
    this.Domain = Domain;
    this.ProfileBody = ProfileBody;
}
var H248Profiles = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Profile,ProfileBody,stH248Profile);%>;
var H248Profile = H248Profiles[0];

function stH248DigitMap(domain, DigitMapStartTimer, DigitMapShortTimer, DigitMapLongTimer)
{
    this.Domain = domain;
    this.DigitMapStartTimer = DigitMapStartTimer;
    this.DigitMapShortTimer = DigitMapShortTimer;
	this.DigitMapLongTimer = DigitMapLongTimer;
}
var H248DigitMapParas = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Digitmap,DigitMapStartTimer|DigitMapShortTimer|DigitMapLongTimer,stH248DigitMap);%>;
var H248DigitMapPara = H248DigitMapParas[0];

function stDspGain(Domain, TransmitGain, ReceiveGain)
{
    this.Domain = Domain;
	this.TransmitGain = TransmitGain;
    this.ReceiveGain = ReceiveGain;
}	
	
var AllDspGain = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i}.VoiceProcessing, TransmitGain|ReceiveGain, stDspGain);%>;

var DspGainList = new Array();
for (var i = 0; i < AllDspGain.length-1; i++)
    DspGainList[i] = AllDspGain[i];	
	
function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
    this.InterfaceID = InterfaceID;
}
var AllPhyInterfaces = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

function setPhyList(objname)
{
	if (-2 == selctLindex)
	{
		return;
	}
	var PhyPortList = Line[selctLindex].PhyReferenceList;
    var selectObj = getElement(objname);
    var tempList;

    removeAllOption(objname);

    if(PhyPortList.length == 0)
    {
        setDisplay("voipadv3",0);
        return;
    }
    
    tempList = PhyPortList.split(',');
    if(tempList.length > 1)
    {
        setDisable('PhyList',0);
    }
    else
    {
        setDisable('PhyList',1);
    }
    setDisplay("voipadv3",1);
    if(selectObj != null)
    {
        for(var i=0;i< tempList.length;i++)
        {
            var opt = document.createElement("option");
            opt.setAttribute("value",tempList[i]);
            opt.innerHTML = tempList[i];
            selectObj.appendChild(opt);
        }
    }
	
	if(selectObj.options.length > 0)
	{
		try
		{
			selectObj.options[0].selected = true;
		}
		catch(ex)
		{
			
		}
	}
	
  
}

function ShowTab(index, LineName,PhyReferenceList)
{
	this.index = index;
	this.LineName = LineName;
	this.PhyReferenceList = PhyReferenceList;
}

function stPhyInterfaceParam(Domain,HookFlashDownTime,HookFlashUpTime,OnhookConfirmTime,Impedance,Current,RingFrequency,RingVoltage,SendGain,ReceiveGain,FskTime,ClipTransWhen,ClipFormat,RingDCVoltageOverlapped,UserDefineRingVoltage,ClipSendDateTime,DspHighPassFilterEnable,DspTemplateName,ClipForceSendFsk)
{
   this.Domain = Domain;
   this.HookFlashDownTime = HookFlashDownTime;
   this.HookFlashUpTime = HookFlashUpTime;
   this.OnhookConfirmTime = OnhookConfirmTime;
   this.Impedance = Impedance;
   this.Current = Current;
   this.RingFrequency = RingFrequency;
   this.RingVoltage = RingVoltage;
   this.SendGain = SendGain;
   this.ReceiveGain = ReceiveGain;
   this.FskTime = FskTime;
   this.ClipTransWhen = ClipTransWhen;
   this.ClipFormat = ClipFormat;
   this.RingDCVoltageOverlapped = RingDCVoltageOverlapped;
   this.UserDefineRingVoltage = UserDefineRingVoltage;
   this.ClipSendDateTime = ClipSendDateTime;
   this.DspHighPassFilterEnable = DspHighPassFilterEnable;
   this.DspTemplateName = DspTemplateName;
   this.ClipForceSendFsk = ClipForceSendFsk;
}
var PhyInterfaceParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.X_HW_Extend,HookFlashDownTime|HookFlashUpTime|OnhookConfirmTime|Impedance|Current|RingFrequency|RingVoltage|SendGain|ReceiveGain|FskTime|ClipTransWhen|ClipFormat|RingDCVoltageOverlapped|UserDefineRingVoltage|ClipSendDateTime|DspHighPassFilterEnable|DspTemplateName|ClipForceSendFsk, stPhyInterfaceParam);%>;

function stDspTemplateParam(Domain,Enable,EchoCancellationEnable,SilenceSuppression,JbMode,NLP,WorkMode)
{
   this.Domain = Domain;
   this.Enable = Enable;
   this.EchoCancellationEnable = EchoCancellationEnable;
   this.SilenceSuppression = SilenceSuppression;
   this.JbMode = JbMode;
   this.NLP = NLP;
   this.WorkMode = WorkMode;
}
var DspTemplateParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.X_HW_DspTemplate,Enable|EchoCancellationEnable|SilenceSuppression|JbMode|NLP|WorkMode,stDspTemplateParam); %>;

function stUserDspTemplateParam(Domain,TemplateName)
{
   this.Domain = Domain;
   this.TemplateName = TemplateName;
}
var UserDspTemplateParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.X_HW_DspTemplate.Templates.{i},TemplateName,stUserDspTemplateParam); %>;

function setCtlDisplay(record)
{ 
	setText('dspsendgain',DspGainList[selctLindex].TransmitGain);
    setText('dspreceivegain',DspGainList[selctLindex].ReceiveGain);	
}

function initHighConfig()
{
    var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = h248user[b.getAttribute("BindText")];
	}
	
	if(1 == BhartiMode)
	{
		DisableAllElement();
	}
	
	var EchoCancellationEnable=getElement('EchoCancellationEnable');
	var OffhookDtasAckInterval=getElement('OffhookDtasAckInterval');
	var Transmode=getElement('Transmode');
	var Switchmode=getElement('Switchmode');
	var ProfileIndex=getElement('ProfileIndex');
	var SoftwareParameters=getElement('SoftwareParameters');
	var Topversion=getElement('Topversion');
	
	var HeartbeatMode=getElement('HeartbeatMode');
	var HeartBeatTimer=getElement('HeartBeatTimer');
	var HeartBeatRetransTimer=getElement('HeartBeatRetransTimer');
	var HeartBeatRetransTimes=getElement('HeartBeatRetransTimes');
    var RingVoltage = getElement('RingVoltage');
	var ProfileBody_exp = h248user['vspa_pfhint'];
	var Software_exp = h248user['vspa_softhint'];
	
	
	setCheck('EchoCancellationEnable', RtpExtendAll.EchoCancellationEnable);	
	setSelect("Transmode",FaxT38.Enable);
    setSelect("Switchmode",FaxModem.FaxNego);
    setSelect("ProfileIndex",H248Extend.ProfileIndex);
    setText("ProfileBody",H248Profile.ProfileBody);
    setText("SoftwareParameters",H248Extend.SoftwareParameters);
	setText('DigitMapStartTimer', H248DigitMapPara.DigitMapStartTimer);
	setText('DigitMapShortTimer', H248DigitMapPara.DigitMapShortTimer);
	setText('DigitMapLongTimer', H248DigitMapPara.DigitMapLongTimer);
	setText('OffhookDtasAckInterval', RtpExtendAll.OffhookDtasAckInterval);
    setSelect("Topversion",H248Extend.Topversion);
	
    setCheck("HeartbeatMode",H248.HeartbeatMode);
	setText("HeartBeatTimer",H248Extend.HeartBeatTimer);
	setText("HeartBeatRetransTimer",H248Extend.HeartBeatRetransTimer);
	setText("HeartBeatRetransTimes",H248Extend.HeartBeatRetransTimes);
	
	getElement('ProfileBody').title = ProfileBody_exp;
	getElement('SoftwareParameters').title = Software_exp;
	
	if(H248Extend.ProfileIndex == 0)
    { 
        setDisplay("ProfileBodyRow",1);
    }
    else
    { 
        setDisplay("ProfileBodyRow",0);
    }
	
    if(H248Extend.SoftwareParameters == "")
    {   
        setSelect("SelectSoftwarePara",0);
        setDisplay("SoftwareParametersRow",0);
    }
    else
   {    
        setSelect("SelectSoftwarePara",1);
        setDisplay("SoftwareParametersRow",1);
    }
	
	setCurServiceNumMappingPara();
	if (Line.length > 0)
	{
		selectLine('record_0'); 
		selectLine('tdVoipInfo_record_0'); 
        setDisplay('ConfigForm1', 1);
		setDisplay('voipadv2', 1);
		setDisplay('voipadv3', 1);
		
	}	
	else
	{	
		selectLine('record_no');
		selectLine('tdVoipInfo_record_no'); 
        setDisplay('ConfigForm1', 0);
		setDisplay('voipadv2', 0);
		setDisplay('voipadv3', 0);
		return;
	}
    setPhyList("PhyList");
    setPhyInterfaceParams();
    setRingVoltagePara();

	setText('dspsendgain',DspGainList[0].TransmitGain);
    setText('dspreceivegain',DspGainList[0].ReceiveGain);	
	
	if(isOltVisualUser == 1)
	{
        var all_input = document.getElementsByTagName("input");
        for (var i = 0; i <all_input.length ; i++) 
        {
            var b_input = all_input[i];
            
            if (b_input.type == "button")
            {
                setDisable(b_input.id,1);
            }
            else
            {
                b_input.disabled = "disabled";
            }
        }
        $("select").attr("disabled",true);
	}

}


function CheckForm2()
{
        var  profileBody= getValue('ProfileBody');
        var softwareParameters = getValue('SoftwareParameters');

        var RingDCVoltageOverlapped = getValue('RingDCVoltageOverlapped');
        var UserDefineRingVoltage = getValue('UserDefineRingVoltage');
        var HookFlashDownTime = getValue('HookFlashDownTime');
        var HookFlashUpTime = getValue('HookFlashUpTime');
        var OnhookConfirmTime = getValue('OnhookConfirmTime');
        var Current = getValue('Current');
        var FskTime = getValue('FskTime');
		var DigitMapStartTimer = getValue('DigitMapStartTimer');
		var DigitMapShortTimer = getValue('DigitMapShortTimer');
		var DigitMapLongTimer = getValue('DigitMapLongTimer');
		var dspsendgain = getValue('dspsendgain');
		var dspreceivegain = getValue('dspreceivegain');
        var OffhookDtasAckInterval = getValue('OffhookDtasAckInterval');
		
        if(profileBody.length >=8194)
        {
            AlertEx(h248user['vspa_probodylong']);
            return false;
        }

        if(softwareParameters.length >= 8194)
        {
            AlertEx(h248user['vspa_softparalong']);
            return false;
        }
		if(parseInt(DigitMapStartTimer) < 0 || parseInt(DigitMapStartTimer) > 900 || (getValue('DigitMapStartTimer') == ""))
    	{
        	AlertEx(h248user['vspa_starttimerinva']);
        	return false;
    	}
		
	    if(parseInt(DigitMapShortTimer) < 0 || parseInt(DigitMapShortTimer) > 900 || (getValue('DigitMapShortTimer') == ""))
    	{
        	AlertEx(h248user['vspa_shorttimerinva']);
        	return false;
    	}
		
	    if(parseInt(DigitMapLongTimer) < 0 || parseInt(DigitMapLongTimer) > 900 || (getValue('DigitMapLongTimer') == ""))
    	{
        	AlertEx(h248user['vspa_longtimerinva']);
        	return false;
    	}
		
		if (parseInt(OffhookDtasAckInterval) < 0 || parseInt(OffhookDtasAckInterval) > 1000 || (getValue('OffhookDtasAckInterval') == ""))
		{
			AlertEx(sipuser['vspa_dtasinva']);
			return false;
		}	
		
		var PhyListLength = getElement('PhyList').options.length;
		
		if ((selctLindex < 0 )||(0 == PhyListLength))
		{
			return true;
		}
        if (RussianMode == 1) {
            if (parseInt(RingDCVoltageOverlapped) < 0 || RingDCVoltageOverlapped > 40 ||
                (getValue('RingDCVoltageOverlapped') == ""))
            {
                AlertEx(h248user['vspa_dcbias_ros']);
                return false;
            }
        } else {
            if (parseInt(RingDCVoltageOverlapped) < 0 || RingDCVoltageOverlapped > 25 ||
                (getValue('RingDCVoltageOverlapped') == ""))
            {
                AlertEx(h248user['vspa_dcbias']);
                return false;
            }
        }

        if(parseInt(UserDefineRingVoltage) < 0 || parseInt(UserDefineRingVoltage) > 74 || (getValue('UserDefineRingVoltage') == ""))
        {
           AlertEx(h248user['vspa_usrdefinva']);
           return false;
        }

        if(parseInt(HookFlashDownTime) < 0 || parseInt(HookFlashDownTime) > 1400 || (getValue('HookFlashDownTime') == ""))
        {
           AlertEx(h248user['vspa_hookdowninva']);
           return false;
        }

        if(parseInt(HookFlashUpTime) < 0 || parseInt(HookFlashUpTime) > 1400 || (getValue('HookFlashUpTime') == ""))
        {
           AlertEx(h248user['vspa_hookupinva']);
           return false;
        }

        if(parseInt(OnhookConfirmTime) < 0 || parseInt(OnhookConfirmTime) > 1400 || (getValue('OnhookConfirmTime') == ""))
        {
           AlertEx(h248user['vspa_onhookconinva']);
           return false;
        }

        if((parseInt(HookFlashUpTime) <= parseInt(HookFlashDownTime)) || ((parseInt(OnhookConfirmTime) <= parseInt(HookFlashUpTime)) && (parseInt(OnhookConfirmTime) != 0)))
        {
           AlertEx(h248user['vspa_hookcheck']);
           return false;
        }
	
        if(parseInt(Current) < 16 || parseInt(Current) > 49 || (getValue('Current') == ""))
        {
           AlertEx(h248user['vspa_curinva']);
           return false;
        }

        if(parseInt(FskTime) < 0 || parseInt(FskTime) > 2000 || (getValue('FskTime') == ""))
        {
           AlertEx(h248user['vspa_intervalbef']);
           return false;
        }
		
		
		if(parseInt(dspsendgain) < -100 || parseInt(dspsendgain) > 50 || (getValue('dspsendgain') == ""))
		{
			AlertEx(h248user['vspa_dspsendgaininva']);
			return false;
		}
	
		if(parseInt(dspreceivegain) < -100 || parseInt(dspreceivegain) > 100 || (getValue('dspreceivegain') == ""))
		{
			AlertEx(h248user['vspa_dspreceivegaininva']);
			return false;
		}
        
        if(CheckSrvNumMappingPara() == false)
        {
            AlertEx(sipuser['vspa_remotetelnoinva']);
            return false;
        }
				
        return true;
}

function AddSubmitParam(Form,type)
{
	var PhyListLength = getElement('PhyList').options.length;
    var domain='';
    var CgiType = 'set.cgi?';
    var itemtxtid;
    var itemselectid;
	
	if (PhyListLength > 0)
	{
		Form.addParameter('t.Enable',getCheckVal('EnableDspTemplate'));
		Form.addParameter('t.WorkMode',getSelectVal('WorkMode'));
		Form.addParameter('u.RingVoltage',getSelectVal('RingVoltage'));
		Form.addParameter('u.RingDCVoltageOverlapped',getValue('RingDCVoltageOverlapped'));
		Form.addParameter('u.UserDefineRingVoltage',getValue('UserDefineRingVoltage'));
		Form.addParameter('u.SendGain',getSelectVal('SendGain'));
    	Form.addParameter('u.ReceiveGain',getSelectVal('ReceiveGain'));
		Form.addParameter('u.HookFlashDownTime',getValue('HookFlashDownTime'));
		Form.addParameter('u.HookFlashUpTime',getValue('HookFlashUpTime'));    
		Form.addParameter('u.OnhookConfirmTime',getValue('OnhookConfirmTime')); 
		Form.addParameter('u.Impedance',getSelectVal('Impedance')); 
		Form.addParameter('u.Current',getValue('Current'));
		Form.addParameter('u.ClipFormat',getSelectVal('ClipFormat'));
		Form.addParameter('u.FskTime',getValue('FskTime'));
		Form.addParameter('u.ClipTransWhen',getSelectVal('ClipTransWhen'));
		Form.addParameter('u.ClipSendDateTime',getCheckVal('ClipSendDateTime'));
		Form.addParameter('u.DspHighPassFilterEnable',getCheckVal('DspHighPassFilterEnable'));
		Form.addParameter('u.ClipForceSendFsk',getCheckVal('ClipForceSendFsk'));
		Form.addParameter('u.DspTemplateName',getValue('DspTemplateName'));
	}
	
    Form.addParameter('s.TransmitGain',getSelectVal('dspsendgain'));
	Form.addParameter('s.ReceiveGain',getSelectVal('dspreceivegain'));
	
	Form.addParameter('c.DigitMapStartTimer',getValue('DigitMapStartTimer'));
    Form.addParameter('c.DigitMapShortTimer',getValue('DigitMapShortTimer'));
    Form.addParameter('c.DigitMapLongTimer',getValue('DigitMapLongTimer'));
    
    

    Form.addParameter('v.FaxNego',getSelectVal('Switchmode'));

    Form.addParameter('w.Enable',getSelectVal('Transmode'));
    
    Form.addParameter('x.ProfileIndex',getSelectVal('ProfileIndex'));
    Form.addParameter('x.Topversion',getSelectVal('Topversion'));
	
	Form.addParameter('d.HeartbeatMode',getCheckVal('HeartbeatMode'));
		
	Form.addParameter('x.HeartBeatTimer',getValue('HeartBeatTimer'));
	Form.addParameter('x.HeartBeatRetransTimer',getValue('HeartBeatRetransTimer'));
	Form.addParameter('x.HeartBeatRetransTimes',getValue('HeartBeatRetransTimes'));

    Form.addParameter('z.EchoCancellationEnable',getCheckVal('EchoCancellationEnable'));
    Form.addParameter('z.OffhookDtasAckInterval',getValue('OffhookDtasAckInterval'));
	
    if(0 == getSelectVal('SelectSoftwarePara'))
    {
        Form.addParameter('x.SoftwareParameters',"");
    }
    else
    {
        Form.addParameter('x.SoftwareParameters',getValue('SoftwareParameters'));	    
    }

    if(0 == getSelectVal('ProfileIndex'))
    {
       Form.addParameter('y.ProfileBody',getValue('ProfileBody'));
    }

    var newitemflag = (AllMappingList.length >= ServiceNumMappingList.length ? 1 : 0);
    if(newitemflag == 1)
    {
        itemtxtid = 'ServiceNumMappingList_txtl'+(AllMappingList.length - 1);
        itemselectid = 'ServiceNumMappingList_listl'+(AllMappingList.length - 1);
        
        Form.addParameter('Add_b.ServiceNum',getValue(itemtxtid));
        Form.addParameter('Add_b.TemplateName',getSelectVal(itemselectid));
        domain = '&Add_b=InternetGatewayDevice.Services.VoiceService.1.X_HW_DspTemplate.ServiceNumMapping';
        CgiType = 'complex.cgi?';
    }
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    SetSrvNumMappingDataBuf();
	
	if (PhyListLength > 0)
	{
		Form.setAction(CgiType+'x=' + H248Extend.Domain
						+ '&d=' + H248.Domain
						+ '&y=' + H248Profile.Domain 
						+ '&z=' + RtpExtendAll.Domain
						+ '&w=' + FaxT38.Domain
						+ '&v=' + FaxModem.Domain
						+ '&c=' + H248DigitMapPara.Domain
						+ '&u=' + PhyInterfaceParams[parseInt(getSelectVal('PhyList'))-1].Domain
						+ '&t=' + DspTemplateParams[parseInt(getSelectVal('PhyList'))-1].Domain
				  + '&s=' + DspGainList[selctLindex].Domain
                        + domain
						+ '&RequestFile=html/voip/voipuser/voipuser.asp');
	}
	else
	{
		if (selctLindex >= 0)
		{
			Form.setAction(CgiType+'x=' + H248Extend.Domain
							+ '&d=' + H248.Domain
							+ '&y=' + H248Profile.Domain 
							+ '&z=' + RtpExtendAll.Domain
							+ '&w=' + FaxT38.Domain
							+ '&v=' + FaxModem.Domain
							+ '&c=' + H248DigitMapPara.Domain
					  + '&s=' + DspGainList[selctLindex].Domain
                            + domain
							+ '&RequestFile=html/voip/voipuser/voipuser.asp');
		}
		else
		{
			Form.setAction(CgiType+'x=' + H248Extend.Domain
							+ '&d=' + H248.Domain
							+ '&y=' + H248Profile.Domain 
							+ '&z=' + RtpExtendAll.Domain
							+ '&w=' + FaxT38.Domain
							+ '&v=' + FaxModem.Domain
							+ '&c=' + H248DigitMapPara.Domain
                            + domain
							+ '&RequestFile=html/voip/voipuser/voipuser.asp');
		}
		
	
	}

    setDisable('btnApplyHighConfig',1);
    setDisable('btnCancelHighConfig',1);
}


function ApplyHighConfig()
{  
	var checkValue=CheckForm2();
	if (true == checkValue)
    {
        var Form = new webSubmitForm();
        AddSubmitParam(Form);
        Form.submit();
    }
}

function CancelHighConfig()
{
    initHighConfig();
}

function onChangeProfile()
{    
	var index = getSelectVal("ProfileIndex");
    if(index == 0)
    {  
        setDisplay("ProfileBodyRow",1);
    }
    else
    {   
        setDisplay("ProfileBodyRow",0);
    }
}

function onChangeSoftware()
{
   var index = getSelectVal("SelectSoftwarePara");
   if(index == 0)
   { 
       setDisplay("SoftwareParametersRow",0);
   }
   else
   {
       setDisplay("SoftwareParametersRow",1);
   }
}

var g_Index = -1;

function setControl(index)
{
    var record;
    selctIndex = index;
	selctLindex = index;

    if (index == -1)
    {
        if(Line.length > 3)
        {
            setDisplay('ConfigForm1', 0);
            AlertEx('There are too many users.');
            return false;
        } 
        record = new stLine("","","","","Enabled","0","0");
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(record);
    }
    else if (index == -2)
    {
        setDisplay('ConfigForm1', 0);
    }
    else
    {
        record = Line[index];
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(record);
    }
    g_Index = index;
	SelectLineRecord(index);
}

function clickRemove() 
{
    clickRemoveItem('html/voip/voipuser/voipuser.asp');  
}  


function TopversionSelect(id)
{

    var Control = getElById(id);

    for (i = 0; i <  4; i++)
    {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
		Option.text = i;
        Control.appendChild(Option);
    }
}


function CheckForm(type)
{          
     return true;
}

function ChangeEnable()
{
    var Form = new webSubmitForm();	
    var EchoEnable = getElement("EchoCancellationEnable");

    if (EchoEnable.checked == true)
    { 			
		setDisplay('EchoCancellationEnable',1);
		Form.addParameter('z.EchoCancellationEnable',1);				
	}
	else
	{ 	  
	    setDisplay('EchoCancellationEnable',1);
		Form.addParameter('z.EchoCancellationEnable',0);
	}
}

function CancelConfig()
{
    if (selctIndex == -1)
    {
        var tableRow = getElement("voipUserTable");
        
        if (tableRow.rows.length == 1)
        {
            selectLine('record_no');
        }
        else if (tableRow.rows.length == 2)
        {
            addNullInst('VOIP User');
        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine('record_0');
        }
    }
    else
    {
        var record = Line[selctIndex];
	    setCtlDisplay(record);
    }
}

function setRingVoltagePara()
{
    var RingVoltage = getElementById("RingVoltage");
    
    if(3 == RingVoltage.selectedIndex)
    {
        setDisplay("UserDefineRingVoltageRow",1);
    }
    else
    {
        setDisplay("UserDefineRingVoltageRow",0);
    }
    
}

function setDspTemplatePara()
{
    var PhyID;
    var selectObj = getElement("PhyList");
    if(selectObj.options.length == 0)
    {
        return;
    }
    PhyID = parseInt((getSelectVal("PhyList")-1));
	
    if(1 == getCheckVal("EnableDspTemplate"))
    {
        setDisplay("WorkModeRow",1);
    }
    else
    {
        setDisplay("WorkModeRow",0);
    }
    setSelect("WorkMode",DspTemplateParams[PhyID].WorkMode);
}

function setFskClipPara()
{
    var clipFormat = getSelectVal("ClipFormat");
    if(("Sdmf-fsk" == clipFormat) || ("Mdmf-fsk" == clipFormat))
    {
        setDisplay("FskTimeRow",1);
    }
    else
    {
        setDisplay("FskTimeRow",0);
    }
}

function setPhyInterfaceParams()
{
    var PhyID;
    var selectObj = getElement("PhyList");
    if(selectObj.options.length == 0)
    {
        return;
    }

    PhyID = parseInt(getSelectVal("PhyList"))-1;
    setSelect("RingVoltage",PhyInterfaceParams[PhyID].RingVoltage);
    setText("UserDefineRingVoltage",PhyInterfaceParams[PhyID].UserDefineRingVoltage);
    setText("RingDCVoltageOverlapped",PhyInterfaceParams[PhyID].RingDCVoltageOverlapped);
    setSelect("SendGain",PhyInterfaceParams[PhyID].SendGain);
    setSelect("ReceiveGain",PhyInterfaceParams[PhyID].ReceiveGain);
    setText("HookFlashDownTime",PhyInterfaceParams[PhyID].HookFlashDownTime);
    setText("HookFlashUpTime",PhyInterfaceParams[PhyID].HookFlashUpTime);
    setText("OnhookConfirmTime",PhyInterfaceParams[PhyID].OnhookConfirmTime);
    setSelect("Impedance",PhyInterfaceParams[PhyID].Impedance);
    setText("Current",PhyInterfaceParams[PhyID].Current);
    setSelect("ClipFormat",PhyInterfaceParams[PhyID].ClipFormat);
    setText("FskTime",PhyInterfaceParams[PhyID].FskTime);
    setSelect("ClipTransWhen",PhyInterfaceParams[PhyID].ClipTransWhen);
    setCheck("EnableDspTemplate",DspTemplateParams[PhyID].Enable);
    setRingVoltagePara();
    setDspTemplatePara();
    setCheck("ClipSendDateTime",PhyInterfaceParams[PhyID].ClipSendDateTime);
	setCheck("DspHighPassFilterEnable", PhyInterfaceParams[PhyID].DspHighPassFilterEnable);
	setCheck("ClipForceSendFsk", PhyInterfaceParams[PhyID].ClipForceSendFsk);
	addTemplateItem("DspTemplateName", PhyInterfaceParams[PhyID].DspTemplateName);
    setSelect("DspTemplateName",PhyInterfaceParams[PhyID].DspTemplateName);
}

function addTemplateItem(id, ItemValue)
{
    var Control = getElById(id);
    var OptionIndex = 0;

    OptionIndex = getOptionIndex(id, ItemValue);
    if(OptionIndex == -1)
    {
        var Option = document.createElement("Option");
        Option.value = ItemValue;
        Option.innerText = ItemValue;
        Option.text = ItemValue;
        Option.hidden = true;
        Control.appendChild(Option);
    }
}

function DropDownListTemplateSelect(id, ArrayOption)
{
 	var Control = getElById(id);
    var i = 0;
    var OptionIndex = 0;
    var PreDefineTemplates = [
        "",
        "highspeed_modem",
        "lowspeed_modem",
        "staticjbmode",
        "alarmdevice"
        ];

    for (i = 0; i < PreDefineTemplates.length; i++)
    {
        var Option = document.createElement("Option");
        Option.value = PreDefineTemplates[i];
        Option.innerText = PreDefineTemplates[i];
        Option.text = PreDefineTemplates[i];
        Control.appendChild(Option);
    }

    for (i = 0; i < UserDspTemplateParams.length - 1; i++)
    {
        OptionIndex = getOptionIndex(id, UserDspTemplateParams[i].TemplateName);
        if(OptionIndex == -1)
        {
            var Option = document.createElement("Option");
            Option.value = UserDspTemplateParams[i].TemplateName;
            Option.innerText = UserDspTemplateParams[i].TemplateName;
            Option.text = UserDspTemplateParams[i].TemplateName;
            Control.appendChild(Option);
        }
    }
}

    </script>
</head>
<body class="mainbody" onload="initHighConfig();">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipUser", GetDescFormArrayById(h248user, "v01"), GetDescFormArrayById(h248user, "v02"), false);
</script>

<div class="title_spread"></div>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_configgol'></td>
  </tr>
</table>	

<form id="voipadv1">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="EchoCancellationEnable" RealType="CheckBox" DescRef="vspa_enableecho" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="EchoCancellationEnable" InitValue="Empty" ClickFuncApp="onchange=ChangeEnable"/>
<li id="Transmode" RealType="DropDownList" DescRef="vspa_faxtran" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Transmode" InitValue="[{TextRef:'vspa_passthr',Value:'0'},{TextRef:'vspa_t38',Value:'1'}]"/>
<li id="Switchmode" RealType="DropDownList" DescRef="vspa_faxswitch" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Switchmode" InitValue="[{TextRef:'vspa_selfswitch',Value:'0'},{TextRef:'vspa_negotiation',Value:'1'}]"/>
<li id="ProfileIndex" RealType="DropDownList" DescRef="vspa_proindex" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ProfileIndex" InitValue="[{TextRef:'vspa_default',Value:'1'},{TextRef:'vspa_userdefine',Value:'0'},{TextRef:'vspa_indexbt',Value:'2'},{TextRef:'vspa_indexft',Value:'3'},{TextRef:'vspa_indexkpn',Value:'4'},{TextRef:'vspa_indexpccw',Value:'5'},{TextRef:'vspa_indexzte',Value:'6'},{TextRef:'vspa_indexbell',Value:'7'}]" ClickFuncApp="onchange=onChangeProfile"/>
<script language="JavaScript" type="text/javascript">
    if (rosUnionGame == 1) {
        document.write("<li id=\"ProfileBody\" RealType=\"TextArea\" DescRef=\"vspa_probody\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"ProfileBody\" InitValue=\"Empty\" Elementclass=\"interfacetextrosgameclass\"\/\>");
    } else {
        document.write("<li id=\"ProfileBody\" RealType=\"TextArea\" DescRef=\"vspa_probody\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"ProfileBody\" InitValue=\"Empty\" Elementclass=\"interfacetextclass\"\/\>");
    }
</script>
<li id="SelectSoftwarePara" RealType="DropDownList" DescRef="vspa_softpara" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SelectSoftwarePara" InitValue="[{TextRef:'vspa_default',Value:'0'},{TextRef:'vspa_userdefine',Value:'1'}]" ClickFuncApp="onchange=onChangeSoftware"/>
<li id="SoftwareParameters" RealType="TextBox" DescRef="vspa_userdef" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SoftwareParameters" InitValue="Empty"/>
<li id="Topversion" RealType="DropDownList" DescRef="vspa_startnego" RemarkRef="vspa_negohint" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue=""/>
<li id="DigitMapStartTimer" RealType="TextBox" DescRef="vspa_starttimer" RemarkRef="vspa_digtmaphint" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" MaxLength=""/>
<li id="DigitMapShortTimer" RealType="TextBox" DescRef="vspa_shorttimer" RemarkRef="vspa_digtmaphint" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" MaxLength=""/>
<li id="DigitMapLongTimer" RealType="TextBox" DescRef="vspa_longtimer" RemarkRef="vspa_digtmaphint" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" MaxLength=""/>
<li id="HeartbeatMode" RealType="CheckBox" DescRef="vspa_enableHBMode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="HeartBeatTimer" RealType="TextBox" DescRef="vspa_HBTimer" RemarkRef="vspa_uints" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="HeartBeatRetransTimer" RealType="TextBox" DescRef="vspa_HBRetransTimer" RemarkRef="vspa_uints" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="HeartBeatRetransTimes" RealType="TextBox" DescRef="vspa_HBRetransTimes" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="OffhookDtasAckInterval" RealType="TextBox" DescRef="vspa_DtasAck" RemarkRef="vspa_DtasAckhint" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<script>
var VoipConfigFormList1 = HWGetLiIdListByForm("voipadv1", null);
HWParsePageControlByID("voipadv1", TableClass, h248user, null);
TopversionSelect("Topversion");
</script>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_dsptmppara'></td>
  </tr>
</table>

<script language="JavaScript" type="text/javascript">
ShowServiceNumListTable(UserDspTemplateParams);
</script>
</form>		

<div class="func_spread"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_lineadvance'></td>
  </tr>
</table>
<script language="JavaScript" type="text/JavaScript">
var i = 0;
var ShowableFlag = 1;
var ShowButtonFlag = 0;
var ColumnNum = 3;
var VoipArray = new Array();
var ConfiglistInfo = new Array(
							new stTableTileInfo("vspa_sequence","align_center","index",false),
							new stTableTileInfo("vspa_linename22","align_center","LineName",false),
							new stTableTileInfo("vspa_assopot22","align_center","PhyReferenceList",false),null);
if (Line.length == 0)
{
	var VoipShowTab = new ShowTab();
		
	VoipShowTab.index = "--";
	VoipShowTab.LineName = "--";
	VoipShowTab.PhyReferenceList = "--";
}
else
{
	for (var i = 0; i < Line.length; i++)
	{
		var VoipShowTab = new ShowTab();
					
		VoipShowTab.index = i+1;	
		  
		if (Line[i].LineName == "")
		{
			VoipShowTab.LineName = '--';
		}
		else
		{
			VoipShowTab.LineName = Line[i].LineName;
		}  
		
		VoipShowTab.PhyReferenceList = Line[i].PhyReferenceList;  
		VoipArray.push(VoipShowTab);      
			
	}
}

VoipArray.push(null);
HWShowTableListByType(ShowableFlag, "tdVoipInfo", ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, h248user, null);
</script>


<form id="voipadv2">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="dspsendgain" RealType="TextBox" DescRef="vspa_dspsendgain" RemarkRef="vspa_dspsendgainrange" ErrorMsgRef="Empty" Require="FALSE" BindField="dspsendgain" InitValue="Empty"/>
<li id="dspreceivegain" RealType="TextBox" DescRef="vspa_dspreceivegain" RemarkRef="vspa_dspreceivegainrange" ErrorMsgRef="Empty" Require="FALSE" BindField="dspreceivegain" InitValue="Empty"/>
<script>
var VoipConfigFormList2 = HWGetLiIdListByForm("voipadv2", null);
HWParsePageControlByID("voipadv2", TableClass, h248user, null);
</script>
</table>
</form>

<div class="func_spread"></div>
		
<form id="voipadv3">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_phy'></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="PhyList" RealType="DropDownList" DescRef="vspa_portindex" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyList" InitValue="Empty" ClickFuncApp="onchange=setPhyInterfaceParams"/>		
<li id="RingVoltage" RealType="DropDownList" DescRef="vspa_ringvol" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RingVoltage" InitValue="[{TextRef:'vspa_ring74v',Value:'0'},{TextRef:'vspa_ring65v',Value:'1'},{TextRef:'vspa_ring50v',Value:'2'},{TextRef:'vspa_userdefine',Value:'3'}]" ClickFuncApp="onchange=setRingVoltagePara"/>
<li id="UserDefineRingVoltage" RealType="TextBox" DescRef="vspa_usrringvol" RemarkRef="vspa_uintvrms" ErrorMsgRef="Empty" Require="FALSE" BindField="UserDefineRingVoltage" InitValue="Empty"/>
<li id="RingDCVoltageOverlapped" RealType="TextBox" DescRef="vspa_uintvdc" RemarkRef="vspa_uintv" ErrorMsgRef="Empty" Require="FALSE" BindField="UserDefineRingVoltage" InitValue="Empty"/>
<li id="SendGain" RealType="DropDownList" DescRef="vspa_sendgain" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SendGain" InitValue="[{TextRef:'m6db',Value:'-6db'},{TextRef:'m55db',Value:'-5.5db'},{TextRef:'m5db',Value:'-5db'},{TextRef:'m45db',Value:'-4.5db'},{TextRef:'m4db',Value:'-4db'},{TextRef:'m35db',Value:'-3.5db'},{TextRef:'m3db',Value:'-3db'},{TextRef:'m25db',Value:'-2.5db'},{TextRef:'m2db',Value:'-2db'},{TextRef:'m15db',Value:'-1.5db'},{TextRef:'m1db',Value:'-1db'},{TextRef:'m05db',Value:'-0.5db'},{TextRef:'zerodb',Value:'0db'},{TextRef:'po5db',Value:'0.5db'},{TextRef:'p1db',Value:'1db'},{TextRef:'p15db',Value:'1.5db'},{TextRef:'p2db',Value:'2db'},{TextRef:'p25db',Value:'2.5db'},{TextRef:'p3db',Value:'3db'},{TextRef:'p35db',Value:'3.5db'},{TextRef:'p4db',Value:'4db'},{TextRef:'p45db',Value:'4.5db'},{TextRef:'p5db',Value:'5db'},{TextRef:'p55db',Value:'5.5db'},{TextRef:'p6db',Value:'6db'}]"/>
<li id="ReceiveGain" RealType="DropDownList" DescRef="vspa_recgain" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ReceiveGain" InitValue="[{TextRef:'zerodb',Value:'0db'},{TextRef:'m05db',Value:'-0.5db'},{TextRef:'m1db',Value:'-1db'},{TextRef:'m15db',Value:'-1.5db'},{TextRef:'m2db',Value:'-2db'},{TextRef:'m25db',Value:'-2.5db'},{TextRef:'m3db',Value:'-3db'},{TextRef:'m35db',Value:'-3.5db'},{TextRef:'m4db',Value:'-4db'},{TextRef:'m45db',Value:'-4.5db'},{TextRef:'m5db',Value:'-5db'},{TextRef:'m55db',Value:'-5.5db'},{TextRef:'m6db',Value:'-6db'},{TextRef:'m65db',Value:'-6.5db'},{TextRef:'m7db',Value:'-7db'},{TextRef:'m75db',Value:'-7.5db'},{TextRef:'m8db',Value:'-8db'},{TextRef:'m85db',Value:'-8.5db'},{TextRef:'m9db',Value:'-9db'},{TextRef:'m95db',Value:'-9.5db'},{TextRef:'m10db',Value:'-10db'},{TextRef:'m105db',Value:'-10.5db'},{TextRef:'m11db',Value:'-11db'},{TextRef:'m115db',Value:'-11.5db'},{TextRef:'m12db',Value:'-12db'}]"/>
<li id="HookFlashDownTime" RealType="TextBox" DescRef="vspa_hookdown" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="HookFlashUpTime" RealType="TextBox" DescRef="vspa_hookup" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="OnhookConfirmTime" RealType="TextBox" DescRef="vspa_onhook" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="Impedance" RealType="DropDownList" DescRef="vspa_impedance" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Impedance" InitValue="[{TextRef:'vspa_chinatel',Value:'0'},{TextRef:'vspa_chinauser',Value:'1'},{TextRef:'vspa_sixhuno',Value:'2'},{TextRef:'vspa_rus',Value:'3'},{TextRef:'vspa_115',Value:'4'},{TextRef:'vspa_120',Value:'5'},{TextRef:'vspa_ninehuno',Value:'6'},{TextRef:'vspa_brazil',Value:'7'},{TextRef:'vspa_bt0',Value:'8'},{TextRef:'vspa_HKBT3',Value:'9'},{TextRef:'vspa_HKBT5',Value:'10'},{TextRef:'vspa_BT1',Value:'11'},{TextRef:'vspa_BT2',Value:'12'},{TextRef:'vspa_BT3',Value:'13'},{TextRef:'vspa_europe',Value:'14'},{TextRef:'vspa_newzealand',Value:'15'}]" Elementclass="impedancetextareaclass"/>
<li id="Current" RealType="TextBox" DescRef="vspa_current" RemarkRef="vspa_ma" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
<li id="ClipFormat" RealType="DropDownList" DescRef="vspa_clipformat" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ClipFormat" InitValue="[{TextRef:'sdmf',Value:'Sdmf-fsk'},{TextRef:'mdmf',Value:'Mdmf-fsk'},{TextRef:'dtmf',Value:'Dtmf'},{TextRef:'r15',Value:'R1.5'},{TextRef:'etsi',Value:'etsi'}]" ClickFuncApp="onchange=setFskClipPara"/>
<li id="FskTime" RealType="TextBox" DescRef="vspa_fsk" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="FskTime" InitValue="Empty"/>
<li id="ClipTransWhen" RealType="DropDownList" DescRef="vspa_clipflow" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ClipTransWhen" InitValue="[{TextRef:'vspa_afterring',Value:'AfterRing'},{TextRef:'vspa_beforering',Value:'BeforeRing'}]"/>
<li id="EnableDspTemplate" RealType="CheckBox" DescRef="vspa_enabledsptem" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="EnableDspTemplate" InitValue="Empty" ClickFuncApp="onclick=setDspTemplatePara"/>
<li id="WorkMode" RealType="DropDownList" DescRef="vspa_workmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="WorkMode" InitValue="[{TextRef:'vspa_workmodevo',Value:'Voice'},{TextRef:'vspa_workmodefax',Value:'Fax'},{TextRef:'vspa_workmodemodem',Value:'Modem'}]"/>
<li id="DspTemplateName" RealType="DropDownList" DescRef="vspa_gDspTmpName" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DspTemplateName" InitValue=""/>
<li id="ClipSendDateTime" RealType="CheckBox" DescRef="vspa_clipsenddatatime" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ClipSendDateTime" InitValue="Empty"/>
<li id="DspHighPassFilterEnable" RealType="CheckBox" DescRef="vspa_DspHighPass" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DspHighPassFilterEnable" InitValue="Empty"/>
<li id="ClipForceSendFsk" RealType="CheckBox" DescRef="vspa_ClipFsk" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ClipForceSendFsk" InitValue="Empty"/>
<script>
var VoipConfigFormList3 = HWGetLiIdListByForm("voipadv3", null);
HWParsePageControlByID("voipadv3", TableClass, h248user, null);

var VoipAdvSetArray = new Array();
HWSetTableByLiIdList(VoipConfigFormList3, VoipAdvSetArray, null);
DropDownListTemplateSelect("DspTemplateName",UserDspTemplateParams);
</script>
</table>
</form>

           
<table style="width:100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
	 <tr>
			<td width="50%" class="width_per25 table_submit"></td>
	   <td width="60%" colspan="10" class="width_per75 table_submit">	
	   <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<input name="btnApplyHighConfig" id="btnApplyHighConfig" type="button" class="ApplyButtoncss buttonwidth_100px" value=" Apply " onClick="ApplyHighConfig();"/> 
	  <script type="text/javascript">
		document.getElementsByName('btnApplyHighConfig')[0].value = h248user['vspa_apply'];	
	  </script>
	  <input name="btnCancelHighConfig" id="btnCancelHighConfig" type="button" class="CancleButtonCss buttonwidth_100px" value=" Cancel " onclick="CancelHighConfig();"/>
	  <script type="text/javascript">
		document.getElementsByName('btnCancelHighConfig')[0].value = h248user['vspa_cancel'];	
	  </script>					
		</td>
	</tr>
</table> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height10p"></td></tr>
</table>
</body>
</html>
