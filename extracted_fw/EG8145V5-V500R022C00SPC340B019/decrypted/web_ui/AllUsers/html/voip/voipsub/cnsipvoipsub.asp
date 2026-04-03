<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<title>VOIP User</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipuser);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">



var selctIndex = -1;
var selctLindex = 0;
var POTSNum = 2;
var vagIndex = 0;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';
var isOltVisualUser = "<% HW_WEB_IfVisualOltUser();%>";
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

function stProfile(Domain, HW_DtmfMethod, X_HW_ServerType)
{
    this.Domain = Domain;
    this.HW_DtmfMethod = HW_DtmfMethod;
    this.X_HW_ServerType = X_HW_ServerType;
    var temp = Domain.split('.');
    this.profileid = temp[5];
}

var Profile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},DTMFMethod|X_HW_ServerType,stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);

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

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|Enable|PhyReferenceList,stLine);%>;

var LineList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllLine.length-1; i++)
{
    var temp = AllLine[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    LineList[index].push(AllLine[i]);
}

function stHotLine(Domain, X_HW_HotlineEnable, X_HW_HotlineNumber, X_HW_HotlineTimer, CallWaitingEnable, CallForwardUnconditionalEnable, CallForwardUnconditionalNumber, CallForwardOnBusyEnable, CallForwardOnBusyNumber, CallForwardOnNoAnswerEnable, CallForwardOnNoAnswerNumber, MWIEnable, X_HW_3WayEnable, X_HW_CallHoldEnable, X_HW_MCIDEnable, X_HW_CLIPEnable, CallerIDEnable,X_HW_ConferenceFactoryUri, CallTransferEnable, AnonymousCalEnable)
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
	this.X_HW_ConferenceFactoryUri = X_HW_ConferenceFactoryUri;
    if(0 == CallerIDEnable)
    {
        this.CallerIDEnable = 1;
    }
    else
    {
        this.CallerIDEnable = 0;
    }
	this.CallTransferEnable = CallTransferEnable;
	this.AnonymousCalEnable = AnonymousCalEnable;
}    
    
var AllLineFeature = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.CallingFeatures, X_HW_HotlineEnable|X_HW_HotlineNumber|X_HW_HotlineTimer|CallWaitingEnable|CallForwardUnconditionalEnable|CallForwardUnconditionalNumber|CallForwardOnBusyEnable|CallForwardOnBusyNumber|CallForwardOnNoAnswerEnable|CallForwardOnNoAnswerNumber|MWIEnable|X_HW_3WayEnable|X_HW_CallHoldEnable|X_HW_MCIDEnable|X_HW_CLIPEnable|CallerIDEnable|X_HW_ConferenceFactoryUri|CallTransferEnable|AnonymousCalEnable, stHotLine);%>;

var LineFeatureList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllLineFeature.length-1; i++)
{
    var temp = AllLineFeature[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    LineFeatureList[index].push(AllLineFeature[i]);
}

function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
}
var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

function stPhyInterfaceParam(Domain,ClipFormat,ClipSendDateTime,ReversePoleOnAnswer)
{
	this.Domain = Domain;
	this.ClipFormat = ClipFormat;
	this.ClipSendDateTime = ClipSendDateTime;
	this.ReversePoleOnAnswer = ReversePoleOnAnswer;
}
var PhyInterfaceParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.X_HW_Extend,ClipFormat|ClipSendDateTime|ReversePoleOnAnswer, stPhyInterfaceParam);%>;

function stSIP(Domain, X_HW_SubscribeEnable)
{
	this.Domain = Domain;
	this.X_HW_SubscribeEnable = X_HW_SubscribeEnable;
}
var SIP = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP,X_HW_SubscribeEnable,stSIP);%>;

function stSIPExtend(Domain, ThreeWayMixType, ConferenceFactoryUri)
{
    this.Domain = Domain;
    this.ThreeWayMixType = ThreeWayMixType;
    this.ConferenceFactoryUri = ConferenceFactoryUri;
}
var SIPExtend = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPExtend,ThreeWayMixType|ConferenceFactoryUri,stSIPExtend);%>;

