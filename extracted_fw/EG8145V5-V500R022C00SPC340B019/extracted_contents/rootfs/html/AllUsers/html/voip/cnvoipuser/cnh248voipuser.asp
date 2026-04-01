<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248user, sipuser);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>VOIP User</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="javascript" src="../common/srvnummapping_list.asp"></script>
<script language="JavaScript" type="text/javascript">
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var CurrentBin = '<%HW_WEB_GetBinMode();%>'; 
var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var selctIndex = -1;
var selctLindex = 0;
var POTSNum = 2;
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var isOltVisualUser = "<% HW_WEB_IfVisualOltUser();%>";
var External5203Flag = "<%HW_WEB_GetFeatureSupport(VOICE_FT_SUPPORT_5203);%>";

Rfc2833PT_Display = "Telephone Event Payload Type：";
if (CfgMode.toUpperCase() == 'JXCT' || CfgMode.toUpperCase() == 'ZJCT')
{
   Rfc2833PT_Display = "DTMF RFC2833：";
   DTMFMethodVar = "DTMF转移模式：";
}
else
{

   DTMFMethodVar = "二次拨号模式：";
}

var DTMFMethod_disaply = DTMFMethodVar;
var PayLoad_Display = Rfc2833PT_Display;

function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
}
var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

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
	
	
var LineList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllLine.length-1; i++)
{
    var temp = AllLine[i].Domain.split('.');
    var index = 0;
    LineList[index].push(AllLine[i]);
}	

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

function stCodec(Domain, EntryID, Codecs, PacketizationPeriod, Priority, Enable)
{
    this.Domain = Domain;
    this.EntryID = EntryID;
    this.Codecs = Codecs;
    this.PacketizationPeriod = PacketizationPeriod;
    this.Priority = Priority;
    this.Enable = Enable;        
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllCodec = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.Codec.List.{i}, EntryID|Codecs|PacketizationPeriod|Priority|Enable, stCodec);%>;
var CodecList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllCodec.length-1; i++)
{
    var temp = AllCodec[i].Domain.split('.');
    var index = 0;
    CodecList[index].push(AllCodec[i]);
}




var recordLineName;

function SelectLineRecord(recordId)
{
	var temp = recordId.split('_');	
	selctLindex = temp[1];
    selectLine(recordId);
	setPhyList("PhyList");
    setPhyInterfaceParams();
    setDspTemplatePara();
}

function stRtpExtend(Domain, EchoCancellationEnable, SilenceSuppression, OffhookDtasAckInterval)
{
    this.Domain = Domain;
    this.EchoCancellationEnable = EchoCancellationEnable;
	this.SilenceSuppression = SilenceSuppression;
	this.OffhookDtasAckInterval = OffhookDtasAckInterval;
}
var RtpExtendAlls = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP.X_HW_Extend, EchoCancellationEnable|SilenceSuppression|OffhookDtasAckInterval, stRtpExtend);%>;
var RtpExtendAll = RtpExtendAlls[0];


function stRtp(Domain, LocalPortMin, LocalPortMax,X_HW_PortName)
{
    this.Domain = Domain;
    this.LocalPortMin = LocalPortMin;
	this.LocalPortMax = LocalPortMax;
	this.X_HW_PortName = X_HW_PortName;
}
var Rtps = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP, LocalPortMin|LocalPortMax|X_HW_PortName, stRtp);%>;
var Rtp = Rtps[0];


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

function stH248Extend(Domain,ProfileIndex,SoftwareParameters,Topversion)
{
    this.Domain = Domain;
    this.ProfileIndex = ProfileIndex;
    this.SoftwareParameters = SoftwareParameters;
    this.Topversion = Topversion;
}
var H248Extends = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Extend,ProfileIndex|SoftwareParameters|Topversion|,stH248Extend);%>;
var H248Extend = H248Extends[0];

function stH248(Domain,DSCPMark, HeartBeatPattern, RegisterMode)
{
	this.Domain = Domain;
	this.DSCPMark = DSCPMark;
	this.HeartBeatPattern = HeartBeatPattern;
	this.RegisterMode = RegisterMode;
}
var H248s = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248,DSCPMark|HeartBeatPattern|RegisterMode,stH248);%>;
var H248 = H248s[0];

function stJitBuffer(Domain, IniFixedJB)
{
	this.Domain = Domain;
	this.IniFixedJB = IniFixedJB;
}
var JitBuffers = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP.X_HW_JitBuffer,IniFixedJB,stJitBuffer);%>;
var JitBuffer = JitBuffers[0];
function stProfile(Domain, DTMFMethod, X_HW_PortName, X_HW_HangingReminderToneTimer, X_HW_BusyToneTimer, X_HW_NoAnswerTimer)
{
    this.Domain = Domain;
    this.DTMFMethod = DTMFMethod;
	this.X_HW_PortName = X_HW_PortName;
	this.X_HW_HangingReminderToneTimer = X_HW_HangingReminderToneTimer;
	this.X_HW_BusyToneTimer = X_HW_BusyToneTimer;
	this.X_HW_NoAnswerTimer = X_HW_NoAnswerTimer;
}
var Profiles = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1,DTMFMethod|X_HW_PortName|X_HW_HangingReminderToneTimer|X_HW_BusyToneTimer|X_HW_NoAnswerTimer,stProfile);%>;
var Profile = Profiles[0];

