<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<!--
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.js);%>"></script>
-->
<title>VOIP Interface</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, statistic);%>"></script>
<script language="JavaScript" type="text/javascript"> 


function setLastestPhyIndexCookie(name, value, expiredays)
{
	var exdate = new Date();
	
	exdate.setDate(exdate.getDate() + expiredays);
	if (null == expiredays)
	{
		document.cookie = name + "=" + value;
	}
	else
	{
		document.cookie = name + "=" + value + ";expires=" + exdate.toGMTString();
	}
}

function SetContentInBuff(PhyReferenceIndex)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './SetQualPhyInsInBuff.cgi?'+'QualityPhyIns='+String(PhyReferenceIndex),
	data :'x.X_HW_Token=' + getValue('hwonttoken'),
	success : function(data) 
	{
	
	}
	});

	return null;

}

function getLastestPhyIndexCookie(name)
{
	var content = 1;
	
	if(name == "VoiceQualitySelect")
	{
		content = '<%HW_WEB_GetContentInBuff("3");%>';
	}
	else
	{
		;
	}
	
	return content;
}

function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
	this.InterfaceID = InterfaceID;
}
var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function stVoiceQualityStatics(Domain, StatTime, TxPackets, RxPackets, MeanDelay, MeanJitter, FractionLoss, FarEndIPAddress, MosLq, Codec)
{
	this.Domain = Domain;
	this.StatTime = StatTime;
	this.TxPackets = TxPackets;
	this.RxPackets = RxPackets;
	this.MeanDelay = MeanDelay;
	this.MeanJitter = MeanJitter;
	this.FractionLoss = FractionLoss;
	this.FarEndIPAddress = FarEndIPAddress;
	this.MosLq = MosLq;
	this.Codec = Codec;
}

var CurrentVoiceQualityPhyIndex = 1;
var tmpVoiceQualityPhyIndex = getLastestPhyIndexCookie('VoiceQualitySelect');
if (null != tmpVoiceQualityPhyIndex)
{
	if(tmpVoiceQualityPhyIndex < AllPhyInterface.length)
	{
		CurrentVoiceQualityPhyIndex = tmpVoiceQualityPhyIndex;
	}	
}

var PotsAllVoiceQuality = new Array();
if ( 1 == CurrentVoiceQualityPhyIndex)
{
	PotsAllVoiceQuality = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.X_HW_Stats.PoorQualityList.{i}, StatTime|TxPackets|RxPackets|MeanDelay|MeanJitter|FractionLoss|FarEndIPAddress|MosLq|Codec, stVoiceQualityStatics);%>;
}
if ( 2 == CurrentVoiceQualityPhyIndex)
{
	PotsAllVoiceQuality = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.X_HW_Stats.PoorQualityList.{i}, StatTime|TxPackets|RxPackets|MeanDelay|MeanJitter|FractionLoss|FarEndIPAddress|MosLq|Codec, stVoiceQualityStatics);%>;
}
if ( 3 == CurrentVoiceQualityPhyIndex)
{
	PotsAllVoiceQuality = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.X_HW_Stats.PoorQualityList.{i}, StatTime|TxPackets|RxPackets|MeanDelay|MeanJitter|FractionLoss|FarEndIPAddress|MosLq|Codec, stVoiceQualityStatics);%>;
}
if ( 4 == CurrentVoiceQualityPhyIndex)
{
	PotsAllVoiceQuality = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.4.X_HW_Stats.PoorQualityList.{i}, StatTime|TxPackets|RxPackets|MeanDelay|MeanJitter|FractionLoss|FarEndIPAddress|MosLq|Codec, stVoiceQualityStatics);%>;
}

function SubmitRefreshVoiceQuality()
{
	var PhyReferenceIndex = getSelectVal('VoiceQualitySelect');
	
	var Form = new webSubmitForm();
	
	Form.addParameter('x.ResetStatistics',0);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

	SetContentInBuff(PhyReferenceIndex);

    Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.'	+ String(PhyReferenceIndex)+ '.X_HW_Stats'
	               +'&RequestFile=html/voip/statistic/voipstatistic.asp');
	Form.submit();	
}

function SubmitResetVoiceQuality()
{
	
    var Form = new webSubmitForm();
	var PhyReferenceIndex = getSelectVal('VoiceQualitySelect');
		
	Form.addParameter('x.ResetStatistics',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

	SetContentInBuff(PhyReferenceIndex);

    Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.'	+ String(PhyReferenceIndex)+ '.X_HW_Stats'
	               +'&RequestFile=html/voip/statistic/voipstatistic.asp');
    Form.submit();
}


function DropDownListSelect(id, ArrayOption)
{
    var Control = getElById(id);
    var i = 1;  
	
    for (i = 1; i <  ArrayOption.length; i++)
    {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
		Option.text = i;
        Control.appendChild(Option);
    }
}

