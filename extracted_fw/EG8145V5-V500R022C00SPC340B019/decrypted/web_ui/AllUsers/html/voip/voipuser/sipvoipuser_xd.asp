<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<style>
.TextBox
{
width:150px;  
}

.Select
{
width:157px;  
}
	
.MultiHomeModetextareaclass
{
	width:250px;
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
.wordclass
{
word-wrap:break-all;
word-break: break-all;
}

.selectdefcss
{
width:180px;
}

.interfacetextclass{
	width:300px;
	height:50px;
}


</style>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipuser, sipinterface);%>"></script>
<script language="JavaScript" type="text/javascript">

var selctIndex = -1;
var selctLindex = 0;

var vagIndex = 0;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

var isWanAccess = '<%HW_WEB_IsWanAccess();%>';

function GetVagIndexByInst(vagInst)
{
    for(var i = 0; i < Profile.length-1; i++)
    {
        if(Profile[i].profileid == vagInst)
        {
            return i;
        }
    }
    
    return 0;
}

function stProfile(Domain, HW_DtmfMethod, HW_ServerType, X_HW_Option120PriorityMode)
{
    this.Domain = Domain;
    this.HW_DtmfMethod = HW_DtmfMethod;
    this.HW_ServerType = HW_ServerType;
	this.X_HW_Option120PriorityMode = X_HW_Option120PriorityMode;
    var temp = Domain.split('.');
    this.profileid = temp[5];
}

var Profile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},DTMFMethod|X_HW_ServerType|X_HW_Option120PriorityMode,stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);
var maxvagnum = Profile.length-1;

function stLine(Domain, DirectoryNumber, Enable, PhyReferenceList )
{
    this.Domain = Domain;
    this.DirectoryNumber = DirectoryNumber;
    this.PhyReferenceList = PhyReferenceList;

    if (Enable.toLowerCase() == 'enabled')
    {
        this.Enable = 1;
    }
    else
    {
        this.Enable = 0;
    }
}
function stSIPServer(Domain, X_HW_SubscribeEnable)
{
	this.Domain = Domain;
	this.X_HW_SubscribeEnable = X_HW_SubscribeEnable;	
}
var AllSIPServer = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP,X_HW_SubscribeEnable,stSIPServer);%>;

function stAuth(Domain, URI, AuthUserName)
{
    this.Domain = Domain;
    this.URI = URI;
    this.AuthUserName = AuthUserName;
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,URI|AuthUserName,stAuth);%>;

var AuthList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllAuth.length-1; i++)
{
    var temp = AllAuth[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    AuthList[index].push(AllAuth[i]);
}


var recordDirectoryNumber;

function SelectLineRecord(index)
{   
    selctLindex = index;
    setPhyList("PhyList");
    setPhyInterfaceParams();
    setDspTemplatePara();
}
function stVoiceTransmode(Domain, FaxT38_Enable)
{
    this.Domain = Domain;
    this.FaxT38_Enable = FaxT38_Enable;
}
var VoiceTransmode = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.FaxT38,Enable,stVoiceTransmode);%>;

function stVoiceTransSwitch(Domain, X_HW_FaxModem_FaxNego)
{
    this.Domain = Domain;
    this.X_HW_FaxModem_FaxNego = X_HW_FaxModem_FaxNego;
}
var VoiceTransswitch= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.X_HW_FaxModem,FaxNego,stVoiceTransSwitch);%>;

function stSIPExtend(Domain, HW_ShareUserMode, HW_MultiHomeMode, SoftwareParameters)
{
    this.Domain = Domain;
    this.HW_ShareUserMode = HW_ShareUserMode;
    this.HW_MultiHomeMode = HW_MultiHomeMode;
    this.SoftwareParameters = SoftwareParameters;
}
var SIPExtend = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPExtend,SharedUserMode|MultiHomeMode|SoftwareParameters,stSIPExtend);%>;

function stRfc2833PT(Domain, HW_Rfc2833PT)
{
    this.Domain = Domain;
    this.HW_Rfc2833PT = HW_Rfc2833PT;
}
var VoiceRfc2833PT = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.RTP,TelephoneEventPayloadType,stRfc2833PT);%>;

function stProfileBody(Domain, X_HW_SIPProfile_Body)
{
    this.Domain = Domain;
    this.X_HW_SIPProfile_Body = X_HW_SIPProfile_Body;
}
var ProfileBody= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPProfile,ProfileBody, stProfileBody);%>;

function stEchoCancellation(Domain, X_HW_RTPExtend_EchoCancellationEnable,OffhookDtasAckInterval)
{
    this.Domain = Domain;
    this.X_HW_RTPExtend_EchoCancellationEnable = X_HW_RTPExtend_EchoCancellationEnable;
	this.OffhookDtasAckInterval = OffhookDtasAckInterval;
}
var EchoCancellation= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.RTP.X_HW_Extend,EchoCancellationEnable|OffhookDtasAckInterval, stEchoCancellation);%>;


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
    var index = GetVagIndexByInst(temp[5]);
    CodecList[index].push(AllCodec[i]);
}

function stDspGain(Domain, TransmitGain, ReceiveGain)
{
    this.Domain = Domain;
	this.TransmitGain = TransmitGain;
    this.ReceiveGain = ReceiveGain;
}	
	
var AllDspGain = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.VoiceProcessing, TransmitGain|ReceiveGain, stDspGain);%>;

var DspGainList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllDspGain.length-1; i++)
{
    var temp = AllDspGain[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    DspGainList[index].push(AllDspGain[i]);
}

function stHotLine(Domain, X_HW_HotlineEnable, X_HW_HotlineNumber, X_HW_HotlineTimer, CallWaitingEnable, CallForwardUnconditionalEnable, CallForwardUnconditionalNumber, CallForwardOnBusyEnable, CallForwardOnBusyNumber, CallForwardOnNoAnswerEnable, CallForwardOnNoAnswerNumber, MWIEnable, X_HW_3WayEnable, X_HW_CallHoldEnable, X_HW_MCIDEnable, X_HW_CLIPEnable, CallerIDEnable)
{
    this.Domain = Domain;
    this.X_HW_HotlineEnable = X_HW_HotlineEnable;
    this.X_HW_HotlineNumber = X_HW_HotlineNumber;
    this.X_HW_HotlineTimer  = X_HW_HotlineTimer;
    this.CallWaitingEnable  = CallWaitingEnable;
    this.CallForwardUnconditionalEnable = CallForwardUnconditionalEnable;
    this.CallForwardUnconditionalNumber = CallForwardUnconditionalNumber;
    this.CallForwardOnBusyEnable  = CallForwardOnBusyEnable;
    this.CallForwardOnBusyNumber  = CallForwardOnBusyNumber;
    this.CallForwardOnNoAnswerEnable = CallForwardOnNoAnswerEnable;
    this.CallForwardOnNoAnswerNumber = CallForwardOnNoAnswerNumber;
    this.MWIEnable  = MWIEnable;
    this.X_HW_3WayEnable  = X_HW_3WayEnable;
    this.X_HW_CallHoldEnable = X_HW_CallHoldEnable;
    this.X_HW_MCIDEnable = X_HW_MCIDEnable;
    this.X_HW_CLIPEnable  = X_HW_CLIPEnable;
    if(0 == CallerIDEnable)
    {
        this.CallerIDEnable = 1;
    }
    else
    {
        this.CallerIDEnable = 0;
    }
}    
    
var AllLineFeature = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.CallingFeatures, X_HW_HotlineEnable|X_HW_HotlineNumber|X_HW_HotlineTimer|CallWaitingEnable|CallForwardUnconditionalEnable|CallForwardUnconditionalNumber|CallForwardOnBusyEnable|CallForwardOnBusyNumber|CallForwardOnNoAnswerEnable|CallForwardOnNoAnswerNumber|MWIEnable|X_HW_3WayEnable|X_HW_CallHoldEnable|X_HW_MCIDEnable|X_HW_CLIPEnable|CallerIDEnable, stHotLine);%>;

var LineFeatureList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllLineFeature.length-1; i++)
{
    var temp = AllLineFeature[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    LineFeatureList[index].push(AllLineFeature[i]);
}


function stSipDigitMap(domain, DigitMapShortTimer, DigitMapLongTimer)
{
    this.Domain = domain;
    this.DigitMapShortTimer = DigitMapShortTimer;
    this.DigitMapLongTimer = DigitMapLongTimer;
}
var SipDigitMapPara = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPDigitmap.1,DigitMapShortTimer|DigitMapLongTimer,stSipDigitMap);%>;