function CheckForm2()
{
	return true;
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

function CancelConfig()
{
	LoadFrame();
}

function AddSubmitParam(Form,type)
{
	var selectLineId= getSelectVal('LineSelectId');
	
	var phyid = AllLine[selectLineId-1].PhyReferenceList;
	
	Form.addParameter('u.ClipFormat',getSelectVal('CallIDShowMode_select'));
	Form.addParameter('u.ClipSendDateTime',getSelectVal('TimeSyncMode_select'));
	Form.addParameter('u.ReversePoleOnAnswer',getCheckVal('PolarityReverseEnable_checkbox'));
	Form.addParameter('h.X_HW_HotlineEnable',getCheckVal('HotLineEnable_checkbox'));
	Form.addParameter('h.X_HW_HotlineNumber',getSelectVal('HotLineURI_text'));
	Form.addParameter('h.X_HW_ConferenceFactoryUri',getSelectVal('ConferenceURI_text'));
	Form.addParameter('h.X_HW_HotlineTimer',getSelectVal('HotLineDelay_text'));

    if (isWanAccess != true) {
        Form.addParameter('h.CallForwardUnconditionalEnable', getCheckVal('CFUEnable'));
        Form.addParameter('h.CallForwardUnconditionalNumber', getSelectVal('CFUNumber'));
        Form.addParameter('h.CallForwardOnBusyEnable', getCheckVal('CFBEnable'));
        Form.addParameter('h.CallForwardOnBusyNumber', getSelectVal('CFBNumber'));
        Form.addParameter('h.CallForwardOnNoAnswerEnable', getCheckVal('CFNREnable'));
        Form.addParameter('h.CallForwardOnNoAnswerNumber', getSelectVal('CFNRNumber'));
    }

	Form.addParameter('h.CallWaitingEnable',getCheckVal('CallWaitingEnable_checkbox'));
	Form.addParameter('h.MWIEnable',getCheckVal('WMIEnable'));
	Form.addParameter('h.X_HW_3WayEnable',getCheckVal('ConferenceCallEnable_checkbox'));
	Form.addParameter('h.X_HW_CallHoldEnable',getCheckVal('ChEnable'));
	Form.addParameter('h.X_HW_MCIDEnable',getCheckVal('McidEnable'));
	Form.addParameter('h.X_HW_CLIPEnable',getCheckVal('CLipEnable'));
	Form.addParameter('h.CallTransferEnable',getCheckVal('CallTransEnable'));
	
	if(0 == getCheckVal('anonymouscallEnable'))
	{
		Form.addParameter('h.CallerIDEnable',1);
	}
	else
	{
		Form.addParameter('h.CallerIDEnable',0);
	}
	Form.addParameter('h.AnonymousCalEnable',getCheckVal('AnonymousCalEnable'));
	Form.addParameter('a.X_HW_SubscribeEnable',getCheckVal('SubscribeEnable_checkbox'));
	Form.addParameter('b.ThreeWayMixType',getSelectVal('ConferenceURI_select'));
	Form.addParameter('b.ConferenceFactoryUri',getSelectVal('ConferenceFactoryUri'));
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('set.cgi?u=' + PhyInterfaceParams[parseInt(getSelectVal('PhyID'))-1].Domain
								+ '&h=' + LineFeatureList[vagIndex][selectLineId-1].Domain
								+ '&a=' + SIP[vagIndex].Domain
								+ '&b=' + SIPExtend[vagIndex].Domain
								+ '&RequestFile=html/voip/voipsub/cnvoipsub.asp');
	
	setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
	
}

function SetIMSPara()
{
	var X_HW_ServerType = Profile[vagIndex].X_HW_ServerType;
	
	if ("0" == X_HW_ServerType)
	{
		setDisplay("TrIMS",1);
	}
	else
	{
		setDisplay("TrIMS",0);
	}	
}

function OnLineSelectChange()
{
	
	var selectLineId = getSelectVal('LineSelectId');
	
	var phyid  = AllLine[selectLineId-1].PhyReferenceList;

	setText('PhyID',phyid);
	
	setSelect("CallIDShowMode_select",PhyInterfaceParams[phyid-1].ClipFormat);
	setSelect("TimeSyncMode_select",PhyInterfaceParams[phyid-1].ClipSendDateTime);
	setCheck("PolarityReverseEnable_checkbox",PhyInterfaceParams[phyid-1].ReversePoleOnAnswer);
	setCheck('HotLineEnable_checkbox',AllLineFeature[selectLineId-1].X_HW_HotlineEnable);
	setText('HotLineURI_text',AllLineFeature[selectLineId-1].X_HW_HotlineNumber);
	setText('ConferenceURI_text',AllLineFeature[selectLineId-1].X_HW_ConferenceFactoryUri);
	setText('HotLineDelay_text',AllLineFeature[selectLineId-1].X_HW_HotlineTimer);
	setCheck('CFUEnable',AllLineFeature[selectLineId-1].CallForwardUnconditionalEnable);
	setText('CFUNumber',AllLineFeature[selectLineId-1].CallForwardUnconditionalNumber);
	setCheck('CFBEnable',AllLineFeature[selectLineId-1].CallForwardOnBusyEnable);
	setText('CFBNumber',AllLineFeature[selectLineId-1].CallForwardOnBusyNumber);
	setCheck('CFNREnable',AllLineFeature[selectLineId-1].CallForwardOnNoAnswerEnable);
	setText('CFNRNumber',AllLineFeature[selectLineId-1].CallForwardOnNoAnswerNumber);
	setCheck('CallWaitingEnable_checkbox',AllLineFeature[selectLineId-1].CallWaitingEnable);
	setCheck('WMIEnable',AllLineFeature[selectLineId-1].MWIEnable);
	setCheck('ConferenceCallEnable_checkbox',AllLineFeature[selectLineId-1].X_HW_3WayEnable);
	setCheck('ChEnable',AllLineFeature[selectLineId-1].X_HW_CallHoldEnable);
	setCheck('McidEnable',AllLineFeature[selectLineId-1].X_HW_MCIDEnable);
	setCheck('CLipEnable',AllLineFeature[selectLineId-1].X_HW_CLIPEnable);
	setCheck('anonymouscallEnable',AllLineFeature[selectLineId-1].CallerIDEnable);
	setCheck('CallTransEnable',AllLineFeature[selectLineId-1].CallTransferEnable);
	setCheck('AnonymousCalEnable',AllLineFeature[selectLineId-1].AnonymousCalEnable);
	
	setCheck('SubscribeEnable_checkbox',SIP[vagIndex].X_HW_SubscribeEnable);
	setSelect('ConferenceURI_select',SIPExtend[vagIndex].ThreeWayMixType);
	setText('ConferenceFactoryUri',SIPExtend[vagIndex].ConferenceFactoryUri);

}

function CancelHighConfig()
{
	LoadFrame();
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
        b.innerHTML = sipuser[b.getAttribute("BindText")];
    }
	
	var selectLineId= getSelectVal('LineSelectId');
	
	var phyid  = AllLine[selectLineId-1].PhyReferenceList;
		
	setText('PhyID',phyid);	
	setDisable('PhyID',1);
	
	SetIMSPara();
	if(AllPhyInterface.length > POTSNum)
	{
		setDisplay('LineDisplay',1);
		setDisplay('PortDisplay',1);
	}
	else
	{
		setDisplay('LineDisplay',0);
		setDisplay('PortDisplay',0);	
	}

	
	setSelect("CallIDShowMode_select",PhyInterfaceParams[phyid-1].ClipFormat);
	setSelect("TimeSyncMode_select",PhyInterfaceParams[phyid-1].ClipSendDateTime);
	setCheck("PolarityReverseEnable_checkbox",PhyInterfaceParams[phyid-1].ReversePoleOnAnswer);
	setCheck('HotLineEnable_checkbox',AllLineFeature[selectLineId-1].X_HW_HotlineEnable);
	setText('HotLineURI_text',AllLineFeature[selectLineId-1].X_HW_HotlineNumber);
	setText('ConferenceURI_text',AllLineFeature[selectLineId-1].X_HW_ConferenceFactoryUri);
	setText('HotLineDelay_text',AllLineFeature[selectLineId-1].X_HW_HotlineTimer);
	setCheck('CFUEnable',AllLineFeature[selectLineId-1].CallForwardUnconditionalEnable);
	setText('CFUNumber',AllLineFeature[selectLineId-1].CallForwardUnconditionalNumber);
	setCheck('CFBEnable',AllLineFeature[selectLineId-1].CallForwardOnBusyEnable);
	setText('CFBNumber',AllLineFeature[selectLineId-1].CallForwardOnBusyNumber);
	setCheck('CFNREnable',AllLineFeature[selectLineId-1].CallForwardOnNoAnswerEnable);
	setText('CFNRNumber',AllLineFeature[selectLineId-1].CallForwardOnNoAnswerNumber);
	setCheck('CallWaitingEnable_checkbox',AllLineFeature[selectLineId-1].CallWaitingEnable);
	setCheck('WMIEnable',AllLineFeature[selectLineId-1].MWIEnable);
	setCheck('ConferenceCallEnable_checkbox',AllLineFeature[selectLineId-1].X_HW_3WayEnable);
	setCheck('ChEnable',AllLineFeature[selectLineId-1].X_HW_CallHoldEnable);
	setCheck('McidEnable',AllLineFeature[selectLineId-1].X_HW_MCIDEnable);
	setCheck('CLipEnable',AllLineFeature[selectLineId-1].X_HW_CLIPEnable);
	setCheck('anonymouscallEnable',AllLineFeature[selectLineId-1].CallerIDEnable);
	setCheck('CallTransEnable',AllLineFeature[selectLineId-1].CallTransferEnable);
	setCheck('AnonymousCalEnable',AllLineFeature[selectLineId-1].AnonymousCalEnable);
	setCheck('SubscribeEnable_checkbox',SIP[vagIndex].X_HW_SubscribeEnable);
	setSelect('ConferenceURI_select',SIPExtend[vagIndex].ThreeWayMixType);
	
	setText('ConferenceFactoryUri',SIPExtend[vagIndex].ConferenceFactoryUri);
	
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

    if (isWanAccess == true) {
        setDisable('CFUEnable', true);
        setDisable('CFUNumber', true);
        setDisable('CFBEnable', true);
        setDisable('CFBNumber', true);
        setDisable('CFNREnable', true);
        setDisable('CFNRNumber', true);
    }
}