function LoadFrame()
{
	setSelect('VoiceQualitySelect', CurrentVoiceQualityPhyIndex);
	
	var textarea = document.getElementById("logarea");
	textarea.value = '<%HW_WEB_GetVoiceLogInfo();%>';
	
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = statistic[b.getAttribute("BindText")];
	}
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipProtocol", GetDescFormArrayById(statistic, "v01"), GetDescFormArrayById(statistic, "v02"), false);
</script>
<div class="title_spread"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
  <tr> 
    <td BindText='vspa_qualitytitle'></td> 
  </tr> 
</table> 

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class="title_common" BindText='v03'></td> 
        </tr> 
        <tr> 
          <td class="title_common" BindText='vspa_qualitygood'></td> 
        </tr> 
        <tr> 
          <td class="title_common" BindText='vspa_qualitygeneral'></td> 
        </tr> 
        <tr> 
          <td class="title_common" BindText='vspa_qualitybad'></td> 
        </tr>
        <tr> 
          <td class="title_common" BindText='vspa_qualitymuchbad'></td> 
        </tr>					
      </table>
	</td>
  </tr> 
</table> 

<form id="voipstatics">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
<li id="VoiceQualitySelect" RealType="DropDownList" DescRef="vspa_potsindex"  RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="VoiceQualitySelect" InitValue="Empty"/>
<script>
var VoipConfigFormList1 = HWGetLiIdListByForm("voipstatics", null);
HWParsePageControlByID("voipstatics", TableClass, statistic, null);
var PhySetArray = new Array();
DropDownListSelect("VoiceQualitySelect",AllPhyInterface);
HWSetTableByLiIdList(VoipConfigFormList1, PhySetArray, null);
</script>
</table>
</form>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr>
    <td class="table_title table_submit align_left">
    			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	          <input name="refreshVoiceQuality" id="refreshVoiceQuality" type="button" class="ApplyButtoncss buttonwidth_150px_250px" value="refresh statistics" onClick="SubmitRefreshVoiceQuality();"/> 
			  <script type="text/javascript">
			  	document.getElementsByName('refreshVoiceQuality')[0].value = statistic['vspa_qualityresresh'];	
			  </script>
	          <input name="resetVoiceQuality" id="resetVoiceQuality" type="button" class="CancleButtonCss buttonwidth_150px_250px" value="reset statistics" onClick="SubmitResetVoiceQuality();"/> 
			  <script type="text/javascript">
			  	document.getElementsByName('resetVoiceQuality')[0].value = statistic['vspa_qualityreset'];	
			  </script>
	</td>
  </tr>
</table>

<div>
	<table width="100%" height="5" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed; word-break:break-all">
	<tr class="head_title">
	<script type="text/javascript">
		document.write('<td class="width_per6"  BindText="vspa_qualityseq"></td>');
		document.write('<td class="width_per19" BindText="vspa_qualitytime"></td>');
		document.write('<td class="width_per9"  BindText="vspa_sendpacket"></td>');
		document.write('<td class="width_per9"  BindText="vspa_recvpacket"></td>');
		document.write('<td class="width_per9"  BindText="vspa_delay"></td>');
		document.write('<td class="width_per9"  BindText="vspa_jitter"></td>');
		document.write('<td class="width_7p"  BindText="vspa_packetloss"></td>');
		document.write('<td class="width_per13" BindText="vspa_remoteip"></td>');	
		document.write('<td class="width_7p"  BindText="vspa_mosvalue"></td>');	
		document.write('<td class="width_per12" BindText="vspa_qualitycodec"></td>');	
		
		if (PotsAllVoiceQuality.length > 1)
		{
			for ( var k = 0; k < PotsAllVoiceQuality.length - 1; k++)
			{
				var html = '';  
				html += '<tr class="table_right">';
				
				html += '<td class="align_left">' + (k+1) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].StatTime) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].TxPackets) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].RxPackets) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].MeanDelay) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].MeanJitter) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].FractionLoss) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].FarEndIPAddress) + '</td>';																
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].MosLq/10) + '</td>';
				html += '<td class="align_left">' + htmlencode(PotsAllVoiceQuality[k].Codec) + '</td>';
	
				html += '</tr>';                    
				document.write(html);						
			}
		}
	</script>	
	</tr>
</table>
</div>


<div class="func_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
  <tr> 
    <td BindText="vspa_logtitle"></td> 
  </tr> 
</table> 

<div id="logviews"> 
  <textarea dir="ltr" name="logarea" id="logarea" class="text_log" wrap="off" readonly="readonly">
  </textarea>
</div> 


</body>
</html>