function stPhyInterfaceParam(Domain,HookFlashDownTime,HookFlashUpTime,OnhookConfirmTime,Current,RingFrequency,RingVoltage,SendGain,ReceiveGain,FskTime,ClipTransWhen,ClipFormat,RingDCVoltageOverlapped,UserDefineRingVoltage,ReversePoleOnAnswer,DspTemplateName)
{
   this.Domain = Domain;
   this.HookFlashDownTime = HookFlashDownTime;
   this.HookFlashUpTime = HookFlashUpTime;
   this.OnhookConfirmTime = OnhookConfirmTime;
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
   this.ReversePoleOnAnswer = ReversePoleOnAnswer;
   this.DspTemplateName = DspTemplateName;
}

var PhyInterfaceParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.X_HW_Extend,HookFlashDownTime|HookFlashUpTime|OnhookConfirmTime|Current|RingFrequency|RingVoltage|SendGain|ReceiveGain|FskTime|ClipTransWhen|ClipFormat|RingDCVoltageOverlapped|UserDefineRingVoltage|ReversePoleOnAnswer|DspTemplateName, stPhyInterfaceParam);%>;

var PhyNum = PhyInterfaceParams.length - 1;

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|Enable|PhyReferenceList,stLine);%>;

var LineList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllLine.length-1; i++)
{	
    var temp = AllLine[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    LineList[index].push(AllLine[i]);
}

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

function setVagInfo()
{
    if(Profile[0] == null)
    {
        return;
    }
    
    setSelect('FaxT38_Enable', VoiceTransmode[vagIndex].FaxT38_Enable);
    setSelect('X_HW_FaxModem_FaxNego', VoiceTransswitch[vagIndex].X_HW_FaxModem_FaxNego);    
    setSelect('HW_ShareUserMode', SIPExtend[vagIndex].HW_ShareUserMode);
    setSelect('HW_MultiHomeMode', SIPExtend[vagIndex].HW_MultiHomeMode);
    setText('X_HW_SIPProfile_Body', ProfileBody[vagIndex].X_HW_SIPProfile_Body);
    setSelect('HW_DtmfMethod', Profile[vagIndex].HW_DtmfMethod);
	setSelect('X_HW_Option120PriorityMode', Profile[vagIndex].X_HW_Option120PriorityMode);
    setText('HW_Rfc2833PT', VoiceRfc2833PT[vagIndex].HW_Rfc2833PT);
    setSelect('HW_ServerType', Profile[vagIndex].HW_ServerType);
    setText('X_HW_SIPExtend_SoftwarePara', SIPExtend[vagIndex].SoftwareParameters);
    setText('shorttimer', SipDigitMapPara[vagIndex].DigitMapShortTimer);
    setText('longtimer', SipDigitMapPara[vagIndex].DigitMapLongTimer);
    setCheck('X_HW_RTPExtend_EchoCancellationEnable', EchoCancellation[vagIndex].X_HW_RTPExtend_EchoCancellationEnable);
	setText('OffhookDtasAckInterval', EchoCancellation[vagIndex].OffhookDtasAckInterval);
	setCheck('SubscribeEnable_checkbox', AllSIPServer[vagIndex].X_HW_SubscribeEnable);
	if(Profile[vagIndex].HW_ServerType == 1)
	{
		setDisable('SubscribeEnable_checkbox',1);
	}
	else
	{
		setDisable('SubscribeEnable_checkbox',0);
	}
    if(SIPExtend[vagIndex].SoftwareParameters == '')
    {   
       setSelect("SelectSoftwarePara",0);
       setDisplay("X_HW_SIPExtend_SoftwareParaRow",0);
    }
    else
    {   
       setSelect("SelectSoftwarePara",1);
       setDisplay("X_HW_SIPExtend_SoftwareParaRow",1);
    }
}

function ShowTab(index, URI, TelNo, AuthUserName,PhyReferenceList)
{
	this.index = index;
	this.URI = URI;
	this.TelNo = TelNo;
	this.AuthUserName = AuthUserName;
	this.PhyReferenceList = PhyReferenceList;
}


function ChangeVAGTable(allvagnum, vagIndex)
{
	
	for(index = 0; index < allvagnum; index++)
	{
		var optid = 'linelist'+index+'_tbl';

		if(vagIndex == index)
		{
			setDisplay(optid, 1);
		}
		else
		{
			setDisplay(optid, 0);
		}
		
	}
}

function LoadFrame()
{
    var X_HW_RTPExtend_EchoCancellationEnable=document.getElementById('X_HW_RTPExtend_EchoCancellationEnable');
	var Subscribe_Enable=document.getElementById('SubscribeEnable_checkbox');
	var OffhookDtasAckInterval = document.getElementById('OffhookDtasAckInterval');
    var FaxT38_Enable=document.getElementById('FaxT38_Enable');
    var X_HW_FaxModem_FaxNego=document.getElementById('X_HW_FaxModem_FaxNego');
    var HW_ShareUserMode=document.getElementById('HW_ShareUserMode');
    var HW_MultiHomeMode=document.getElementById('HW_MultiHomeMode');
    var X_HW_SIPProfile_Body=document.getElementById('X_HW_SIPProfile_Body');
    var SoftwareParameters=document.getElementById('SoftwareParameters');
    var ProfileBody_exp = sipuser['vspa_pfhint'];
    var Software_exp = sipuser['vspa_softhint'];
    var objTR = getElementByName('vag_tr');
	var j = 0;
    if(objTR!= null)
    {
        for(var i = 0; i < objTR.length; i++)
        {
            objTR[i].value = sipinterface['vspa_profile'] + Profile[i].profileid;
            if(i == vagIndex)
            {
                objTR[i].style.background = '#B4B4B4';
                objTR[i].style.color = '#990000';
                objTR[i].style.fontWeight='bold';
            }
            else
            {
                objTR[i].style.background = '#C3C3C3';
                objTR[i].style.color = '#505050';
                objTR[i].style.fontWeight='normal';
            }
        }
    }
    
	ChangeVAGTable(maxvagnum, vagIndex);
	
    document.getElementById('X_HW_SIPProfile_Body').title = ProfileBody_exp;
    document.getElementById('X_HW_SIPExtend_SoftwarePara').title = Software_exp;

    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }
        b.innerHTML = sipuser[b.getAttribute("BindText")];
    }
    
    if (LineList[vagIndex].length > 0)
    {
        selectLine('record_0'); 
		
		for (j=0; j<maxvagnum; j++)
		{
			if (vagIndex == j)
			{
				var oid = 'linelist' + j + '_record_0';
				selectLine(oid);  
			}
		}
		  
        setDisplay('ConfigForm1', 1);
    }    
    else
    {
		for (j=0; j<maxvagnum; j++)
		{
			if (vagIndex == j)
			{
				var oid = 'linelist' + j + '_record_no';
				selectLine(oid);
			}
		}		
        
        setDisplay('ConfigForm1', 0);
    }

    setVagInfo();
	
    if ((CodecList[vagIndex].length > selctLindex*4)&&(selctLindex>=0))
    {
        setSelect('PacketizationPeriod1', CodecList[vagIndex][selctLindex*4 + 0].PacketizationPeriod);
        setSelect('PacketizationPeriod2', CodecList[vagIndex][selctLindex*4 + 1].PacketizationPeriod);
        setSelect('PacketizationPeriod3', CodecList[vagIndex][selctLindex*4 + 2].PacketizationPeriod);
        setSelect('PacketizationPeriod4', CodecList[vagIndex][selctLindex*4 + 3].PacketizationPeriod);

        setText('Priority1',CodecList[vagIndex][selctLindex *4 + 0].Priority);
        setText('Priority2',CodecList[vagIndex][selctLindex *4 + 1].Priority);
        setText('Priority3',CodecList[vagIndex][selctLindex *4 + 2].Priority);
        setText('Priority4',CodecList[vagIndex][selctLindex *4 + 3].Priority);
        
        setCheck('EnableCodec1', CodecList[vagIndex][selctLindex*4 + 0].Enable);
        setCheck('EnableCodec2', CodecList[vagIndex][selctLindex*4 + 1].Enable);
        setCheck('EnableCodec3', CodecList[vagIndex][selctLindex*4 + 2].Enable);
        setCheck('EnableCodec4', CodecList[vagIndex][selctLindex*4 + 3].Enable);
    }

    setPhyList("PhyList");
    setPhyInterfaceParams();
    setDspTemplatePara();
    if (isWanAccess == true) {
        setDisable('CFUEnable', true);
        setDisable('CFUNumber', true);
        setDisable('CFBEnable', true);
        setDisable('CFBNumber', true);
        setDisable('CFNREnable', true);
        setDisable('CFNRNumber', true);
    }
}