</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<table>
    <tr> 
        <td class="tabal_head" colspan="11">语音补充业务</td>
    </tr>
</table>

<div id="LineDisplay">
<tr>
	<td class="width_per20 tabal_head">语音用户：</td> 
	<td width="80%"  class="table_right" colspan="10">
		<select id="LineSelectId" name="LineSelectId" class="wid_75px" onchange=OnLineSelectChange()>
			<script language="JavaScript" type="text/javascript">
	          var lineIndex;
	          for (lineIndex = 1; lineIndex < AllLine.length; lineIndex++)
	          {
	 	          document.write('<option value="' + lineIndex + '">' + lineIndex + '</option>');
	          }			
			</script>
		</select>
	</td>
</tr>
</div>
<table id="PortDisplay"  width="100%" border="0" cellpadding="0" cellspacing="1" >	
<tr>
	<td class="width_per20 table_title">端口号：</td>
	<td width="80%"  class="table_right" colspan="3">
	<input type="text" id="PhyID" class="width_123px"/>
	</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20">极性反转：</td>
        <td class="table_right" colspan="3">
            <input type="checkbox" id="PolarityReverseEnable_checkbox" name="PolarityReverseEnable_checkbox" />
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_per20" BindText='vspa_clipformat1'></td>
        <td class="table_right" colspan="3">
            <select id="TimeSyncMode_select" class="width_123px">
                <option value="0" selected="selected">不同步</option>
                <option value="1">同步系统时间</option>
                <option value="2">同步核心网时间</option>
            </select>
        </td>
    </tr>
	
    <tr>
        <td class="table_title width_per20">来显模式：</td>
        <td class="table_right" colspan="3">
            <select id="CallIDShowMode_select" class="width_123px">
			<option value="Dtmf">DTMF</option>
			<option value="Mdmf-fsk">FSK</option>
            <option value="Sdmf-fsk">Sdmf-fsk</option>
                <option value="R1.5">R1.5</option>
                <option value="etsi">Etsi</option>
            </select>
        </td>
    </tr>