function stRfc2833PT(Domain, HW_Rfc2833PT)
{
    this.Domain = Domain;
    this.HW_Rfc2833PT = HW_Rfc2833PT;
}
var VoiceRfc2833PT = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.RTP,TelephoneEventPayloadType,stRfc2833PT);%>;

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
	var PhyPortList = Line[selctLindex].PhyReferenceList;
    var selectObj = getElement(objname);
    var tempList;

    removeAllOption(objname);

    if(PhyPortList.length == 0)
    {
        setDisplay("DivPhyParameter",0);
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
    setDisplay("DivPhyParameter",1);
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

function setCodecProc5203()
{
    var vagIndex = 0;
    var instNum = 3;

    if (CodecList[vagIndex].length > selctLindex * instNum) {
        setText('codec1',CodecList[vagIndex][selctLindex * instNum + 0].Codecs);
        setText('codec2',CodecList[vagIndex][selctLindex * instNum + 1].Codecs);
        setText('codec3',CodecList[vagIndex][selctLindex * instNum + 2].Codecs);
            
        setText('G711uRtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 0].PacketizationPeriod);
        setText('G711aRtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 1].PacketizationPeriod);
        setText('G729RtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 2].PacketizationPeriod);
        
        setText('G711uPriority_text',CodecList[vagIndex][selctLindex * instNum + 0].Priority);
        setText('G711aPriority_text',CodecList[vagIndex][selctLindex * instNum + 1].Priority);
        setText('G729Priority_text',CodecList[vagIndex][selctLindex * instNum + 2].Priority);
        
        setCheck('G711uEnable_checkbox',CodecList[vagIndex][selctLindex * instNum + 0].Enable);
        setCheck('G711aEnable_checkbox',CodecList[vagIndex][selctLindex * instNum + 1].Enable);
        setCheck('G729Enable_checkbox',CodecList[vagIndex][selctLindex * instNum + 2].Enable);
    }

}

function setCodecProc()
{
    var vagIndex = 0;
    var instNum = 4;

    if (CodecList[vagIndex].length > selctLindex * instNum) {
        setText('codec1',CodecList[vagIndex][selctLindex * instNum + 0].Codecs);
        setText('codec2',CodecList[vagIndex][selctLindex * instNum + 1].Codecs);
        setText('codec3',CodecList[vagIndex][selctLindex * instNum + 2].Codecs);
        setText('codec4',CodecList[vagIndex][selctLindex * instNum + 3].Codecs);
            
        setText('G711uRtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 0].PacketizationPeriod);
        setText('G711aRtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 1].PacketizationPeriod);
        setText('G729RtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 2].PacketizationPeriod);
        setText('G722RtpPackageInterval_text',CodecList[vagIndex][selctLindex * instNum + 3].PacketizationPeriod);
        
        setText('G711uPriority_text',CodecList[vagIndex][selctLindex * instNum + 0].Priority);
        setText('G711aPriority_text',CodecList[vagIndex][selctLindex * instNum + 1].Priority);
        setText('G729Priority_text',CodecList[vagIndex][selctLindex * instNum + 2].Priority);
        setText('G722Priority_text',CodecList[vagIndex][selctLindex * instNum + 3].Priority);
        
        setCheck('G711uEnable_checkbox',CodecList[vagIndex][selctLindex * instNum + 0].Enable);
        setCheck('G711aEnable_checkbox',CodecList[vagIndex][selctLindex * instNum + 1].Enable);
        setCheck('G729Enable_checkbox',CodecList[vagIndex][selctLindex * instNum + 2].Enable);
        setCheck('G722Enable_checkbox',CodecList[vagIndex][selctLindex * instNum + 3].Enable);
    }

}

function setCtlDisplay(record)
{ 

    if (External5203Flag == true) {
        setCodecProc5203();
    } else {
        setCodecProc();
    }
    setText('TXGain_text',DspGainList[selctLindex].TransmitGain);
    setText('RXGain_text',DspGainList[selctLindex].ReceiveGain);	
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
	
	var EchoCancellationEnable=getElement('EchoCancelEnable_checkbox');
	var OffhookDtasAckInterval=getElement('OffhookDtasAckInterval');
	var SilenceSuppression=getElement('VadCngEnable_checkbox');
	var Transmode=getElement('Transmode');
	var Switchmode=getElement('Switchmode');
	var ProfileIndex=getElement('ProfileIndex');
	var SoftwareParameters=getElement('SoftwareParameters');
	var Topversion=getElement('Topversion');
	var ProfileBody_exp = h248user['vspa_pfhint'];
	var Software_exp = h248user['vspa_softhint'];
	
	var wanSigValue;
	for (k = 0; k < WanInfo.length; k++ )
	{
		if ( MakeVoipWanName(WanInfo[k]) ==  Profile.X_HW_PortName)
		{
			wanSigValue = domainTowanname(WanInfo[k].domain);
			break;
		}		
	}
	if (k == WanInfo.length)
	{
		wanSigValue = Profile.X_HW_PortName;
	}
	setSelect('X_HW_PortName', wanSigValue);

	var wanRtpValue;
	for (k = 0; k < WanInfo.length; k++ )
	{
		if ( MakeVoipWanName(WanInfo[k]) == Rtp.X_HW_PortName)
		{
			wanRtpValue = domainTowanname(WanInfo[k].domain);
			break;
		}
	}
	if (k == WanInfo.length)
	{
		wanRtpValue = Rtp.X_HW_PortName;
	}
	setSelect('MediaPortName', wanRtpValue);
	
	
	setCheck('EchoCancelEnable_checkbox', RtpExtendAll.EchoCancellationEnable);
	setText('OffhookDtasAckInterval', RtpExtendAll.OffhookDtasAckInterval);
	setCheck('VadCngEnable_checkbox', RtpExtendAll.SilenceSuppression);
    setSelect("ProfileIndex",H248Extend.ProfileIndex);
	setText("RtpPortStart_text",Rtp.LocalPortMin);
	setText("RtpPortEnd_text",Rtp.LocalPortMax);
	setSelect("DTMFMethod_select", Profile.DTMFMethod);
    setText("ProfileBody",H248Profile.ProfileBody);
    setText("SoftwareParameters",H248Extend.SoftwareParameters);
	setText("Tos",H248.DSCPMark);
	setText("JBBuffer",JitBuffer.IniFixedJB);
	setText("HangingReminderToneTimer", Profile.X_HW_HangingReminderToneTimer);
	setText("BusyToneTimer", Profile.X_HW_BusyToneTimer);
	setText("NoAnswerTimer", Profile.X_HW_NoAnswerTimer);
	setSelect("HeartBeatPattern",H248.HeartBeatPattern);
	setSelect("RegisterMode",H248.RegisterMode);
	
    setSelect("Topversion",H248Extend.Topversion);
	getElement('TrProfileBody').title = ProfileBody_exp;
	getElement('SoftwareParameters').title = Software_exp;
	if (Line.length > 0)
	{
		selectLine('record_0'); 
        setDisplay('ConfigForm1', 1);
	}	
	else
	{	
		selectLine('record_no');
        setDisplay('ConfigForm1', 0);
		return;
	}
	
    if (External5203Flag == true){
        setCodecProc5203();
    } else {
        setCodecProc();
    }
	
    setPhyList("PhyList");
    setPhyInterfaceParams();

	if(H248Extend.ProfileIndex == 0)
    { 
        setDisplay("TrProfileBody",1);
    }
    else
    { 
        setDisplay("TrProfileBody",0);
    }

    if(H248Extend.SoftwareParameters == "")
    {   
        setSelect("SelectSoftwarePara",0);
        setDisplay("SoftwareParameters",0);
    }
    else
   {    
        setSelect("SelectSoftwarePara",1);
        setDisplay("SoftwareParameters",1);
    }
    
    setCurServiceNumMappingPara();

	setText('TXGain_text',DspGainList[0].TransmitGain);
    setText('RXGain_text',DspGainList[0].ReceiveGain);	

	if(AllPhyInterface.length > POTSNum)
	{
		setDisplay('line_list', 1);	
		setDisplay('DivPHYdisplay', 1);	
	}
	else
	{
		setDisplay('line_list', 0);	
		setDisplay('DivPHYdisplay', 0);	
	}	

    if (CfgMode.toUpperCase() == 'JXCT' || CfgMode.toUpperCase() == 'ZJCT') {
        if (CfgMode.toUpperCase() == 'JXCT') {
            setDisplay('jxcttos', 1);
            setDisplay('jxctJbBuffer', 1);
            setDisplay('jxctJBMode', 1);
            setDisplay('jxctHangingReminderToneTimer', 1);
            setDisplay('jxctNoAnswerTimer', 1);
            setDisplay('jxctBusyToneTimer', 1);
            setDisplay('jxct2833PT', 1);
            setText('HW_Rfc2833PT', VoiceRfc2833PT[0].HW_Rfc2833PT);
        } else {
            setDisplay('jxcttos', 0);
            setDisplay('jxctJbBuffer', 0);
            setDisplay('jxctJBMode', 0);
            setDisplay('jxctHangingReminderToneTimer', 0);
            setDisplay('jxctNoAnswerTimer', 0);
            setDisplay('jxctBusyToneTimer', 0);
            setDisplay('jxct2833PT', 0);
        }
       setDisplay('jxctRegisterMode', 1);
       setDisplay('jxctDTMFMethodDisplay', 1);
       setDisplay('jxctHeartBeat', 1);
	   if (Profile.DTMFMethod == "InBand")
	   {
			DTMFMethodDispayVar = "透传方式";
	   }
	   else if(Profile.DTMFMethod == "RFC2833")
	   {
			DTMFMethodDispayVar = "RFC2833";
	   }
	   else
	   {
			DTMFMethodDispayVar = "SIPInfo";
	   }
	   setText('DTMFMethodDispay', DTMFMethodDispayVar);
    }
	else
	{
       setDisplay('jxcttos', 0);
	   setDisplay('jxctJbBuffer', 0);
	   setDisplay('jxctHeartBeat', 0);
	   setDisplay('jxctJBMode', 0);	
	   setDisplay('jxctRegisterMode', 0);
	   setDisplay('jxctHangingReminderToneTimer', 0);
	   setDisplay('jxctNoAnswerTimer', 0);
	   setDisplay('jxctBusyToneTimer', 0);
	   setDisplay('jxct2833PT', 0);
	   setDisplay('jxctDTMFMethodDisplay', 0);
	}
	
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
        $("textarea").attr("disabled",true);
    }

    if (External5203Flag == true) {
        setDisable('G722RtpPackageInterval_text',true);
        setDisable('G722Priority_text',true);
        setDisable('G722Enable_checkbox',true);
        setDisable('G722SilSup_checkbox',true);
    }
}


function CheckForm2()
{
        var  profileBody= getValue('ProfileBody');
        var softwareParameters = getValue('SoftwareParameters');
		var LocalPortMin = getValue('RtpPortStart_text');
		var LocalPortMax = getValue('RtpPortEnd_text');
        var RingDCVoltageOverlapped = getValue('RingDCVoltageOverlapped');
        var UserDefineRingVoltage = getValue('RingVoltage_text');
        var HookFlashDownTime = getValue('FlashMin_text');
        var HookFlashUpTime = getValue('FlashMax_text');
        var OnhookConfirmTime = getValue('OnhookConfirmTime');
        var Current = getValue('Current');
        var FskTime = getValue('FskTime');
		
		var dspsendgain = getValue('TXGain_text');
		var dspreceivegain = getValue('RXGain_text');
		
		var PacketizationPeriod1 = getValue('G711uRtpPackageInterval_text');
		var PacketizationPeriod2 = getValue('G711aRtpPackageInterval_text');
		var PacketizationPeriod3 = getValue('G729RtpPackageInterval_text');
		var PacketizationPeriod4 = getValue('G722RtpPackageInterval_text');
		var OffhookDtasAckInterval = getValue('OffhookDtasAckInterval');
		
		if ((PacketizationPeriod1 != 10) && (PacketizationPeriod1 != 20) && (PacketizationPeriod1 != 30))
		{
			AlertEx("RTP打包间隔配置只支持10、20、30，请重新设置。");
			return false;
		}
		
		if ((PacketizationPeriod2 != 10) && (PacketizationPeriod2 != 20) && (PacketizationPeriod2 != 30))
		{
			AlertEx("RTP打包间隔配置只支持10、20、30，请重新设置。");
			return false;
		}		
		
		if ((PacketizationPeriod3 != 10) && (PacketizationPeriod3 != 20) && (PacketizationPeriod3 != 30))
		{
			AlertEx("RTP打包间隔配置只支持10、20、30，请重新设置。");
			return false;
		}		
        
        if (External5203Flag != true) {
            if ((PacketizationPeriod4 != 10) && (PacketizationPeriod4 != 20) && (PacketizationPeriod4 != 30)) {
                AlertEx("RTP打包间隔配置只支持10、20、30，请重新设置。");
                return false;
            }
        }
		
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

        if(parseInt(RingDCVoltageOverlapped) < 0 || RingDCVoltageOverlapped > 25)
        {
           AlertEx(h248user['vspa_dcbias']);
           return false;
        }

        if(parseInt(UserDefineRingVoltage) < 0 || parseInt(UserDefineRingVoltage) > 74)
        {
           AlertEx(h248user['vspa_usrdefinva']);
           return false;
        }

        if(parseInt(HookFlashDownTime) < 0 || parseInt(HookFlashDownTime) > 1400)
        {
           AlertEx("拍叉最短时间不合法，请重新设置(范围0-1400)");
           return false;
        }

        if(parseInt(HookFlashUpTime) < 0 || parseInt(HookFlashUpTime) > 1400)
        {
           AlertEx("拍叉最长时间不合法，请重新设置(范围0-1400)");
           return false;
        }

        if(parseInt(OnhookConfirmTime) < 0 || parseInt(OnhookConfirmTime) > 1400)
        {
           AlertEx(h248user['vspa_onhookconinva']);
           return false;
        }

        if((parseInt(HookFlashUpTime) < parseInt(HookFlashDownTime)) || ((parseInt(OnhookConfirmTime) < parseInt(HookFlashUpTime)) && (parseInt(OnhookConfirmTime) != 0)))
        {
			AlertEx("拍叉最长时间必须大于拍叉最短时间，挂机确认时间必须大于拍叉最长时间");
           return false;
        }
	
        if(parseInt(Current) < 16 || parseInt(Current) > 49)
        {
           AlertEx(h248user['vspa_curinva']);
           return false;
        }

        if(parseInt(FskTime) < 0 || parseInt(FskTime) > 2000)
        {
           AlertEx(h248user['vspa_intervalbef']);
           return false;
        }
		
		if(parseInt(dspsendgain) < -100 || parseInt(dspsendgain) > 50)
		{
			AlertEx(h248user['vspa_dspsendgaininva']);
			return false;
		}
	
		if(parseInt(dspreceivegain) < -100 || parseInt(dspreceivegain) > 100)
		{
			AlertEx(h248user['vspa_dspreceivegaininva']);
			return false;
		}
		
		if (parseInt(LocalPortMin) < 1026 || parseInt(LocalPortMin) > 65494)
		{
			AlertEx("本地RTP端口最小值设置不合法，请重新设置(范围1026-65494)");
			return false;
		}
		
		if (parseInt(LocalPortMax) < 1032 || parseInt(LocalPortMax) > 65500)
		{
			AlertEx("本地RTP端口最大值设置不合法，请重新设置(范围1032-65500)");
			return false;
		}
			
		if (parseInt(OffhookDtasAckInterval) < 0 || parseInt(OffhookDtasAckInterval) > 1000 || (getValue('OffhookDtasAckInterval') == ""))
		{
			AlertEx(sipuser['vspa_dtasinva']);
			return false;
		}
		if(CfgMode.toUpperCase() == 'JXCT')
		{
			var Tos = getValue('Tos');
			var JBBuffer = getValue('JBBuffer');
			var HW_DtmfPtValue = document.getElementById('HW_Rfc2833PT');
			if(parseInt(Tos) < 0 || parseInt(Tos) > 63)
			{
				AlertEx("TOS/DSCP值设置不合法，请重新设置(范围0-63)");
				return false;
			}
			if(parseInt(JBBuffer) < 0 || parseInt(JBBuffer) > 200)
			{
				AlertEx("静态抖动缓冲值设置不合法，请重新设置(范围0-200)");
				return false;
			}
			if (HW_DtmfPtValue.value < 96 || HW_DtmfPtValue.value > 127)
			{
				AlertEx(sipuser['vspa_2833ptinvalid']);
				return false;
			}
		}

        if(CheckSrvNumMappingPara() == false)
        {
            AlertEx(sipuser['vspa_remotetelnoinva']);
            return false;
        }
        return true;
}

function stDftRoute(domain,autoenable,wandomain)
{
        this.domain     = domain;
        this.autoenable = autoenable;
        this.wandomain  = wandomain;
}

function stWanInfo(domain,Enable,CntType,Name, ConnectionStatus,NATEnabled,DefaultGateway,ServiceList,ExServiceList,vlanid,MacId,submask)
{
    this.domain = domain;
    this.Enable = Enable;
    this.CntType = CntType; 
	this.Name =  Name;
    this.ConnectionStatus = ConnectionStatus;
    this.NATEnabled = NATEnabled;
    this.DefaultGateway = DefaultGateway;
	this.ServiceList = (ExServiceList.length == 0)?ServiceList:ExServiceList;
    this.vlanid = vlanid;
	this.MacId = MacId;
    this.submask = submask;
}

    var WanIPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId|SubnetMask,stWanInfo);%>;  

    var WanPPPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId,stWanInfo);%>;  

    var dftRoutes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Layer3Forwarding,X_HW_AutoDefaultGatewayEnable|DefaultConnectionService,stDftRoute);%>;


var dftRoute = dftRoutes[0];

var WanInfo = new Array();

for(i=0, j=0;WanIPInfo.length > 0 && i < WanIPInfo.length -1;i++ )
{
    WanIPInfo[i].ServiceList = WanIPInfo[i].ServiceList.toUpperCase();

    if ( (true == WanIPInfo[i].Enable)
	     && (WanIPInfo[i].ServiceList.indexOf("VOIP") >= 0) 
	     )
    {
        WanInfo[j] = WanIPInfo[i];
        j++;
    }
}

for(i=0; WanPPPInfo.length > 0 && i < WanPPPInfo.length - 1;i++)
{
    WanPPPInfo[i].ServiceList = WanPPPInfo[i].ServiceList.toUpperCase();

    if ( (true == WanPPPInfo[i].Enable)
	    &&(WanPPPInfo[i].ServiceList.indexOf("VOIP") >= 0) 
		)
    {
        WanInfo[j] = WanPPPInfo[i];
        j++;
    }
}

function MakeWanName(wan)
{
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = ''; 

    if('&nbsp;'!= wan)
    {
        wanInst = wan.MacId;
        wanServiceList  = wan.ServiceList;
        wanMode         = (wan.CntType  ==  'IP_Bridged' ) ? "B" : "R";
        vlanId          = wan.vlanid;

		if('E8C' == CurrentBin.toUpperCase() || "1" == CUVoiceFeature)
		{
			switch(wanServiceList)
			{
				case "VOIP":
			    	wanServiceList = "VOICE";
					break;
				case "TR069_VOIP":
			    	wanServiceList = "TR069_VOICE";
			    	break;
			    case "VOIP_INTERNET":
			    	wanServiceList = "VOICE_INTERNET";
			    	break;
			    case "TR069_VOIP_INTERNET":
			    	wanServiceList = "TR069_VOICE_INTERNET";
			    	break;
				case "VOIP_IPTV":
			    	wanServiceList = "VOICE_IPTV";
			    	break;
			    case "TR069_VOIP_IPTV":
			    	wanServiceList = "TR069_VOICE_IPTV";
			    	break;
			    default:
			    	break;
			}
		}
        
	    if (0 != parseInt(vlanId))
	    {
	        currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
	    }
        else
        {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }

         
        return currentWanName;
    }
    else
    {
        
        return '&nbsp;';
    }  
}
function MakeVoipWanName(wan)
{
    var wanInst = 0;
    var wanServiceList = '';
    var currentWanName = '';       

    DomainElement = wan.domain.split(".");
    wanInst = DomainElement[4];
       
    wanServiceList  = wan.ServiceList;
    
    currentWanName = "wan"+wanInst;
    return currentWanName;    
}


function AddSubmitParam(Form,type)
{
	var domain;
	var vagIndex = 0;
    var CgiType = 'set.cgi?';
    var itemtxtid;
    var itemselectid;
    
    Form.addParameter('s.TransmitGain',getSelectVal('TXGain_text'));
	Form.addParameter('s.ReceiveGain',getSelectVal('RXGain_text'));
	Form.addParameter('t.Enable',getCheckVal('EnableDspTemplate'));
    Form.addParameter('t.WorkMode',getSelectVal('WorkMode'));
	Form.addParameter('a.DTMFMethod',getSelectVal('DTMFMethod_select'));
	Form.addParameter('a.X_HW_PortName',getValue('X_HW_PortName'));
	Form.addParameter('b.X_HW_PortName',getValue('MediaPortName'));
	Form.addParameter('b.LocalPortMin',getSelectVal('RtpPortStart_text'));
	Form.addParameter('b.LocalPortMax',getSelectVal('RtpPortEnd_text'));
    Form.addParameter('u.RingDCVoltageOverlapped',getValue('RingDCVoltageOverlapped'));
    Form.addParameter('u.UserDefineRingVoltage',getValue('RingVoltage_text'));
	var RingVoltageconfig = getValue('RingVoltage_text');
	if (74 == RingVoltageconfig)
	{
		Form.addParameter('u.RingVoltage',0);
	}
	else if(65 == RingVoltageconfig)
	{
		Form.addParameter('u.RingVoltage',1);
	}
	else if(50 == RingVoltageconfig)
	{
		Form.addParameter('u.RingVoltage',2);
	}
	else
	{
		Form.addParameter('u.RingVoltage',3);
	}
    Form.addParameter('u.SendGain',getSelectVal('SendGain'));
    Form.addParameter('u.ReceiveGain',getSelectVal('ReceiveGain'));
    Form.addParameter('u.HookFlashDownTime',getValue('FlashMin_text'));
    Form.addParameter('u.HookFlashUpTime',getValue('FlashMax_text'));    
    Form.addParameter('u.OnhookConfirmTime',getValue('OnhookConfirmTime')); 
    Form.addParameter('u.Impedance',getSelectVal('Impedance')); 
	Form.addParameter('u.Current',getValue('Current'));
    Form.addParameter('u.FskTime',getValue('FskTime'));
    Form.addParameter('u.ClipTransWhen',getSelectVal('ClipTransWhen'));
    Form.addParameter('u.DspHighPassFilterEnable',getCheckVal('DspHighPassFilterEnable'));
	Form.addParameter('u.ClipForceSendFsk',getCheckVal('ClipForceSendFsk'));
	Form.addParameter('u.DspTemplateName',getValue('DspTemplateName'));

    Form.addParameter('x.ProfileIndex',getSelectVal('ProfileIndex'));
    Form.addParameter('x.Topversion',getSelectVal('Topversion'));

    Form.addParameter('z.EchoCancellationEnable',getCheckVal('EchoCancelEnable_checkbox'));
	Form.addParameter('z.SilenceSuppression',getCheckVal('VadCngEnable_checkbox'));
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
	 
	if(LineList[vagIndex].length > 0)
    {
        Form.addParameter('d.PacketizationPeriod',getSelectVal('G711uRtpPackageInterval_text'));     
        Form.addParameter('e.PacketizationPeriod',getSelectVal('G711aRtpPackageInterval_text'));   
        Form.addParameter('f.PacketizationPeriod',getSelectVal('G729RtpPackageInterval_text'));   
                              
        Form.addParameter('d.Priority',getSelectVal('G711uPriority_text'));
        Form.addParameter('e.Priority',getSelectVal('G711aPriority_text'));
        Form.addParameter('f.Priority',getSelectVal('G729Priority_text'));
        
        Form.addParameter('d.Enable',getCheckVal('G711uEnable_checkbox'));   
        Form.addParameter('e.Enable',getCheckVal('G711aEnable_checkbox'));   
        Form.addParameter('f.Enable',getCheckVal('G729Enable_checkbox'));   
        
        if (External5203Flag == true) {
            if (CodecList[vagIndex].length > selctLindex*3) {
                domain ='d=' + CodecList[vagIndex][selctLindex *3  + 0].Domain
                     + '&e=' + CodecList[vagIndex][selctLindex *3  + 1].Domain
                     + '&f=' + CodecList[vagIndex][selctLindex *3  + 2].Domain
            }
        } else {
            Form.addParameter('g.PacketizationPeriod',getSelectVal('G722RtpPackageInterval_text'));   
            Form.addParameter('g.Priority',getSelectVal('G722Priority_text'));
            Form.addParameter('g.Enable',getCheckVal('G722Enable_checkbox'));
            if (CodecList[vagIndex].length > selctLindex*4) {
                domain ='d=' + CodecList[vagIndex][selctLindex *4  + 0].Domain
                     + '&e=' + CodecList[vagIndex][selctLindex *4  + 1].Domain
                     + '&f=' + CodecList[vagIndex][selctLindex *4  + 2].Domain
                     + '&g=' + CodecList[vagIndex][selctLindex *4  + 3].Domain;
            }
        }

	}	
 		Form.addParameter('i.TransmitGain',getSelectVal('TXGain_text'));
		Form.addParameter('i.ReceiveGain',getSelectVal('RXGain_text'));					
  		
        if (CfgMode.toUpperCase() == 'JXCT' || CfgMode.toUpperCase() == 'ZJCT') {
            if (CfgMode.toUpperCase() == 'JXCT') {
                Form.addParameter('t.JbMode',getSelectVal('JbMode'));
                Form.addParameter('l.DSCPMark',getValue('Tos'));
                Form.addParameter('m.IniFixedJB',getValue('JBBuffer'));
                Form.addParameter('a.X_HW_HangingReminderToneTimer',getValue('HangingReminderToneTimer'));
                Form.addParameter('a.X_HW_BusyToneTimer',getValue('BusyToneTimer'));
                Form.addParameter('a.X_HW_NoAnswerTimer',getValue('NoAnswerTimer'));
                Form.addParameter('b.TelephoneEventPayloadType',getValue('HW_Rfc2833PT'));
            }
            Form.addParameter('l.HeartBeatPattern',getSelectVal('HeartBeatPattern'));
            Form.addParameter('l.RegisterMode',getSelectVal('RegisterMode'));
		}
		domain += '&x=' + H248Extend.Domain
				+ '&y=' + H248Profile.Domain 
				+ '&z=' + RtpExtendAll.Domain
				+ '&a=' + Profile.Domain
				+ '&b=' + Rtp.Domain
				+ '&w=' + FaxT38.Domain
				+ '&v=' + FaxModem.Domain
				+ '&c=' + H248DigitMapPara.Domain
				+ '&u=' + PhyInterfaceParams[parseInt(getSelectVal('PhyList'))-1].Domain
				+ '&t=' + DspTemplateParams[parseInt(getSelectVal('PhyList'))-1].Domain
				+ '&s=' + DspGainList[selctLindex].Domain;
	
		if(CfgMode.toUpperCase() == 'JXCT')
		{
			domain += '&l=' + H248.Domain
					+ '&m=' + JitBuffer.Domain;
        } else if (CfgMode.toUpperCase() == 'ZJCT') {
            domain += '&l=' + H248.Domain;
		}
    var newitemflag = (AllMappingList.length >= ServiceNumMappingList.length ? 1 : 0);
    if(newitemflag == 1)
    {
        itemtxtid = 'ServiceNumMappingList_txtl'+(AllMappingList.length - 1);
        itemselectid = 'ServiceNumMappingList_listl'+(AllMappingList.length - 1);
        
        Form.addParameter('Add_b.ServiceNum',getValue(itemtxtid));
        Form.addParameter('Add_b.TemplateName',getSelectVal(itemselectid));
        domain += '&Add_b=InternetGatewayDevice.Services.VoiceService.1.X_HW_DspTemplate.ServiceNumMapping';
        CgiType = 'complex.cgi?';
    }
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    SetSrvNumMappingDataBuf();
    
	Form.setAction(CgiType + domain + '&RequestFile=html/voip/cnvoipuser/cnvoipuser.asp');
    setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
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
        setDisplay("TrProfileBody",1);
    }
    else
    {   
        setDisplay("TrProfileBody",0);
    }
}

function onChangeSoftware()
{
   var index = getSelectVal("SelectSoftwarePara");
   if(index == 0)
   { 
       setDisplay("SoftwareParameters",0);
   }
   else
   {
       setDisplay("SoftwareParameters",1);
   }
}

var g_Index = -1;

function setControl(index)
{
    var record;
    selctIndex = index;

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
}

function clickRemove() 
{
    if (ProductType == '2')
    {
        if (Line.length == 0)
        {
            AlertEx("The user cannot be deleted because it does not exist.");
            return;
        }
        
        if (selctIndex == -1)
        {
            AlertEx("User cannot de deleted. Please save the new user first.");
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
            AlertEx('No user has been chosen. Please choose one.');
            return ;
        }
            
        if (ConfirmEx("Are you sure you want to delete the current user?") == false)
        {
            return;
        }
        setDisable('btnApplyVoipUser',1);
        setDisable('cancelValue',1);
        removeInst('html/voip/cnvoipuser/cnvoipuser.asp'); 
    }
    else
    {
        clickRemoveItem('html/voip/cnvoipuser/cnvoipuser.asp');        
    }
}  

function clickRemove_xd() 
{
    if (Line.length == 0)
    {
        AlertEx("The user cannot be deleted because it does not exist.");
        return;
    }
    
    if (selctIndex == -1)
    {
        AlertEx("User cannot de deleted. Please save the new user first.");
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
        AlertEx('No user has been chosen. Please choose one.');
        return ;
    }
        
    if (ConfirmEx("Are you sure you want to delete the current user?") == false)
    {
        return;
    }
    setDisable('btnApplyVoipUser',1);
    setDisable('cancelValue',1);
    removeInst('html/voip/cnvoipuser/cnvoipuser.asp');    
}  

function CheckForm(type)
{          
     return true;
}

function ChangeEnable()
{
    var Form = new webSubmitForm();	
    var EchoEnable = getElement("EchoCancelEnable_checkbox");

    if (EchoEnable.checked == true)
    { 			
		setDisplay('EchoCancelEnable_checkbox',1);
		Form.addParameter('z.EchoCancellationEnable',1);				
	}
	else
	{ 	  
	    setDisplay('EchoCancelEnable_checkbox',1);
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
        setDisplay("TrWorkMode",1);
    }
    else
    {
        setDisplay("TrWorkMode",0);
    }
    setSelect("WorkMode",DspTemplateParams[PhyID].WorkMode);
	setSelect("JbMode",DspTemplateParams[PhyID].JbMode);
}

function setFskClipPara()
{
	var PhyID;
	PhyID = parseInt(getSelectVal("PhyList"))-1;
	var clipFormat = PhyInterfaceParams[PhyID].ClipFormat;
	
	if(("Sdmf-fsk" == clipFormat) || ("Mdmf-fsk" == clipFormat))
    {
        setDisplay("TrFskTime",1);
    }
    else
    {
        setDisplay("TrFskTime",0);
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
    
	var RingVoltage = PhyInterfaceParams[PhyID].RingVoltage;	
	var showRingVol = 74;
	if (0 == RingVoltage)
	{
		showRingVol = 74;
	}
	else if (1 == RingVoltage)
	{
		showRingVol = 65;
	}
	else if (2 == RingVoltage)
	{
		showRingVol = 50;
	}
	else
	{
		showRingVol = PhyInterfaceParams[PhyID].UserDefineRingVoltage;
	}
	
	setText("RingVoltage_text",showRingVol);	

    setText("RingDCVoltageOverlapped",PhyInterfaceParams[PhyID].RingDCVoltageOverlapped);
    setSelect("SendGain",PhyInterfaceParams[PhyID].SendGain);
    setSelect("ReceiveGain",PhyInterfaceParams[PhyID].ReceiveGain);
    setText("FlashMin_text",PhyInterfaceParams[PhyID].HookFlashDownTime);
    setText("FlashMax_text",PhyInterfaceParams[PhyID].HookFlashUpTime);
    setText("OnhookConfirmTime",PhyInterfaceParams[PhyID].OnhookConfirmTime);
    setSelect("Impedance",PhyInterfaceParams[PhyID].Impedance);
    setText("Current",PhyInterfaceParams[PhyID].Current);
    setSelect("ClipFormat",PhyInterfaceParams[PhyID].ClipFormat);
    setText("FskTime",PhyInterfaceParams[PhyID].FskTime);
    setSelect("ClipTransWhen",PhyInterfaceParams[PhyID].ClipTransWhen);
    setCheck("EnableDspTemplate",DspTemplateParams[PhyID].Enable);
    setDspTemplatePara();
	setFskClipPara();
	setCheck("DspHighPassFilterEnable", PhyInterfaceParams[PhyID].DspHighPassFilterEnable);
    addTemplateItem("DspTemplateName", PhyInterfaceParams[PhyID].DspTemplateName);
    setSelect("DspTemplateName",PhyInterfaceParams[PhyID].DspTemplateName);
	setCheck("ClipForceSendFsk",PhyInterfaceParams[PhyID].ClipForceSendFsk);
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
<table width="100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td colspan="11">
            <b><script>document.write(h248user['vspa_configgol']);</script></b>
            </td>
        </tr>
		<tr>
			<td class="width_per25 table_title"><script>document.write(DTMFMethod_disaply);</script></td>
			<td width="80%" class="table_right" colspan="10" > 
				<select name="DTMFMethod_select" id="DTMFMethod_select" size="1" class="width_125px"/>
				<option value="RFC2833">RFC2833</option>
				<option value="InBand">InBand</option>
				<option value="SIPInfo">SIPInfo</option>
				</select>
			</td>
		</tr>		
		<tr>
			<td class="table_title width_per25">本地RTP端口最小值：</td>
			<td width="80%" class="table_right" colspan="10" >
				 <input type="text" id="RtpPortStart_text" class="width_125px"/>
				 <span class="gray">(1026-65494)</td>
			</td>
			</tr>	
			<tr>
			<td class="table_title width_per25">本地RTP端口最大值：</td>
			<td width="80%" class="table_right" colspan="10" >
				 <input type="text" id="RtpPortEnd_text" class="width_125px"/>
				 <span class="gray">(1032-65500)</td>
			</td>
			</tr>	
			<tr> 
            <td class="width_per25 height20p table_title">回声抑制：</td>
            <td class="width_per75 table_right" colspan="10" > 
            <input name='EchoCancelEnable_checkbox' type='checkbox' id='EchoCancelEnable_checkbox' onclick="ChangeEnable()" value='1' />
            </td>
        </tr>
		
		<tr> 
            <td class="width_per25 height20p table_title">静音检测：</td>
            <td class="width_per75 table_right" colspan="10" > 
            <input name='VadCngEnable_checkbox' type='checkbox' id='VadCngEnable_checkbox' onclick="ChangeEnable()" value='1' />
            </td>
        </tr>
		<tr id="jxctDTMFMethodDisplay">
			<td class="table_title width_per25" BindText='vspa_h_jx_DTMFMethod_disaply'>
			</td>
			<td width="80%" class="table_right" colspan="10" >
             <input type="text" id="DTMFMethodDispay" class="width_123px" disabled="disabled"/>
			</td>
		</tr>
		<tr id="jxct2833PT">
			<td class="table_title width_per25"><script>document.write(PayLoad_Display);</script>
			</td>
			<td width="80%" class="table_right" colspan="10" >
             <input type="text" id="HW_Rfc2833PT" class="width_123px"/>
             <span class="gray"><script>document.write(sipuser['vspa_2833len']); </script></span></td>
			</td>
		</tr>

            <tr>
                <td class="width_per25 table_title" BindText="vspa_proindex">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select name="ProfileIndex" id="ProfileIndex" size="1" id="ProfileIndex" onchange="onChangeProfile()"
                       class="width_125px">
                        <option value="1" selected="selected"><script>document.write(h248user['vspa_default']);</script></option>
                        <option value="0"><script>document.write(h248user['vspa_userdefine']);</script></option>
                        <option value="2">BT</option>
                        <option value="3">FT</option>
                        <option value="4">KPN</option>
                        <option value="5">PCCW</option>
                        <option value="6">ZTE</option>
                        <option value="7">BELL</option>
                    </select>
                </td>
            </tr>
            <tr id="TrProfileBody">
                <td class="width_per25 table_title" BindText="vspa_probody">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <textarea name="ProfileBody" id="ProfileBody" rows="3" cols="68" class="wid_383px">0=0;1=2;2=1;3=0;4=0;5=0;6=0;7=0;8=0;9=0;10=0;11=1;12=0;13=0;14=0;15=0;16=0;17=0;18=0;19=0;20=0;21=0;22=0;23=0;24=0;25=0;26=0;27=0;28=0;29=0;30=0;31=0;32=0;33=0;34=0;35=0;36=0;37=0;38=0;39=0;40=1;41=4;42=0;43=0;44=0;45=0;46=0;47=2000;48=0;49=60;50=0;51=0;52=0;53=0;54=0;55=1;56=1;57=7;58=3;59=0;60=0;61=0;62=0;63=0;64=4;65=400;66=1;67=400;68=1;69=400;70=1;71=400;72=1;73=400;74=0;75=20;76=0;77=0;78=0;79=1;80=1;81=0;82=0;83=0;84=1;85=0;86=180;87=2;88=0;89=0;90=0;91=0;92=0;93=1;94=1;95=40;96=1;97=2;98=0;99=0;100=0;101=0;102=2000;103=0;104=60;105=60;106=0;107=0;108=0;109=0;110=500;111=0;112=0;113=1;114=0;115=0;116=0;117=65534;118=65534;119=65534;
            </textarea>
                </td>
            </tr>
            <tr>
                <td class="table_title width_per25" BindText="vspa_softpara">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select name="SelectSoftwarePara" id="SelectSoftwarePara" type="SelectSoftwarePara"
                        onchange="onChangeSoftware()" class="width_125px">
                        <option value="0"><script>document.write(h248user['vspa_default']);</script></option>
                        <option value="1"><script>document.write(h248user['vspa_userdefine']);</script></option>
                    </select>
                    <input type="text" name="SoftwareParameters" id="SoftwareParameters" class="wid_280px" />
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title" BindText="vspa_startnego">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select name="Topversion" id="Topversion" size="1" class="width_125px">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2" selected="selected">2</option>
                        <option value="3">3</option>
                    </select>
                    <span class="gray"><script>document.write(h248user['vspa_negohint']);</script></span>
                </td>
            </tr>

			<tr>
			<td class="table_title align_left width_per25">信令端口：</td>	
			<td class="table_right align_left width_per75" colspan="10">
			<select name="X_HW_PortName" id="X_HW_PortName" maxlength="30">
				  <script language="JavaScript" type="text/javascript">
				  document.write('<option value=' + " " + ' >'+ '<\/option>');	
					document.write('<option value=' + "br0" + ' id="br0">'
										   + "br0"+ '<\/option>'); 
			
					for (i = 0; i < WanInfo.length; i++)
					{
						document.write('<option id="wan_' + i + '" value="' + htmlencode(domainTowanname(WanInfo[i].domain)) + '">' + htmlencode(MakeWanName(WanInfo[i])) + '<\/option>');


                    }
				  </script>
		   </select>
      		<span class="gray">(语音信令WAN端口名)</td>
	   		</tr>
		
			<tr>
	     	<td class="table_title align_left width_per25">媒体端口：</td>
	     	<td class="table_right align_left width_per75" colspan="10">
		 	<select name="MediaPortName" id = "MediaPortName" maxlength="30" >
                        <script language="JavaScript" type="text/javascript">
                            document.write('<option value="" id="null">'
                                              + ''+ '<\/option>'); 
                            document.write('<option value=' + "br0" + ' id="br0">'
                                                  + "br0"+ '<\/option>'); 
                                        for (i = 0; i < WanInfo.length; i++)
                    {
							document.write('<option id="wan_' + i + '" value="' + htmlencode(domainTowanname(WanInfo[i].domain)) + '">' + htmlencode(MakeWanName(WanInfo[i])) + '<\/option>');
                    }
                </script>
                        </select>
      		<span class="gray">(语音媒体WAN端口名，为空表示与信令端口名相同)</td>
  			</tr>
		<tr id="jxctHeartBeat">
		<td class="table_title align_left width_per25">心跳方式：</td>	
			<td class="width_per75 table_right" colspan="10">
				<select id="HeartBeatPattern" class="width_125px">
				<option value="0">被动心跳</option>
				<option value="1">MGC心跳</option>
				<option value="2">主动心跳</option>
				</select>
			</td>
		</tr>
		<tr id="jxctRegisterMode">
		<td class="table_title align_left width_per25">终端注册方式：</td>	
			<td class="width_per75 table_right" colspan="10">
				<select id="RegisterMode" class="width_125px">
				<option value="Wildcard">根注册</option>
				<option value="Individual">单端点</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="table_title width_per25" BindText="vspa_DtasAck"></td>
			<td width="80%" class="table_right" colspan="10" >
				 <input type="text" id="OffhookDtasAckInterval" class="width_125px"/>
				 <span class="gray"><script>document.write(sipuser['vspa_uintms']); </script></span>
		         <span class="gray"><script>document.write(sipuser['vspa_DtasAcklen']); </script></span>
				 
			</td>
		</tr>	
		
		<tr id="jxcttos">
		<td class="table_title align_left width_per25">TOS/DSCP：</td>	
		<td width="80%" class="table_right" colspan="10" >
		<input type="text" id="Tos" class="width_125px"/>
		<span class="gray">(0-63)</span>
		</td>
		</tr>
		<tr id="jxctJbBuffer">
		<td class="table_title align_left width_per25">静态抖动缓冲：</td>	
		<td width="80%" class="table_right" colspan="10" >
		<input type="text" id="JBBuffer" class="width_125px"/>
		<span class="gray"><script>document.write(sipuser['vspa_uintms']); </script></span>
		<span class="gray">(0-200)</span>
		</td>
		</tr>
		<tr id="jxctNoAnswerTimer">
		<td class="table_title align_left width_per25">久叫不应时间：</td>	
		<td width="80%" class="table_right" colspan="10" >
		<input type="text" id="NoAnswerTimer" class="width_125px"/>
		<span class="gray"><script>document.write(h248user['vspa_uints']); </script></span>
		</td>
		</tr>
		<tr id="jxctHangingReminderToneTimer">
		<td class="table_title align_left width_per25">催挂音/嗷鸣音时间：</td>	
		<td width="80%" class="table_right" colspan="10" >
		<input type="text" id="HangingReminderToneTimer" class="width_125px"/>
		<span class="gray"><script>document.write(h248user['vspa_uints']); </script></span>
		</td>
		</tr>
		<tr id="jxctBusyToneTimer">
		<td class="table_title align_left width_per25">放忙音时间：</td>	
		<td width="80%" class="table_right" colspan="10" >
		<input type="text" id="BusyToneTimer" class="width_125px"/>
		<span class="gray"><script>document.write(h248user['vspa_uints']); </script></span>
		</td>
		</tr>
            <tr>
                <td colspan="11">
                </td>
            </tr>
			
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_dsptmppara'></td>
  </tr>
</table>

<script language="JavaScript" type="text/javascript">
ShowServiceNumListTable(UserDspTemplateParams);
</script>

 <tr>
            <td colspan="11">
            <b><script>document.write(h248user['vspa_lineadvance']);</script></b>
            </td>
 </tr>
<table id="line_list" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="voipUserTable" style="table-layout:fixed;word-break:break-all"> 
 <tr class="head_title">
                <td class="width_per25" BindText="vspa_sequence"></td>
                <td class="width_28p" BindText="vspa_linename22"></td>
                <td class="width_28p" BindText="vspa_assopot22"></td>
 </tr>
 <script language="JavaScript" type="text/javascript">
            if (Line.length == 0)
            {
               	selctLindex = 0;
			    document.write('<tr id="record_no"' 
        						+ ' class="trTabContent" onclick="selectLine(this.id);">');
        		document.write('<td class="align_center">----</td>');
        		document.write('<td class="align_center">----</td>');
                document.write('<td class="align_center">----</td>');
        		document.write('</tr>');
            }
            else
            {
                for (var i = 0; i < Line.length; i++)
                {
                    var html = '';
                    if(i%2 == 0)
					{						
						 html += '<tr id="record_' + i + '" class="tabal_01" '
                         +'onclick="SelectLineRecord(this.id);">';
					}
					else
					{
						 html += '<tr id="record_' + i + '" class="tabal_02" '
                         +'onclick="SelectLineRecord(this.id);">';						
					}

                    html += '<td class="align_left">' + (i+1) + '</td>';
					if (Line[i].LineName == "")
					{
						html +='<td class="align_center">' + '--' + '&nbsp;</td>';
					}
					else
					{
						html +='<td class="align_left" style="word-wrap:break-word; overflow:hidden;">' + htmlencode(Line[i].LineName) + '&nbsp;</td>';
					}                   
                    html += '<td class="align_left" style="word-wrap:break-word; overflow:hidden;">' + htmlencode(Line[i].PhyReferenceList) + '&nbsp;</td>';
                    html += '</tr>'; 
                    
                    document.write(html);
                }
            }
            </script>
</table>

<div id="ConfigForm1">
<table width="100%" border="0" cellpadding="0" cellspacing="1"  id="CodecInfo" >

<script type="text/javascript">
    { 
    document.write(
	'<tr class="table_title">'    
    +'<td class="align_right">G.722<input id="G722Enable_checkbox" name="G722Enable_checkbox"  value="1" type="checkbox" onclick=""/></td>'
    );
    document.write(
	'<td class="align_center">编码优先级：<input type="text" name="G722Priority_text" id="G722Priority_text" maxlength="256" value="" class="width_50px"/> <span class="gray" style="font-weight:normal">(1-100)</span></td>'    
    +'<td class="align_center">RTP打包间隔：<input type="text" name="G722RtpPackageInterval_text" id="G722RtpPackageInterval_text" maxlength="256" value="" class="width_70px"/><span class="gray" style="font-weight:normal">(毫秒)</span></td>'
    +'</tr>'
	
	+'<tr class="table_title">'
    +'<td class="align_right" >G.711A<input id="G711aEnable_checkbox" name="G711aEnable_checkbox" value="1" type="checkbox" onclick="" /></td>'
    );
    document.write(
	'<td class="align_center">编码优先级：<input type="text" name="G711aPriority_text" id="G711aPriority_text" maxlength="256" value="" class="width_50px"/> <span class="gray" style="font-weight:normal">(1-100)</span></td>'
    +'<td class="align_center">RTP打包间隔：<input type="text" name="G711aRtpPackageInterval_text" id="G711aRtpPackageInterval_text" maxlength="256" value=""  class="width_70px"/><span class="gray" style="font-weight:normal">(毫秒)</span></td>'
    +'</tr> '
	

    +'<tr class="align_left table_title">'
    +'<td class="align_right" >G.711U<input id="G711uEnable_checkbox" name="G711uEnable_checkbox" value="1" type="checkbox" onclick="" /></td>');
    document.write(
	'<td class="align_center">编码优先级：<input type="text" name="G711uPriority_text" id="G711uPriority_text" maxlength="256" value=""  class="width_50px"/> <span class="gray" style="font-weight:normal">(1-100)</span></td>'
    +'<td class="align_center">RTP打包间隔：<input type="text" name="G711uRtpPackageInterval_text" id="G711uRtpPackageInterval_text" maxlength="256" value=""  class="width_70px"/><span class="gray" style="font-weight:normal">(毫秒)</span></td>'
    +'</tr>'
	

    +'<tr class="table_title">'
    +'<td class="align_right">G.729<input id="G729Enable_checkbox" name="G729Enable_checkbox" value="1" type="checkbox" onclick="" /></td>'
    );
    document.write(
	'<td class="align_center">编码优先级：<input type="text" name="G729Priority_text" id="G729Priority_text" maxlength="256" value="" class="width_50px"/> <span class="gray" style="font-weight:normal">(1-100)</span></td>'
    +'<td class="align_center">RTP打包间隔：<input type="text" name="G729RtpPackageInterval_text" id="G729RtpPackageInterval_text" maxlength="256" value=""  class="width_70px"/><span class="gray" style="font-weight:normal">(毫秒)</span></td>'   
    +'</tr>'
	
	

    );
} 
   
        
</script>   
</table>


<table width="100%" border="0" cellpadding="0" cellspacing="1">
 	<tr>
        <td class="width_per25 table_title">DSP接收增益值：</td>
        <td class="width_per75 table_right" colspan="10">
            <input type="text" class="width_125px" id="RXGain_text" />
			<span class="gray"><script>document.write(h248user['vspa_dspreceivegainrange']);</script></span>
		</td>
    </tr>
    <tr>
        <td class="width_per25 table_title">DSP发送增益值：</td>
        <td class="width_per75 table_right" colspan="10">
            <input type="text" class="width_125px" id="TXGain_text" />
			<span class="gray"><script>document.write(h248user['vspa_dspsendgainrange']);</script></span>
        </td>
    </tr>
   
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" >

            <tr>
                <td colspan="11">
                    <b><script>document.write(h248user['vspa_phy']);</script></b>
                </td>
            </tr>
            <tr id="DivPHYdisplay">
                <td class="width_per25 table_title" BindText="vspa_portindex">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select id="PhyList" onchange="setPhyInterfaceParams()" class="width_125px">
                    </select>
                </td>
            </tr>
			
			<tr>
                <td class="width_per25 table_title">拍叉最短时间：</td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" class="width_125px" id="FlashMin_text" />
					<span class="gray"><script>document.write(h248user['vspa_uintms']);</script></span>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title">拍叉最长时间：</td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" class="width_125px" id="FlashMax_text" />
					<span class="gray"><script>document.write(h248user['vspa_uintms']);</script></span>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title" BindText="vspa_ringvol">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" class="width_125px" id="RingVoltage_text" />
					<span class="gray"><script>document.write(h248user['vspa_uintvrms']);</script></span>
                </td>
            </tr>

            <tr>
                <td class="width_per25 table_title" BindText="vspa_uintvdc">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" class="width_125px" id="RingDCVoltageOverlapped" />
					<span class="gray"><script>document.write(h248user['vspa_uintv']);</script></span>
                </td>
            </tr>
			<tr>
                <td class="width_per25 table_title">端口发送增益：</td>
                <td class="width_per75 table_right" colspan="10">
                    <select id="SendGain" class="width_125px">
                        <script>
                            if (CfgMode.toUpperCase() == 'JXCT') {
                                document.write('<option value="-14db">-14 db</option>');
                                document.write('<option value="-13.5db">-13.5 db</option>');
                                document.write('<option value="-13db">-13 db</option>');
                                document.write('<option value="-12.5db">-12.5 db</option>');
                                document.write('<option value="-12db">-12 db</option>');
                                document.write('<option value="-11.5db">-11.5 db</option>');
                                document.write('<option value="-11db">-11 db</option>');
                                document.write('<option value="-10.5db">-10.5 db</option>');
                                document.write('<option value="-10db">-10 db</option>');
                                document.write('<option value="-9.5db">-9.5 db</option>');
                                document.write('<option value="-9db">-9 db</option>');
                                document.write('<option value="-8.5db">-8.5 db</option>');
                                document.write('<option value="-8db">-8 db</option>');
                                document.write('<option value="-7.5db">-7.5 db</option>');
                                document.write('<option value="-7db">-7 db</option>');
                                document.write('<option value="-6.5db">-6.5 db</option>');
                            }
                            document.write('<option value="-6db">-6 db</option>');
                            document.write('<option value="-5.5db">-5.5 db</option>');
                            document.write('<option value="-5db">-5 db</option>');
                            document.write('<option value="-4.5db">-4.5 db</option>');
                            document.write('<option value="-4db">-4 db</option>');
                            document.write('<option value="-3.5db">-3.5 db</option>');
                            document.write('<option value="-3db">-3 db</option>');
                            document.write('<option value="-2.5db">-2.5 db</option>');
                            document.write('<option value="-2db">-2 db</option>');
                            document.write('<option value="-1.5db">-1.5 db</option>');
                            document.write('<option value="-1db">-1 db</option>');
                            document.write('<option value="-0.5db">-0.5 db</option>');
                            document.write('<option value="0db" selected="selected">0 db</option>');
                            document.write('<option value="0.5db">0.5 db</option>');
                            document.write('<option value="1db">1 db</option>');
                            document.write('<option value="1.5db">1.5 db</option>');
                            document.write('<option value="2db">2 db</option>');
                            document.write('<option value="2.5db">2.5 db</option>');
                            document.write('<option value="3db">3 db</option>');
                            document.write('<option value="3.5db">3.5 db</option>');
                            document.write('<option value="4db">4 db</option>');
                            document.write('<option value="4.5db">4.5 db</option>');
                            document.write('<option value="5db">5 db</option>');
                            if (CfgMode.toUpperCase() == 'JXCT') {
                                document.write('<option value="5.5db">5.5 db</option>');
                                document.write('<option value="6db">6 db</option>');
                            }
                        </script>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title">端口接收增益：</td>
                <td class="width_per75 table_right" colspan="10">
                    <select id="ReceiveGain" class="width_125px">
                        <script>
                            if (CfgMode.toUpperCase() == 'JXCT') {
                                document.write('<option value="-14db">-14 db</option>');
                                document.write('<option value="-13.5db">-13.5 db</option>');
                                document.write('<option value="-13db">-13 db</option>');
                                document.write('<option value="-12.5db">-12.5 db</option>');
                            }
                            document.write('<option value="-12db">-12 db</option>');
                            document.write('<option value="-11.5db">-11.5 db</option>');
                            document.write('<option value="-11db">-11 db</option>');
                            document.write('<option value="-10.5db">-10.5 db</option>');
                            document.write('<option value="-10db">-10 db</option>');
                            document.write('<option value="-9.5db">-9.5 db</option>');
                            document.write('<option value="-9db">-9 db</option>');
                            document.write('<option value="-8.5db">-8.5 db</option>');
                            document.write('<option value="-8db">-8 db</option>');
                            document.write('<option value="-7.5db">-7.5 db</option>');
                            document.write('<option value="-7db">-7 db</option>');
                            document.write('<option value="-6.5db">-6.5 db</option>');
                            document.write('<option value="-6db">-6 db</option>');
                            document.write('<option value="-5.5db">-5.5 db</option>');
                            document.write('<option value="-5db">-5 db</option>');
                            document.write('<option value="-4.5db">-4.5 db</option>');
                            document.write('<option value="-4db">-4 db</option>');
                            document.write('<option value="-3.5db" selected="selected">-3.5 db</option>');
                            document.write('<option value="-3db">-3 db</option>');
                            document.write('<option value="-2.5db">-2.5 db</option>');
                            document.write('<option value="-2db">-2 db</option>');
                            document.write('<option value="-1.5db">-1.5 db</option>');
                            document.write('<option value="-1db">-1 db</option>');
                            document.write('<option value="-0.5db">-0.5 db</option>');
                            document.write('<option value="0db">0 db</option>');
                            if (CfgMode.toUpperCase() == 'JXCT') {
                                document.write('<option value="0.5db">0.5 db</option>');
                                document.write('<option value="1db">1 db</option>');
                                document.write('<option value="1.5db">1.5 db</option>');
                                document.write('<option value="2db">2 db</option>');
                                document.write('<option value="2.5db">2.5 db</option>');
                                document.write('<option value="3db">3 db</option>');
                                document.write('<option value="3.5db">3.5 db</option>');
                                document.write('<option value="4db">4 db</option>');
                                document.write('<option value="4.5db">4.5 db</option>');
                                document.write('<option value="5db">5 db</option>');
                                document.write('<option value="5.5db">5.5 db</option>');
                                document.write('<option value="6db">6 db</option>');
                            }
                        </script>
                    </select>
                </td>
            </tr>
			
            
            <tr>
                <td class="width_per25 table_title" BindText="vspa_onhook">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" class="width_125px" id="OnhookConfirmTime" />
					<span class="gray"><script>document.write(h248user['vspa_uintms']);</script></span>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title" BindText="vspa_impedance">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select id="Impedance">
					<option value="0"><script>document.write(h248user['vspa_chinatel']);</script></option>
                    <option value="1"><script>document.write(h248user['vspa_chinauser']);</script></option>
                    <option value="2" selected="selected"><script>document.write(h248user['vspa_sixhuno']);</script></option>
                    <option value="3"><script>document.write(h248user['vspa_rus']);</script></option>
                    <option value="4"><script>document.write(h248user['vspa_115']);</script></option>
                    <option value="5"><script>document.write(h248user['vspa_120']);</script></option>
                    <option value="6"><script>document.write(h248user['vspa_ninehuno']);</script></option>
                    <option value="7"><script>document.write(h248user['vspa_brazil']);</script></option>
                    <option value="8"><script>document.write(h248user['vspa_bt0']);</script></option>
                    <option value="9"><script>document.write(h248user['vspa_HKBT3']);</script></option>
                    <option value="10"><script>document.write(h248user['vspa_HKBT5']);</script></option>
                    <option value="11"><script>document.write(h248user['vspa_BT1']);</script></option>
                    <option value="12"><script>document.write(h248user['vspa_BT2']);</script></option>
                    <option value="13"><script>document.write(h248user['vspa_BT3']);</script></option>
                    <option value="14"><script>document.write(h248user['vspa_europe']);</script></option>
                    <option value="15"><script>document.write(h248user['vspa_newzealand']);</script></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title" BindText="vspa_current">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" id="Current" class="width_125px" />
					<span class="gray"><script>document.write(h248user['vspa_ma']);</script></span>
                </td>
            </tr>
            
            <tr id="TrFskTime">
                <td class="width_per25 table_title" BindText="vspa_fsk">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="text" id="FskTime" class="width_125px" />
					<span class="gray"><script>document.write(h248user['vspa_uintms']);</script></span>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title" BindText="vspa_clipflow">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select id="ClipTransWhen" style="width:125px">
                        <option value="AfterRing"><script>document.write(h248user['vspa_afterring']);</script></option>
                        <option value="BeforeRing"><script>document.write(h248user['vspa_beforering']);</script></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="width_per25 table_title" BindText="vspa_enabledsptem">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <input type="checkbox" id="EnableDspTemplate" onclick="setDspTemplatePara()" />
                </td>
            </tr>
            <tr id="TrWorkMode">
                <td class="width_per25 table_title" BindText="vspa_workmode">
                </td>
                <td class="width_per75 table_right" colspan="10">
                    <select id="WorkMode" class="width_125px">
                        <option value="Voice"><script>document.write(h248user['vspa_workmodevo']);</script></option>
                        <option value="Fax"><script>document.write(h248user['vspa_workmodefax']);</script></option>
                        <option value="Modem" selected="selected"><script>document.write(h248user['vspa_workmodemodem']);</script></option>
                    </select>
                </td>
            </tr>
			
			<tr id="jxctJBMode">
			<td class="width_per25 table_title">JitterBuffer模式：</td>
                <td class="width_per75 table_right" colspan="10">
				 <select id="JbMode" class="width_125px">
				 <option value="Static">静态</option>
                 <option value="Dynamic">动态</option>
                 </select>
				 </td>
			</tr>
		   <tr>
           <td class="width_per25 table_title" BindText='vspa_gDspTmpName'>
           </td>
           <td class="width_per75 table_right" colspan="10">
			<select id="DspTemplateName" class="width_125px">
				<script language="JavaScript" type="text/javascript">
				DropDownListTemplateSelect("DspTemplateName",UserDspTemplateParams);
				</script>
			</select>
           </td>
           </tr>
			
			<tr>
                <td class="width_per25 table_title" BindText="vspa_DspHighPass"></td>
                <td class="width_per75 table_right" colspan="10"><input type="checkbox" name="DspHighPassFilterEnable" id="DspHighPassFilterEnable" /></td>
            </tr>
			
			<tr>
            <td class="width_per25 table_title" BindText="vspa_ClipFsk"></td>
            <td class="width_per75 table_right" colspan="10"><input type="checkbox" name="ClipForceSendFsk" id="ClipForceSendFsk" /></td>
            </tr>
			
             <tr ><td class="height10p"></td></tr>
	</table>
</div>
	<table style="width:100%" border="0" cellpadding="0" cellspacing="0" class="">
         <tr>
                <td width="50%" class="width_per25 "></td>
           <td width="60%" colspan="10" class="width_per75 " align="right">	
           <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value=" Apply " onClick="ApplyHighConfig();"/> 
		  <script type="text/javascript">
			document.getElementsByName('SaveApply_button')[0].value = h248user['e8cvspa_apply'];	
		  </script>
		  <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value=" Cancel " onclick="CancelHighConfig();"/>
		  <script type="text/javascript">
			document.getElementsByName('Cancel_button')[0].value = h248user['vspa_cancel'];	
		  </script>					
            </td>
        </tr>
  </table> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height10p"></td></tr>
</table>
</body>
</html>