function CheckForm1()
{ 
    var ProfileBody_ex=document.getElementById('X_HW_SIPProfile_Body');
    var SoftwarePara_ex=document.getElementById('X_HW_SIPExtend_SoftwarePara');
    var FaxT38_Enable=document.getElementById('FaxT38_Enable');
    var X_HW_FaxModem_FaxNego=document.getElementById('X_HW_FaxModem_FaxNego');
    var HW_ShareUserMode=document.getElementById('HW_ShareUserMode');
    var HW_MultiHomeMode=document.getElementById('HW_MultiHomeMode');
    var HW_DtmfPtValue = document.getElementById('HW_Rfc2833PT');
    var shorttimer = getValue('shorttimer');
    var longtimer = getValue('longtimer');
	var OffhookDtasAckInterval = getValue('OffhookDtasAckInterval');
        
    if (FaxT38_Enable.value > 2)
    {
        return false;
    }

    if (X_HW_FaxModem_FaxNego.value > 2)
    {
        return false;
    }
    
    if (HW_ShareUserMode.value > 2)
    {
        return false;
    }
    
    if (HW_MultiHomeMode.value > 5)
    {
        return false;
    }

    if (ProfileBody_ex.value.length > 8194)
    {
        AlertEx(sipuser['vspa_probodylong']);
        return false;
    }

    if (SoftwarePara_ex.value.length > 8194)
    {
        AlertEx(sipuser['vspa_softparalong']);
        return false;
    }
    
    if(parseInt(shorttimer) < 0 || parseInt(shorttimer) > 900 || (getValue('shorttimer') == ""))
    {
        AlertEx(sipuser['vspa_shorttimerinva']);
        return false;
    }
        
    if(parseInt(shorttimer) < 0 || parseInt(shorttimer) > 900 || (getValue('shorttimer') == ""))
    {
        AlertEx(sipuser['vspa_longtimerinva']);
        return false;
    }

    if (HW_DtmfPtValue.value < 96 || HW_DtmfPtValue.value > 127)
    {
        AlertEx(sipuser['vspa_2833ptinvalid']);
        return false;
    }
	
	if (parseInt(OffhookDtasAckInterval) < 0 || parseInt(OffhookDtasAckInterval) > 1000 || (getValue('OffhookDtasAckInterval') == ""))
    {
        AlertEx(sipuser['vspa_dtasinva']);
        return false;
    }

    return true;
}

function onChangeSoftware()
{
   var index = getSelectVal("SelectSoftwarePara");
   
   if(index == 0)
   { 
       setDisplay("X_HW_SIPExtend_SoftwareParaRow",0);
   }
   else
   {
       setDisplay("X_HW_SIPExtend_SoftwareParaRow",1);
   }
}