</table>
<div id="TrIMS">
<table  width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_subscribenble'>
        </td>
        <td class="table_right" colspan="3">
            <input type="checkbox" id="SubscribeEnable_checkbox" name="SubscribeEnable_checkbox" />
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
<tr>
        <td class="table_title width_per20" BindText='vspa_threewaytype'></td>
        <td class="table_right" colspan="3">
            <select id="ConferenceURI_select" class="width_123px">
                <option value="ATABased" selected="selected">终端本地</option>
                <option value="NetworkBased">服务器</option>
            </select>
        </td>
    </tr>
</table>

		
<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_per20" BindText='vspa_threewayuri'>
        </td>
        <td width="80%" class="table_right" colspan="3" >
             <input type="text" id="ConferenceURI_text" class="width_123px"/>
             </td>
        </td>
    </tr>	
</table>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_3ptycall'></td> 
        <td class="table_right" colspan="3"><input name='ConferenceCallEnable_checkbox' type='checkbox' id='ConferenceCallEnable_checkbox' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_cwenable'></td> 
        <td class="table_right" colspan="3"><input name='CallWaitingEnable_checkbox' type='checkbox' id='CallWaitingEnable_checkbox' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1">
    <tr>	
        <td rowspan="3" class="width_per20 table_title" BindText='vspa_hotline'></td>
        <td class="width_per13 table_right align_left" BindText='vspa_enable1'></td>
        <td class="width_per75 table_right align_left" colspan="2" ><input name='HotLineEnable_checkbox' type='checkbox' id='HotLineEnable_checkbox' value='1' /></td>
    </tr>
    <tr>
        <td class="width_per13 table_right align_left" BindText='vspa_num'></td>
        <td class="width_per75 table_right align_left" colspan="2" ><input type="text" name="HotLineURI_text" maxlength="32" id = "HotLineURI_text" class="width_150px"/>
        <span class="gray"><script>document.write(sipuser['vspa_tellength']);</script></span></td>
    </tr>
    <tr>
        <td class="width_per13 table_right align_left" BindText='vspa_delaytimer'></td> 
        <td class="width_per75 table_right align_left" colspan="2" ><input type="text" name="HotLineDelay_text" id = "HotLineDelay_text" class="width_150px"/>
        <span class="gray"><script>document.write(sipuser['vspa_uints']);</script>(0-255) </span></td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td rowspan="2" class="width_per20 table_title" BindText='vspa_cfu'></td>
        <td class="width_per13 table_right align_left" BindText='vspa_enable1'></td>
        <td class="width_per75 table_right align_left" colspan="2" ><input name='CFUEnable' type='checkbox' id='CFUEnable' value='1' /></td>
    </tr>
    <tr>
        <td class="table_right align_left" BindText='vspa_num'></td>
        <td class="table_right align_left" colspan="2" ><input type="text" name="CFUNumber" maxlength="32" id = "CFUNumber" class="width_150px"/>
        <span class="gray"><script>document.write(sipuser['vspa_tellength']);</script></span></td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td rowspan="2" class="width_per20 table_title" BindText='vspa_cfb'></td>
        <td class="width_per13 table_right align_left" BindText='vspa_enable1'></td>
        <td class="width_per75 table_right align_left" colspan="2" ><input name='CFBEnable' type='checkbox' id='CFBEnable' value='1' /></td>
    </tr>
    <tr>
        <td class="table_right align_left" BindText='vspa_num'></td>
        <td class="table_right align_left" colspan="2" ><input type="text" name="CFBNumber" maxlength="32" id = "CFBNumber" class="width_150px"/>
        <span class="gray"><script>document.write(sipuser['vspa_tellength']);</script></span></td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td rowspan="2" class="width_per20 table_title" BindText='vspa_cfnr'></td>
        <td class="width_per13 table_right align_left" BindText='vspa_enable1'></td>
        <td class="width_per75 table_right align_left" colspan="2" ><input name='CFNREnable' type='checkbox' id='CFNREnable' value='1' /></td>
    </tr>
    <tr>
        <td class="table_right align_left" BindText='vspa_num'></td>
        <td class="table_right align_left" colspan="2" ><input type="text" name="CFNRNumber" maxlength="32" id = "CFNRNumber" class="width_150px"/>
        <span class="gray"><script>document.write(sipuser['vspa_tellength']);</script></span></td>
    </tr>
