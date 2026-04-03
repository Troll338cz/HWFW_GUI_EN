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
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248user);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>

<script language="JavaScript" type="text/javascript">

var POTSNum = 2;
function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
}
var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;
var isOltVisualUser = "<% HW_WEB_IfVisualOltUser();%>";

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

function stPhyInterfaceParam(Domain,ClipFormat,ClipSendDateTime)
{
	this.Domain = Domain;
	this.ClipFormat = ClipFormat;
	this.ClipSendDateTime = ClipSendDateTime;
}
var PhyInterfaceParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.X_HW_Extend,ClipFormat|ClipSendDateTime, stPhyInterfaceParam);%>;


function CheckForm2()
{
	 return true;
}

function stH248Server(Domain, HeartbeatMode)
{
    this.Domain = Domain;                           
    this.HeartbeatMode = HeartbeatMode;
}

var AllH248Server = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248,HeartbeatMode,stH248Server);%>;


function stH248Extend(Domain, HeartBeatTimer,HeartBeatRetransTimer, HeartBeatRetransTimes)
{
    this.Domain = Domain; 
	this.HeartBeatTimer = HeartBeatTimer;                          
    this.HeartBeatRetransTimer = HeartBeatRetransTimer;
	this.HeartBeatRetransTimes = HeartBeatRetransTimes;
}
var H248Extend = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Extend,HeartBeatTimer|HeartBeatRetransTimer|HeartBeatRetransTimes,stH248Extend);%>;


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


function AddSubmitParam(Form,type)
{
	var selectLineId= getSelectVal('LineSelectId');
	
	var phyid = Line[selectLineId-1].PhyReferenceList;
	

	
	Form.addParameter('u.ClipFormat',getSelectVal('CallIDShowMode_select'));
	Form.addParameter('u.ClipSendDateTime',getSelectVal('ClipSendDateTime'));
	Form.addParameter('a.HeartbeatMode',getCheckVal('HeartbeatMode_checkbox'));
	Form.addParameter('b.HeartBeatTimer',getValue('HeartBeatTimer'));
	Form.addParameter('b.HeartBeatRetransTimer',getValue('HeartbeatCycle_text'));
	Form.addParameter('b.HeartBeatRetransTimes',getValue('HeartbeatCount_text'));
	
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('set.cgi?u=' + PhyInterfaceParams[parseInt(getSelectVal('PhyID'))-1].Domain
								+ '&a=' + AllH248Server[0].Domain
								+ '&b=' + H248Extend[0].Domain
								+ '&RequestFile=html/voip/voipsub/cnvoipsub.asp');
	
	setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
	
}

function OnLineSelectChange()
{

	var selectLineId= getSelectVal('LineSelectId');
	var phyid = Line[selectLineId-1].PhyReferenceList;
	
	
	
	setText('PhyID',phyid);
	
	setSelect("CallIDShowMode_select",PhyInterfaceParams[phyid-1].ClipFormat);
	setSelect("ClipSendDateTime",PhyInterfaceParams[phyid-1].ClipSendDateTime);


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
        b.innerHTML = h248user[b.getAttribute("BindText")];
    }
	
	setCheck('HeartbeatMode_checkbox',AllH248Server[0].HeartbeatMode);
	setText('HeartBeatTimer',H248Extend[0].HeartBeatTimer);
	setText('HeartbeatCycle_text',H248Extend[0].HeartBeatRetransTimer);
    setText('HeartbeatCount_text',H248Extend[0].HeartBeatRetransTimes);
	
	var selectLineId= getSelectVal('LineSelectId');
	var phyid = Line[selectLineId-1].PhyReferenceList;
	setText('PhyID',phyid);		
	setDisable('PhyID',1);
	
	setSelect("CallIDShowMode_select",PhyInterfaceParams[phyid-1].ClipFormat);
	setSelect("ClipSendDateTime",PhyInterfaceParams[phyid-1].ClipSendDateTime);
	
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
	<td class="width_20p tabal_head">语音用户</td> 
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


<table width="100%" border="0" cellpadding="0" cellspacing="1" >
    <tr>
        <td class="table_title width_20p">心跳：</td> 
        <td width="80%" class="table_right" colspan="10" >
		<input name='HeartbeatMode_checkbox' type='checkbox' id='HeartbeatMode_checkbox' value='0' /> </td> 
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_20p">心跳周期：</td>
        <td width="80%" class="table_right" colspan="10" >
             <input type="text" id="HeartBeatTimer" class="width_125px"/><span class="gray"> (单位：秒) </span>
        </td>
    </tr>	
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_20p">心跳重试间隔：</td>
        <td width="80%" class="table_right" colspan="10" >
             <input type="text" id="HeartbeatCycle_text" class="width_125px"/><span class="gray"> (单位：秒) </span>
        </td>
    </tr>	
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_20p">心跳次数：</td>
        <td width="80%" class="table_right" colspan="10" >
             <input type="text" id="HeartbeatCount_text" class="width_125px"/>
             </td>
    </tr>	
</table>

<table id="PortDisplay" width="100%" border="0" cellpadding="0" cellspacing="1" >	
<tr>
	<td class="width_20p table_title">端口号：</td>
	<td width="80%"  class="table_right" colspan="10">
	<input type="text" id="PhyID" class="width_125px"/>
	</td>
</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_20p">来显模式：</td>
        <td width="80%"  class="table_right" colspan="10">
            <select id="CallIDShowMode_select" class="width_125px">
				<option value="Dtmf">DTMF</option>
				<option value="Mdmf-fsk">FSK</option>
                <option value="Sdmf-fsk">Sdmf-fsk</option>
                <option value="R1.5">R1.5</option>
                <option value="etsi">Etsi</option>
            </select>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" >
	<tr>
        <td class="table_title width_20p">时间同步：</td>
        <td width="80%" class="table_right" colspan="10" >
            <select id="ClipSendDateTime" class="width_125px">
                <option value="0" selected="selected">不同步</option>
                <option value="1">同步系统时间</option>
                <option value="2">同步核心网时间</option>
            </select>
        </td>
    </tr>
</table>


    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="">
    <tr >
        <td class=" width_20p"></td>
        <td width="80%" class="" colspan="10" align="right">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply" onClick="ApplyHighConfig();"/> 
          <script type="text/javascript">
            document.getElementsByName('SaveApply_button')[0].value = h248user['e8cvspa_apply'];    
          </script>
        <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel" onClick="CancelHighConfig();"/> 
          <script type="text/javascript">
            document.getElementsByName('Cancel_button')[0].value = h248user['vspa_cancel'];    
          </script>            
        </td>
    </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr><td class="height10p"></td></tr>
</table>

</body>
</html>