function AddSubmitParam(Form,type)
{    
    var domain;
    
    if(Profile[0] == null)
    {
        return false;
    }
    
    var PhyListLength = getElement('PhyList').options.length;

    Form.addParameter('x.Enable',getValue('FaxT38_Enable'));
    Form.addParameter('y.FaxNego',getValue('X_HW_FaxModem_FaxNego'));
    Form.addParameter('z.ProfileBody',getValue('X_HW_SIPProfile_Body'));
    Form.addParameter('a.SharedUserMode',getValue('HW_ShareUserMode'));
    Form.addParameter('a.MultiHomeMode',getValue('HW_MultiHomeMode'));
    if(getSelectVal("SelectSoftwarePara") == 0)
    {
        Form.addParameter('a.SoftwareParameters',"");
    }
    else
    {
        Form.addParameter('a.SoftwareParameters',getValue('X_HW_SIPExtend_SoftwarePara'));
    }

    Form.addParameter('b.EchoCancellationEnable',getCheckVal('X_HW_RTPExtend_EchoCancellationEnable'));
    Form.addParameter('b.OffhookDtasAckInterval',getValue('OffhookDtasAckInterval'));
    Form.addParameter('c.DigitMapShortTimer',getValue('shorttimer'));
    Form.addParameter('c.DigitMapLongTimer',getValue('longtimer'));
    
    Form.addParameter('m.DTMFMethod',getValue('HW_DtmfMethod'));
	Form.addParameter('m.X_HW_Option120PriorityMode',getValue('X_HW_Option120PriorityMode'));
    Form.addParameter('m.X_HW_ServerType',getValue('HW_ServerType'));
    Form.addParameter('n.TelephoneEventPayloadType',getValue('HW_Rfc2833PT'));
	Form.addParameter('p.X_HW_SubscribeEnable',getCheckVal('SubscribeEnable_checkbox')); 

    domain ='x=' + Profile[vagIndex].Domain + '.FaxT38'
         + '&y=' + Profile[vagIndex].Domain + '.X_HW_FaxModem'
         + '&z=' + Profile[vagIndex].Domain + '.SIP'+ '.X_HW_SIPProfile'
         + '&a=' + Profile[vagIndex].Domain + '.SIP'+ '.X_HW_SIPExtend'
         + '&b=' + Profile[vagIndex].Domain + '.RTP'+ '.X_HW_Extend'
         + '&c=' + SipDigitMapPara[vagIndex].Domain
		 + '&p=' + Profile[vagIndex].Domain + '.SIP'
         + '&m=' + Profile[vagIndex].Domain
         + '&n=' + Profile[vagIndex].Domain + '.RTP';
                    
    if(LineList[vagIndex].length > 0)
    {
        Form.addParameter('d.PacketizationPeriod',getSelectVal('PacketizationPeriod1'));     
        Form.addParameter('e.PacketizationPeriod',getSelectVal('PacketizationPeriod2'));   
        Form.addParameter('f.PacketizationPeriod',getSelectVal('PacketizationPeriod3'));   
        Form.addParameter('g.PacketizationPeriod',getSelectVal('PacketizationPeriod4'));   
                              
        Form.addParameter('d.Priority',getSelectVal('Priority1'));
        Form.addParameter('e.Priority',getSelectVal('Priority2'));
        Form.addParameter('f.Priority',getSelectVal('Priority3'));
        Form.addParameter('g.Priority',getSelectVal('Priority4'));
        
        Form.addParameter('d.Enable',getCheckVal('EnableCodec1'));   
        Form.addParameter('e.Enable',getCheckVal('EnableCodec2'));   
        Form.addParameter('f.Enable',getCheckVal('EnableCodec3'));   
        Form.addParameter('g.Enable',getCheckVal('EnableCodec4'));
		 
 		Form.addParameter('i.TransmitGain',getSelectVal('dspsendgain'));
		Form.addParameter('i.ReceiveGain',getSelectVal('dspreceivegain'));
		       
        Form.addParameter('h.X_HW_HotlineEnable',getCheckVal('HotlineEnable'));
        Form.addParameter('h.X_HW_HotlineNumber',getSelectVal('HotlineNumber'));
        Form.addParameter('h.X_HW_HotlineTimer',getSelectVal('HotlineTimer'));

        if (isWanAccess != true) {
            Form.addParameter('h.CallForwardUnconditionalEnable', getCheckVal('CFUEnable'));
            Form.addParameter('h.CallForwardUnconditionalNumber', getSelectVal('CFUNumber'));
            Form.addParameter('h.CallForwardOnBusyEnable', getCheckVal('CFBEnable'));
            Form.addParameter('h.CallForwardOnBusyNumber', getSelectVal('CFBNumber'));
            Form.addParameter('h.CallForwardOnNoAnswerEnable', getCheckVal('CFNREnable'));
            Form.addParameter('h.CallForwardOnNoAnswerNumber', getSelectVal('CFNRNumber'));
        }

        Form.addParameter('h.CallWaitingEnable',getCheckVal('CwEnable'));
        Form.addParameter('h.MWIEnable',getCheckVal('WMIEnable'));
        Form.addParameter('h.X_HW_3WayEnable',getCheckVal('3pCallEnable'));
        Form.addParameter('h.X_HW_CallHoldEnable',getCheckVal('ChEnable'));
        Form.addParameter('h.X_HW_MCIDEnable',getCheckVal('McidEnable'));
        Form.addParameter('h.X_HW_CLIPEnable',getCheckVal('CLipEnable'));
        
        if(0 == getCheckVal('anonymouscallEnable'))
        {
            Form.addParameter('h.CallerIDEnable',1);
        }
        else
        {
            Form.addParameter('h.CallerIDEnable',0);
        }
        if (CodecList[vagIndex].length > selctLindex*4)
        {
            domain += '&d=' + CodecList[vagIndex][selctLindex *4  + 0].Domain
                    + '&e=' + CodecList[vagIndex][selctLindex *4  + 1].Domain
                    + '&f=' + CodecList[vagIndex][selctLindex *4  + 2].Domain
                    + '&g=' + CodecList[vagIndex][selctLindex *4  + 3].Domain;
        }
		
        if (DspGainList[vagIndex].length > selctLindex)
        {
            domain += '&i='+ DspGainList[vagIndex][selctLindex].Domain;
        }    
		
        if (LineFeatureList[vagIndex].length > selctLindex)
        {
            domain += '&h='+ LineFeatureList[vagIndex][selctLindex].Domain;
        }
		

    }
    
    if(PhyListLength > 0)
    {
        Form.addParameter('j.RingVoltage',getSelectVal('RingVoltage'));
        Form.addParameter('j.RingDCVoltageOverlapped',getValue('RingDCVoltageOverlapped'));
        Form.addParameter('j.UserDefineRingVoltage',getValue('UserDefineRingVoltage'));
        Form.addParameter('j.SendGain',getSelectVal('SendGain'));
        Form.addParameter('j.ReceiveGain',getSelectVal('ReceiveGain'));
        Form.addParameter('j.HookFlashDownTime',getValue('HookFlashDownTime'));
        Form.addParameter('j.HookFlashUpTime',getValue('HookFlashUpTime'));    
        Form.addParameter('j.OnhookConfirmTime',getValue('OnhookConfirmTime')); 
        Form.addParameter('j.Current',getValue('Current'));
        Form.addParameter('j.ClipFormat',getSelectVal('ClipFormat'));
        Form.addParameter('j.FskTime',getValue('FskTime'));
        Form.addParameter('j.ClipTransWhen',getSelectVal('ClipTransWhen'));
        Form.addParameter('j.ReversePoleOnAnswer',getCheckVal('EnablePotsReversePole'));
		Form.addParameter('j.DspTemplateName', getValue('DspTemplateName'));
        Form.addParameter('k.Enable',getCheckVal('EnableDspTemplate'));
        Form.addParameter('k.WorkMode',getSelectVal('WorkMode'));
   
        domain += '&j='+ PhyInterfaceParams[parseInt(getSelectVal('PhyList'))-1].Domain
                + '&k='+ DspTemplateParams[parseInt(getSelectVal('PhyList'))-1].Domain;
                    
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    Form.setAction('set.cgi?' + domain + '&RequestFile=html/voip/voipuser/voipuser.asp');
    setDisable('btnApplyVoipUser3',1);
    setDisable('cancelValue3',1);
}

function setCtlDisplay(record)
{
    if (CodecList[vagIndex].length > selctLindex*4)
    {
        setText('codec1',CodecList[vagIndex][selctLindex*4 + 0].Codecs);
        setText('codec2',CodecList[vagIndex][selctLindex*4 + 1].Codecs);
        setText('codec3',CodecList[vagIndex][selctLindex*4 + 2].Codecs);
        setText('codec4',CodecList[vagIndex][selctLindex*4 + 3].Codecs);
            
        setSelect('PacketizationPeriod1',CodecList[vagIndex][selctLindex *4 + 0].PacketizationPeriod);
        setSelect('PacketizationPeriod2',CodecList[vagIndex][selctLindex *4 + 1].PacketizationPeriod);
        setSelect('PacketizationPeriod3',CodecList[vagIndex][selctLindex *4 + 2].PacketizationPeriod);
        setSelect('PacketizationPeriod4',CodecList[vagIndex][selctLindex *4 + 3].PacketizationPeriod);
        
        setText('Priority1',CodecList[vagIndex][selctLindex *4 + 0].Priority);
        setText('Priority2',CodecList[vagIndex][selctLindex *4 + 1].Priority);
        setText('Priority3',CodecList[vagIndex][selctLindex *4 + 2].Priority);
        setText('Priority4',CodecList[vagIndex][selctLindex *4 + 3].Priority);
        
        setCheck('EnableCodec1',CodecList[vagIndex][selctLindex *4 + 0].Enable);
        setCheck('EnableCodec2',CodecList[vagIndex][selctLindex *4 + 1].Enable);
        setCheck('EnableCodec3',CodecList[vagIndex][selctLindex *4 + 2].Enable);
        setCheck('EnableCodec4',CodecList[vagIndex][selctLindex *4 + 3].Enable);
    }

    if (DspGainList[vagIndex].length > selctLindex)
    {
		setText('dspsendgain',DspGainList[vagIndex][selctLindex].TransmitGain);	
		setText('dspreceivegain',DspGainList[vagIndex][selctLindex].ReceiveGain);
    }	
	
    if (LineFeatureList[vagIndex].length > selctLindex)
    {
        setCheck('HotlineEnable',LineFeatureList[vagIndex][selctLindex].X_HW_HotlineEnable);
        setText('HotlineNumber',LineFeatureList[vagIndex][selctLindex].X_HW_HotlineNumber);
        setText('HotlineTimer',LineFeatureList[vagIndex][selctLindex].X_HW_HotlineTimer);
        setCheck('CFUEnable',LineFeatureList[vagIndex][selctLindex].CallForwardUnconditionalEnable);
        setText('CFUNumber',LineFeatureList[vagIndex][selctLindex].CallForwardUnconditionalNumber);
        setCheck('CFBEnable',LineFeatureList[vagIndex][selctLindex].CallForwardOnBusyEnable);
        setText('CFBNumber',LineFeatureList[vagIndex][selctLindex].CallForwardOnBusyNumber);
        setCheck('CFNREnable',LineFeatureList[vagIndex][selctLindex].CallForwardOnNoAnswerEnable);
        setText('CFNRNumber',LineFeatureList[vagIndex][selctLindex].CallForwardOnNoAnswerNumber);
        setCheck('CwEnable',LineFeatureList[vagIndex][selctLindex].CallWaitingEnable);
        setCheck('WMIEnable',LineFeatureList[vagIndex][selctLindex].MWIEnable);
        setCheck('3pCallEnable',LineFeatureList[vagIndex][selctLindex].X_HW_3WayEnable);
        setCheck('ChEnable',LineFeatureList[vagIndex][selctLindex].X_HW_CallHoldEnable);
        setCheck('McidEnable',LineFeatureList[vagIndex][selctLindex].X_HW_MCIDEnable);
        setCheck('CLipEnable',LineFeatureList[vagIndex][selctLindex].X_HW_CLIPEnable);
        setCheck('anonymouscallEnable',LineFeatureList[vagIndex][selctLindex].CallerIDEnable);
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
        if(Line.length >= ((PhyInterfaceParams.length - 1) * 17))
        {
            setDisplay('ConfigForm1', 0);
            AlertEx(sipuser['vspa_manyusers']);
            return false;
        }   
        
        record = new stLine("","","Enabled","");
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(record);
    }
    else if (index == -2)
    {
        setDisplay('ConfigForm1', 0);
    }
    else
    {
        if(LineList[vagIndex].length > index)
        {
            record = LineList[vagIndex][index];
			
            setDisplay('ConfigForm1', 1);
            setCtlDisplay(record);
        }
    }
    g_Index = index;
	
	SelectLineRecord(index);
}

function clickRemove() 
{
    if (Line.length == 0)
    {
        AlertEx(sipuser['vspa_delunexistusers']);
        return;
    }
    
    if (selctIndex == -1)
    {
        AlertEx(sipuser['vspa_newuserdel']);
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
        AlertEx(sipuser['vspa_chooseuser']);
        return ;
    }
        
    if (ConfirmEx(sipuser['vspa_confirmdeluser']) == false)
    {
        return;
    }
    setDisable('btnApplySipUser',1);
    setDisable('cancelValue',1);
    removeInst('html/voip/voipuser/voipuser.asp');     
}  

function vspaisValidCfgStr(cfgName, val, len)
{
    if (isValidAscii(val) != '')         
    {  
        AlertEx(cfgName + sipinterface['vspa_hasvalidch'] + isValidAscii(val) + sipinterface['vspa_end']);          
        return false;       
    }
    if (val.length > len)
    {
        AlertEx(cfgName + sipinterface['vspa_cantexceed']  + len  + sipinterface['vspa_characters']);
        return false;
    }        
}

function CheckForm(type)
{
    var ulret = CheckForm1();    
    if (ulret != true )
    {
        return false;
    }
    
    var PhyList = document.getElementById('PhyList');
	
		
    if(PhyList.options.length == 0)
    {
        return true;
    }

    var EnableCodec1=document.getElementById('EnableCodec1').checked;
    var EnableCodec2=document.getElementById('EnableCodec2').checked;
    var EnableCodec3=document.getElementById('EnableCodec3').checked;
    var EnableCodec4=document.getElementById('EnableCodec4').checked;
	var Priority1= getValue('Priority1');
	var Priority2= getValue('Priority2');
	var Priority3= getValue('Priority3');
	var Priority4= getValue('Priority4');
    var RingDCVoltageOverlapped = getValue('RingDCVoltageOverlapped');
    var UserDefineRingVoltage = getValue('UserDefineRingVoltage');
    var HookFlashDownTime = getValue('HookFlashDownTime');
    var HookFlashUpTime = getValue('HookFlashUpTime');
    var OnhookConfirmTime = getValue('OnhookConfirmTime');
    var Current = getValue('Current');
    var FskTime = getValue('FskTime');
	var dspsendgain = getValue('dspsendgain');
	var dspreceivegain = getValue('dspreceivegain');

    for (var i = 1; i < 5; i++)
    {
        if (getValue('Priority' + i ) > 100 ) 
        {
            AlertEx(sipuser['vspa_priinva']);
            return false;
        }
    }

	if((getValue('Priority1') == "") || (getValue('Priority2') == "") || (getValue('Priority3') == "") || (getValue('Priority4') == ""))
	{
		AlertEx(sipuser['vspa_priinva']);
		return false;
	}
	
    if ( '' != removeSpaceTrim(getSelectVal('HotlineNumber')))
    {
        if (vspaisValidCfgStr(sipuser['vspa_hotline1']+sipuser['vspa_num1'],getSelectVal('HotlineNumber'),32) == false)
        {
            return false;
        }   
    }
    
    if ( '' != removeSpaceTrim(getSelectVal('CFUNumber')))
    {
        if (vspaisValidCfgStr(sipuser['vspa_cfu1']+sipuser['vspa_num1'],getSelectVal('CFUNumber'),32) == false)
        {
            return false;
        }   
    }
    
    if ( '' != removeSpaceTrim(getSelectVal('CFBNumber')))
    {
        if (vspaisValidCfgStr(sipuser['vspa_cfb1']+sipuser['vspa_num1'],getSelectVal('CFBNumber'),32) == false)
        {
            return false;
        }   
    }
    
    if ( '' != removeSpaceTrim(getSelectVal('CFNRNumber')))
    {
        if (vspaisValidCfgStr(sipuser['vspa_cfnr1']+sipuser['vspa_num1'],getSelectVal('CFNRNumber'),32) == false)
        {
            return false;
        }   
    }

    if ( (getValue('HotlineTimer') != "")&&((false == isInteger(getValue('HotlineTimer')))
		||(getValue('HotlineTimer') > 255) || (getValue('HotlineTimer') < 0)) || (getValue('HotlineTimer') == ""))
    {
        AlertEx(sipuser['vspa_hotlineinva']);
        return false;
    }

    if(PhyList.options.length == 0)
    {
        return true;
    }
	
    if(parseInt(RingDCVoltageOverlapped) < 0 || parseInt(RingDCVoltageOverlapped) > 25 || (getValue('RingDCVoltageOverlapped') == ""))
    {
       AlertEx(sipuser['vspa_dcbias']);
       return false;
    }

    if(parseInt(UserDefineRingVoltage) < 0 || parseInt(UserDefineRingVoltage) > 74 || (getValue('UserDefineRingVoltage') == ""))
    {
       AlertEx(sipuser['vspa_usrdefinva']);
       return false;
    }

    if(parseInt(HookFlashDownTime) < 0 || parseInt(HookFlashDownTime) > 1400 || (getValue('HookFlashDownTime') == ""))
    {
       AlertEx(sipuser['vspa_hookdowninva']);
       return false;
    }

    if(parseInt(HookFlashUpTime) < 0 || parseInt(HookFlashUpTime) > 1400 || (getValue('HookFlashUpTime') == ""))
    {
       AlertEx(sipuser['vspa_hookupinva']);
       return false;
    }

    if(parseInt(OnhookConfirmTime) < 0 || parseInt(OnhookConfirmTime) > 1400 || (getValue('OnhookConfirmTime') == ""))
    {
       AlertEx(sipuser['vspa_onhookconinva']);
       return false;
    }

    if((parseInt(HookFlashUpTime) <= parseInt(HookFlashDownTime)) || ((parseInt(OnhookConfirmTime) <= parseInt(HookFlashUpTime)) && (parseInt(OnhookConfirmTime) != 0)))
    {
       AlertEx(sipuser['vspa_hookcheck']);
       return false;
    }
	
    if(parseInt(Current) < 16 || parseInt(Current) > 49 || (getValue('Current') == ""))
    {
       AlertEx(sipuser['vspa_curinva']);
       return false;
    }

    if(parseInt(FskTime) < 0 || parseInt(FskTime) > 2000 || (getValue('FskTime') == "")) 
    {
       AlertEx(sipuser['vspa_intervalbef']);
       return false;
    }		
	if(parseInt(dspsendgain) < -100 || parseInt(dspsendgain) > 30 || (getValue('dspsendgain') == ""))
	{
		AlertEx(sipuser['vspa_dspsendgaininva']);
		return false;
	}
	
	if(parseInt(dspreceivegain) < -100 || parseInt(dspreceivegain) > 30 || (getValue('dspreceivegain') == ""))
	{
		AlertEx(sipuser['vspa_dspreceivegaininva']);
		return false;
	}
    return true;
}

function CancelConfig()
{
    setVagInfo();
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
        if(LineList[vagIndex].length > selctIndex)
        {
            var record = LineList[vagIndex][selctIndex];
            setCtlDisplay(record);
            setPhyInterfaceParams();
        }
    }
}