</table>



<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_wmi'></td> 
        <td class="table_right" colspan="3"><input name='WMIEnable' type='checkbox' id='WMIEnable' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_callhold'></td> 
        <td class="table_right" colspan="3"><input name='ChEnable' type='checkbox' id='ChEnable' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_mcid'></td> 
        <td class="table_right" colspan="3"><input name='McidEnable' type='checkbox' id='McidEnable' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_clip'></td> 
        <td class="table_right" colspan="3"><input name='CLipEnable' type='checkbox' id='CLipEnable' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_calltransenable'></td> 
        <td class="table_right" colspan="3"><input name='CallTransEnable' type='checkbox' id='CallTransEnable' value='0' /> </td> 
    </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_anonymouscall'></td> 
        <td class="table_right" colspan="3"><input name='anonymouscallEnable' type='checkbox' id='anonymouscallEnable' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_per20" BindText='vspa_anonymouscallenable'></td> 
        <td class="table_right" colspan="3"><input name='AnonymousCalEnable' type='checkbox' id='AnonymousCalEnable' value='0' /> </td> 
    </tr>
</table>

    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="">
    <tr >
        <td class=" width_per20"></td>
        <td width="80%" class="" colspan="10" align="right">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply" onClick="ApplyHighConfig();"/> 
          <script type="text/javascript">
            document.getElementsByName('SaveApply_button')[0].value = sipuser['e8cvspa_apply'];    
          </script>
        <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel" onClick="CancelConfig();"/> 
          <script type="text/javascript">
            document.getElementsByName('Cancel_button')[0].value = sipuser['vspa_cancel'];    
          </script>            
        </td>
    </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr><td class="height10p"></td></tr>
</table>

</body>
</html>