function setPhyList(objname)
{
    var PhyPortList = "";
    var selectObj = getElement(objname);
    var tempList;

    removeAllOption(objname);

    
    if((LineList[vagIndex].length > selctLindex)&&(selctLindex >= 0))
    {
        PhyPortList = LineList[vagIndex][selctLindex].PhyReferenceList;
    }
	

    if(PhyPortList.length == 0)
    {
        setDisplay("voipadv3",0);
		return;
    }
	
	if(PhyPortList=='' || parseInt(PhyPortList) > PhyNum)
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
            selectObj.options[vagIndex].selected = true;
        }
        catch(ex)
        {
            
        }
    }

}

function setRingVoltagePara()
{
    var RingVoltage = getElement("RingVoltage");
    
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
    setText("Current",PhyInterfaceParams[PhyID].Current);
    setSelect("ClipFormat",PhyInterfaceParams[PhyID].ClipFormat);
    setText("FskTime",PhyInterfaceParams[PhyID].FskTime);
    setSelect("ClipTransWhen",PhyInterfaceParams[PhyID].ClipTransWhen);
    setCheck("EnableDspTemplate",DspTemplateParams[PhyID].Enable);
    setRingVoltagePara();
    setDspTemplatePara();
    setFskClipPara();
    setCheck("EnablePotsReversePole",PhyInterfaceParams[PhyID].ReversePoleOnAnswer);
	setText("DspTemplateName",PhyInterfaceParams[PhyID].DspTemplateName);
}

function SubmitGetProfile(vagInst)
{    
    var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('SetVoiceVagIndex.cgi?vagIndex=' + vagInst);
    Form.setTarget('disableIframe');
    Form.submit();
    
    vagIndex = GetVagIndexByInst(vagInst);
    LoadFrame();
}
</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipUser", GetDescFormArrayById(sipuser, "v01"), GetDescFormArrayById(sipuser, "v02"), false);
</script>
<div class="title_spread"></div>
<script type="text/javascript">
if(Profile.length > 2)
{
    document.write('<iframe name="disableIframe" style="display:none"></iframe>');
    document.write('<table border="0" cellpadding="0" cellspacing="0">');
    document.write('<tr>');
    var html = '';
    
    for(var i = 0; i < Profile.length-1; i++)
    {
        var vagInst = parseInt(i)+1;
        html += '<td><input id="vag_' + i + '" name="vag_tr" onfocus="this.blur()" type="button" class="submit" style="cursor:pointer;background:#C3C3C3;font-size: 12px;height: 25px;width: 110px;border: 0px;" onClick="SubmitGetProfile(' +htmlencode(Profile[i].profileid)+ ');"/>';
        html += '</td>';
    }
    
    document.write(html);
    document.write('</tr>');
    document.write('</table>');
}
</script>


<form id="voipadv1">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_interfaceadv'></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="X_HW_RTPExtend_EchoCancellationEnable" RealType="CheckBox" DescRef="vspa_enableecho" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_RTPExtend_EchoCancellationEnable" InitValue="Empty"/>
<li id="SubscribeEnable_checkbox" RealType="CheckBox" DescRef="vspa_subscribeenable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SubscribeEnable_checkbox" InitValue="Empty"/>
<li id="FaxT38_Enable" RealType="DropDownList" DescRef="vspa_faxtran" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="FaxT38_Enable" InitValue="[{TextRef:'vspa_passthr',Value:'0'},{TextRef:'vspa_t38',Value:'1'}]"/>
<li id="X_HW_FaxModem_FaxNego" RealType="DropDownList" DescRef="vspa_faxswitch" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_FaxModem_FaxNego" InitValue="[{TextRef:'vspa_selfswitch',Value:'0'},{TextRef:'vspa_negotiation',Value:'1'}]"/>
<li id="X_HW_SIPProfile_Body" RealType="TextArea" DescRef="vspa_profilebody" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_SIPProfile_Body" InitValue="Empty" Elementclass="interfacetextclass"/>
<li id="SelectSoftwarePara" RealType="DropDownList" DescRef="vspa_softpara" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SelectSoftwarePara" InitValue="[{TextRef:'vspa_default',Value:'0'},{TextRef:'vspa_userdefine',Value:'1'}]" ClickFuncApp="onchange=onChangeSoftware"/>
<li id="X_HW_SIPExtend_SoftwarePara" RealType="TextBox" DescRef="vspa_userdef" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_SIPExtend_SoftwarePara" InitValue="Empty"/>
<li id="shorttimer" RealType="TextBox" DescRef="vspa_shorttimer" RemarkRef="vspa_uints" ErrorMsgRef="Empty" Require="FALSE" BindField="shorttimer" InitValue="Empty"/>
<li id="longtimer" RealType="TextBox" DescRef="vspa_longtimer" RemarkRef="vspa_uints" ErrorMsgRef="Empty" Require="FALSE" BindField="longtimer" InitValue="Empty"/>
<li id="HW_ShareUserMode" RealType="DropDownList" DescRef="vspa_shareusermode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="HW_ShareUserMode" InitValue="[{TextRef:'vspa_disabled',Value:'Disabled'},{TextRef:'vspa_ringparall',Value:'RingParallel'}]"/>
<li id="HW_MultiHomeMode" RealType="DropDownList" DescRef="vspa_multihomemode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="HW_MultiHomeMode" InitValue="[{TextRef:'vspa_disabled',Value:'Disabled'},{TextRef:'vspa_dualhome',Value:'DualHome'},{TextRef:'vspa_dualhomeswitch',Value:'DualHomeAutoSwitchOver'},{TextRef:'vspa_dualhomeauto',Value:'LoadSharing'}]" Elementclass="MultiHomeModetextareaclass"/>
<li id="HW_DtmfMethod" RealType="DropDownList" DescRef="vspa_dtmfmethod" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="HW_DtmfMethod" InitValue="[{TextRef:'vspa_dtmfinband',Value:'InBand'},{TextRef:'vspa_dtmf2833',Value:'RFC2833'},{TextRef:'vspa_dtmfsipinfo',Value:'SIPInfo'}]"/>
<li id="HW_Rfc2833PT" RealType="TextBox" DescRef="vspa_Rfc2833PT" RemarkRef="vspa_2833len" ErrorMsgRef="Empty" Require="FALSE" BindField="HW_Rfc2833PT" InitValue="Empty"/>
<li id="HW_ServerType" RealType="DropDownList" DescRef="vspa_servertype" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="HW_ServerType" InitValue="[{TextRef:'vspa_ims',Value:'0'},{TextRef:'vspa_ngn',Value:'1'}]"/>
<li id="OffhookDtasAckInterval" RealType="TextBox" DescRef="vspa_DtasAck" RemarkRef="vspa_DtasAckhint" ErrorMsgRef="Empty" Require="FALSE" BindField="OffhookDtasAckInterval" InitValue="Empty"/>
<li id="X_HW_Option120PriorityMode" RealType="DropDownList" DescRef="vspa_Option120Priority" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_Option120PriorityMode" InitValue="[{TextRef:'vspa_Option120Ignore',Value:'0'},{TextRef:'vspa_Option120PriorityHighest',Value:'1'},{TextRef:'vspa_Option120PriorityLowest',Value:'2'}]"/>
<script>
var VoipConfigFormList1 = HWGetLiIdListByForm("voipadv1", null);
HWParsePageControlByID("voipadv1", TableClass, sipuser, null);
</script>
</table>
</form>

<div class="func_spread"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_useradvpara'></td>
  </tr>
</table>

<script language="JavaScript" type="text/javascript">
var i = 0;
var ShowableFlag = 1;
var ShowButtonFlag = 0;

var ColumnNum = 5;
var ConfiglistInfo = new Array(new stTableTileInfo("vspa_seq","align_center","index",false),
							new stTableTileInfo("vspa_uri3","wordclass align_center","URI",false),
							new stTableTileInfo("vspa_regusername","wordclass align_center","TelNo",false),
							new stTableTileInfo("vspa_authusername","wordclass align_center","AuthUserName",false),
							new stTableTileInfo("vspa_assopots","align_center","PhyReferenceList",false),null);

function GetVAGPara(vagInsId)
{
	var VoipArray = new Array();
	
	if (LineList[vagInsId].length == 0)
    {
		var VoipShowTab = new ShowTab();
		VoipShowTab.index = "--";
		VoipShowTab.URI = "--";
		VoipShowTab.TelNo = "--";
		VoipShowTab.AuthUserName = "--";
		VoipShowTab.PhyReferenceList = "--";
    }
	else
	{
		for (var i = 0; i < LineList[vagInsId].length; i++)
		{
			var VoipShowTab = new ShowTab();
			
			VoipShowTab.index = i+1;	
			
			if (AuthList[vagInsId][i].URI == "")
			{
				VoipShowTab.URI = "--";
				 
			}
			else
			{
				VoipShowTab.URI = AuthList[vagInsId][i].URI;
			}
			
			if (LineList[vagInsId][i].DirectoryNumber == "")
			{
				VoipShowTab.TelNo = "--";
			}
			else
			{
				VoipShowTab.TelNo = LineList[vagInsId][i].DirectoryNumber;
			}
			if (AuthList[vagInsId][i].AuthUserName == "")
			{
				VoipShowTab.AuthUserName = "--";   
			}
			else
			{
				VoipShowTab.AuthUserName = AuthList[vagInsId][i].AuthUserName;    
			}   
			if (LineList[vagInsId][i].PhyReferenceList == "")  
			{
				VoipShowTab.PhyReferenceList = "--";  
			}     
			else
			{
				VoipShowTab.PhyReferenceList = LineList[vagInsId][i].PhyReferenceList;
			}           
			VoipArray.push(VoipShowTab);
		}
	}
	
	VoipArray.push(null);
	return VoipArray;
}

for(var index = 0 ; index < maxvagnum; index++)
{
	var tableid = "linelist"+index;
	VoipArray = GetVAGPara(index);
	HWShowTableListByType(ShowableFlag, tableid, ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, sipuser, null);
}
</script>

<div id="ConfigForm1">
    <table width="100%" border="0" cellpadding="0" cellspacing="1"  id="CodecInfo" class="tabal_bg">
    <tr class="head_title">    
    <script type="text/javascript">
    if (curLanguage == "chinese"){
        document.write('<td class="width_per15 head_title" rowspan="5" align="middle" BindText="vspa_codec"></td>');
        document.write('<td class="width_per15" BindText="vspa_enable"></td>');
        document.write('<td class="width_per20" BindText="vspa_codectype"></td>');
        document.write('<td class="width_per20" BindText="vspa_period"></td>');
        document.write('<td class="width_per30" BindText="vspa_priority"></td>');
    }
    else{
        document.write('<td class="width_per20" BindText="vspa_codec"></td>');
        document.write('<td class="width_per30" BindText="vspa_period"></td>');
        document.write('<td class="width_per30" BindText="vspa_priority"></td>');
        document.write('<td class="width_per20" BindText="vspa_enable"></td>');
    }
</script>                
</tr> 

<script type="text/javascript">
    if (curLanguage == "chinese"){ 
    document.write(
    '<tr class="align_left table_title">'
    +'<td class="align_center" ><input id="EnableCodec1" name="EnableCodec1" value="1" type="checkbox" onclick="" /></td>');
    if (CodecList[vagIndex].length > 0)
    {
        document.write("<td>" + htmlencode(CodecList[vagIndex][0].Codecs) + "</td>" );
    }
    else
    {
        document.write("<td>" + '-- '+ "</td>" );    
    }    
    document.write(
    '<td>'
    +'<select name="PacketizationPeriod1" id="PacketizationPeriod1" class="width_80px">'
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority1" id="Priority1" maxlength="256" value=""  class="width_50px"/> <span class="gray">(1-100)</span></td>'
    +'</tr>'
    +'<tr class="table_title">'
    +'<td class="align_center" ><input id="EnableCodec2" name="EnableCodec2" value="1" type="checkbox" onclick="" /></td>'
    );
    if (CodecList[vagIndex].length > 1)
    {
        document.write("<td>" + htmlencode(CodecList[vagIndex][1].Codecs) + "</td>" );
    }
    else
    {
        document.write("<td>" + '-- '+ "</td>" );    
    }    
    
    document.write(
    '<td>'    
    +'<select name="PacketizationPeriod2" id="PacketizationPeriod2" class="width_80px">'
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'    
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority2" id="Priority2" maxlength="256" value="" class="width_50px"/> <span class="gray">(1-100)</span></td>'
    +'</tr> '    
    +'<tr class="table_title">'
    +'<td class="align_center"><input id="EnableCodec3" name="EnableCodec3" value="1" type="checkbox" onclick="" /></td>'
    );
    
    if (CodecList[vagIndex].length > 2)
    {
        document.write("<td>" + htmlencode(CodecList[vagIndex][2].Codecs) + "</td>" );
    }
    else
    {
        document.write("<td>" + '-- '+ "</td>" );    
    }
    
    document.write(
    '<td>'
    +'<select name="PacketizationPeriod3" id="PacketizationPeriod3" class="width_80px">'    
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'
    +'</select>'    
    +'</td>'
    +'<td><input type="text" name="Priority3" id="Priority3" maxlength="256" value="" class="width_50px"/> <span class="gray">(1-100)</span></td>'
    +'</tr>'
    +'<tr class="table_title">'    
    +'<td class="align_center"><input id="EnableCodec4" name="EnableCodec4"  value="1" type="checkbox" onclick=""/></td>'
    );
    
    if (CodecList[vagIndex].length > 3)
    {
        document.write("<td>" + htmlencode(CodecList[vagIndex][3].Codecs) + "</td>" );
    }
    else
    {
        document.write("<td>" + '-- '+ "</td>" );    
    }
    
    document.write(
    '<td>'
    +'<select name="PacketizationPeriod4" id="PacketizationPeriod4" class="width_80px">'
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'    
    +'<option value="30">30 </option>'
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority4" id="Priority4" maxlength="256" value="" class="width_50px"/> <span class="gray">(1-100)</span></td>'    
    +'</tr>'
    );
} 
    else{
    document.write(
    '<tr class="align_left table_title">'
    +'<td>'
    +'<input type="text" value="G.711MuLaw" id="codec1" disabled="disabled" />'
    +'</td>' 
    +'<td>'
    +'<select name="PacketizationPeriod1" id="PacketizationPeriod1" class="width_80px">'
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority1" id="Priority1" maxlength="256" value="" class="width_50px"/> <span class="gray">' + sipuser['vspa_prioritylen'] + '</span></td>'
    +'<td class="align_center" ><input id="EnableCodec1" name="EnableCodec1" value="1" type="checkbox" /></td>'
    +'</tr>'
    +'<tr class="table_title">'
    +'<td>'
    +'<input type="text" value="G.711ALaw" id="codec2" disabled="disabled" />'
    +'</td>'
    +'<td>'
    +'<select name="PacketizationPeriod2" id="PacketizationPeriod2" class="width_80px">'
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority2" id="Priority2" maxlength="256" value="" class="width_50px"/> <span class="gray">' + sipuser['vspa_prioritylen'] + '</span></td>'
    +'<td class="align_center" ><input id="EnableCodec2" name="EnableCodec2" value="1" type="checkbox" /></td>'
    +'</tr>'
    +'<tr class="table_title">'
    +'<td>'
    +'<input type="text" value="G.729" id="codec3" disabled="disabled" />'
    +'</td>'
    +'<td>'
    +'<select name="PacketizationPeriod3" id="PacketizationPeriod3" class="width_80px">'
    +'<option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority3" id="Priority3" maxlength="256" class="width_50px" /> <span class="gray">' + sipuser['vspa_prioritylen'] + '</span></td>'
    +'<td class="align_center"><input id="EnableCodec3" name="EnableCodec3" type="checkbox" /></td>'
    +'</tr>'
    +'<tr class="table_title">'
    +'<td>'
    +'<input type="text" id="codec4" value="G.722" disabled="disabled" />'
    +'</td>'
    +'<td>'
    +'<select name="PacketizationPeriod4" id="PacketizationPeriod4" class="width_80px">'
    +' <option value="10">10 </option>'
    +'<option value="20">20 </option>'
    +'<option value="30">30 </option>'
    +'</select>'
    +'</td>'
    +'<td><input type="text" name="Priority4" id="Priority4" maxlength="256" value="" class="width_50px"/> <span class="gray">' + sipuser['vspa_prioritylen'] + '</span></td>'
    +'<td class="align_center"><input id="EnableCodec4" name="EnableCodec4"  value="1" type="checkbox" onclick="" /></td>'
    +'</tr>');
}
        
</script>   
</table>

<form id="voipadv2">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="dspsendgain" RealType="TextBox" DescRef="vspa_dspsendgain" RemarkRef="vspa_dspsendgainrange" ErrorMsgRef="Empty" Require="FALSE" BindField="dspsendgain" InitValue="Empty"/>
<li id="dspreceivegain" RealType="TextBox" DescRef="vspa_dspreceivegain" RemarkRef="vspa_dspreceivegainrange" ErrorMsgRef="Empty" Require="FALSE" BindField="dspreceivegain" InitValue="Empty"/>
<li id="HotlineEnable" RealType="CheckBox" DescRef="vspa_hotlienable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="HotlineEnable" InitValue="Empty"/>
<li id="HotlineNumber" RealType="TextBox" DescRef="vspa_hotlinum" RemarkRef="vspa_tellength" ErrorMsgRef="Empty" Require="FALSE" BindField="HotlineNumber" InitValue="Empty"/>
<li id="HotlineTimer" RealType="TextBox" DescRef="vspa_hotlidelay" RemarkRef="vspa_delaytimerRange" ErrorMsgRef="Empty" Require="FALSE" BindField="HotlineTimer" InitValue="Empty"/>

<li id="CFUEnable" RealType="CheckBox" DescRef="vspa_cfuable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="CFUEnable" InitValue="Empty"/>
<li id="CFUNumber" RealType="TextBox" DescRef="vspa_cfunum" RemarkRef="vspa_tellength" ErrorMsgRef="Empty" Require="FALSE" BindField="CFUNumber" InitValue="Empty"/>
<li id="CFBEnable" RealType="CheckBox" DescRef="vspa_cfbable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="CFBEnable" InitValue="Empty"/>
<li id="CFBNumber" RealType="TextBox" DescRef="vspa_cfbnum" RemarkRef="vspa_tellength" ErrorMsgRef="Empty" Require="FALSE" BindField="CFBNumber" InitValue="Empty"/>
<li id="CFNREnable" RealType="CheckBox" DescRef="vspa_cfnrenable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="CFNREnable" InitValue="Empty"/>
<li id="CFNRNumber" RealType="TextBox" DescRef="vspa_cfnrnum" RemarkRef="vspa_tellength" ErrorMsgRef="Empty" Require="FALSE" BindField="CFNRNumber" InitValue="Empty"/>
<li id="CwEnable" RealType="CheckBox" DescRef="vspa_cwenable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="CwEnable" InitValue="Empty"/>
<li id="WMIEnable" RealType="CheckBox" DescRef="vspa_wmi" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="WMIEnable" InitValue="Empty"/>
<li id="3pCallEnable" RealType="CheckBox" DescRef="vspa_3ptycall" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="3pCallEnable" InitValue="Empty"/>
<li id="ChEnable" RealType="CheckBox" DescRef="vspa_callhold" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ChEnable" InitValue="Empty"/>
<li id="McidEnable" RealType="CheckBox" DescRef="vspa_mcid" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="McidEnable" InitValue="Empty"/>
<li id="CLipEnable" RealType="CheckBox" DescRef="vspa_clip" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="CLipEnable" InitValue="Empty"/>
<li id="anonymouscallEnable" RealType="CheckBox" DescRef="vspa_anonymouscall" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="anonymouscallEnable" InitValue="Empty"/>
<script>
var VoipConfigFormList2 = HWGetLiIdListByForm("voipadv2", null);
HWParsePageControlByID("voipadv2", TableClass, sipuser, null);
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
<li id="PhyList" RealType="DropDownList" DescRef="vspa_portindex" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyList" InitValue="Empty"/>
<li id="RingVoltage" RealType="DropDownList" DescRef="vspa_ringvol" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RingVoltage" InitValue="[{TextRef:'vspa_ring74v',Value:'0'},{TextRef:'vspa_ring65v',Value:'1'},{TextRef:'vspa_ring50v',Value:'2'},{TextRef:'vspa_userdefine',Value:'3'}]" ClickFuncApp="onchange=setRingVoltagePara"/>
<li id="UserDefineRingVoltage" RealType="TextBox" DescRef="vspa_usrringvol" RemarkRef="vspa_uintvrms" ErrorMsgRef="Empty" Require="FALSE" BindField="UserDefineRingVoltage" InitValue="Empty"/>
<li id="RingDCVoltageOverlapped" RealType="TextBox" DescRef="vspa_uintvdc" RemarkRef="vspa_uintv" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>

<li id="SendGain" RealType="DropDownList" DescRef="vspa_sendgain" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SendGain" InitValue="[{TextRef:'m6db',Value:'-6db'},{TextRef:'m55db',Value:'-5.5db'},{TextRef:'m5db',Value:'-5db'},{TextRef:'m45db',Value:'-4.5db'},{TextRef:'m4db',Value:'-4db'},{TextRef:'m35db',Value:'-3.5db'},{TextRef:'m3db',Value:'-3db'},{TextRef:'m25db',Value:'-2.5db'},{TextRef:'m2db',Value:'-2db'},{TextRef:'m15db',Value:'-1.5db'},{TextRef:'m1db',Value:'-1db'},{TextRef:'m05db',Value:'-0.5db'},{TextRef:'zerodb',Value:'0db'},{TextRef:'po5db',Value:'0.5db'},{TextRef:'p1db',Value:'1db'},{TextRef:'p15db',Value:'1.5db'},{TextRef:'p2db',Value:'2db'},{TextRef:'p25db',Value:'2.5db'},{TextRef:'p3db',Value:'3db'},{TextRef:'p35db',Value:'3.5db'},{TextRef:'p4db',Value:'4db'},{TextRef:'p45db',Value:'4.5db'},{TextRef:'p5db',Value:'5db'},{TextRef:'p55db',Value:'5.5db'},{TextRef:'p6db',Value:'6db'}]"/>
<li id="ReceiveGain" RealType="DropDownList" DescRef="vspa_recgain" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ReceiveGain" InitValue="[{TextRef:'zerodb',Value:'0db'},{TextRef:'m05db',Value:'-0.5db'},{TextRef:'m1db',Value:'-1db'},{TextRef:'m15db',Value:'-1.5db'},{TextRef:'m2db',Value:'-2db'},{TextRef:'m25db',Value:'-2.5db'},{TextRef:'m3db',Value:'-3db'},{TextRef:'m35db',Value:'-3.5db'},{TextRef:'m4db',Value:'-4db'},{TextRef:'m45db',Value:'-4.5db'},{TextRef:'m5db',Value:'-5db'},{TextRef:'m55db',Value:'-5.5db'},{TextRef:'m6db',Value:'-6db'},{TextRef:'m65db',Value:'-6.5db'},{TextRef:'m7db',Value:'-7db'},{TextRef:'m75db',Value:'-7.5db'},{TextRef:'m8db',Value:'-8db'},{TextRef:'m85db',Value:'-8.5db'},{TextRef:'m9db',Value:'-9db'},{TextRef:'m95db',Value:'-9.5db'},{TextRef:'m10db',Value:'-10db'},{TextRef:'m105db',Value:'-10.5db'},{TextRef:'m11db',Value:'-11db'},{TextRef:'m115db',Value:'-11.5db'},{TextRef:'m12db',Value:'-12db'}]"/>
<li id="HookFlashDownTime" RealType="TextBox" DescRef="vspa_hookdown" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="HookFlashDownTime" InitValue="Empty"/>
<li id="HookFlashUpTime" RealType="TextBox" DescRef="vspa_hookup" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="HookFlashUpTime" InitValue="Empty"/>
<li id="OnhookConfirmTime" RealType="TextBox" DescRef="vspa_onhook" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="OnhookConfirmTime" InitValue="Empty"/>
<li id="Current" RealType="TextBox" DescRef="vspa_current" RemarkRef="vspa_ma" ErrorMsgRef="Empty" Require="FALSE" BindField="Current" InitValue="Empty"/>
<li id="ClipFormat" RealType="DropDownList" DescRef="vspa_clipformat" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ClipFormat" InitValue="[{TextRef:'sdmf',Value:'Sdmf-fsk'},{TextRef:'mdmf',Value:'Mdmf-fsk'},{TextRef:'dtmf',Value:'Dtmf'},{TextRef:'etsi',Value:'etsi'}]" ClickFuncApp="onchange=setFskClipPara"/>
<li id="FskTime" RealType="TextBox" DescRef="vspa_fsk" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="FskTime" InitValue="Empty"/>
<li id="ClipTransWhen" RealType="DropDownList" DescRef="vspa_clipflow" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ClipTransWhen" InitValue="[{TextRef:'vspa_afterring',Value:'AfterRing'},{TextRef:'vspa_beforering',Value:'BeforeRing'}]"/>
<li id="EnableDspTemplate" RealType="CheckBox" DescRef="vspa_enabledsptem" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="EnableDspTemplate" InitValue="Empty" ClickFuncApp="onclick=setDspTemplatePara"/>
<li id="WorkMode" RealType="DropDownList" DescRef="vspa_workmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="WorkMode" InitValue="[{TextRef:'vspa_workmodevo',Value:'Voice'},{TextRef:'vspa_workmodefax',Value:'Fax'},{TextRef:'vspa_workmodemodem',Value:'Modem'}]"/>
<li id="DspTemplateName" RealType="TextOtherBox" DescRef="vspa_gDspTmpName" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DspTemplateName" InitValue="[{Type:'span', Item:[{AttrName:'id', AttrValue:'base3span'},{AttrName:'Type', AttrValue:'span'}, {AttrName:'class', AttrValue:'impedancetextclass'}, {AttrName:'innerhtml', AttrValue:'vspa_gDspTmpNamehint'}]}]" />
<li id="EnablePotsReversePole" RealType="CheckBox" DescRef="vspa_enablepots" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="EnablePotsReversePole" InitValue="Empty"/>
<script>
var VoipConfigFormList3 = HWGetLiIdListByForm("voipadv3", null);
HWParsePageControlByID("voipadv3", TableClass, sipuser, null);
</script>
</table>
</form>
</div>



<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
<tr >
	<td class="table_submit width_per20"></td>
	<td width="80%" class="table_submit align_left" colspan="10">
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<input name="btnApplyVoipUser3" id="btnApplyVoipUser3" type="button" class="ApplyButtoncss buttonwidth_100px" value="Apply" onClick="Submit();"/> 
	  <script type="text/javascript">
		document.getElementsByName('btnApplyVoipUser3')[0].value = sipuser['vspa_apply'];    
	  </script>
	<input name="cancelValue3" id="cancelValue3" type="button" class="CancleButtonCss buttonwidth_100px" value="Cancel" onClick="CancelConfig();"/> 
	  <script type="text/javascript">
		document.getElementsByName('cancelValue3')[0].value = sipuser['vspa_cancel'];    
	  </script>            
	</td>
</tr>
</table>
<br></br>



</body>
</html>
