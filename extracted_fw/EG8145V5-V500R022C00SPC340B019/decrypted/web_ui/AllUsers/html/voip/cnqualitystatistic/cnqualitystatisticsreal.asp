<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>VOIP Interface</title>
<script language="JavaScript" type="text/javascript"> 

function stAuthState(AuthState)
{
	this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>; 
var SimIsAuth=SimConnStates[0].AuthState;

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
	SetContentInBuff(PhyReferenceIndex);
	
	var Form = new webSubmitForm();
	Form.submit();	
}

function SubmitResetVoiceQuality()
{
    var Form = new webSubmitForm();
	var PhyReferenceIndex = getSelectVal('VoiceQualitySelect');
	
	SetContentInBuff(PhyReferenceIndex);
	
	Form.addParameter('x.ResetStatistics',1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.'	+ String(PhyReferenceIndex)+ '.X_HW_Stats'
	               +'&RequestFile=html/voip/cnqualitystatistic/cnqualitystatistics.asp');
    Form.submit();
}


function LoadFrame()
{ 
    if (0 != SimIsAuth)
    {
        document.getElementById('SimShowPage').style.display="";
    }
	setSelect('VoiceQualitySelect', CurrentVoiceQualityPhyIndex);
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<div id="SimShowPage" style = "display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%">  您可以查询语音质量最差的统计数据，以下网络指标供参考。</td> 
        </tr> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%">  理想网络：丢包率=0，平均抖动<10ms，平均时延<10ms；</td> 
        </tr> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%">  一般网络：0<丢包率<1%，10ms<平均抖动<20ms，10ms<平均时延<150ms；</td> 
        </tr> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%">  较差网络：1%<丢包率<5%，20ms<平均抖动<60ms，150ms<平均时延<400ms；</td> 
        </tr> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%">  恶劣网络：丢包率>5%，平均抖动>60ms，平均时延>400ms。 </td> 
        </tr> 									
      </table></td> 
  </tr> 
</table> 
<table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr>
    <td  class="table_title" width="30%" align="left">物理端口:</td> 
    <td  class="table_right" width="70%"  align="left">
		<select name="VoiceQualitySelect" id="VoiceQualitySelect" style="width: 40px">
	       <script language="JavaScript" type="text/javascript">
	          var interfaceIndex;
	          for (interfaceIndex = 1; interfaceIndex < AllPhyInterface.length; interfaceIndex++)
	          {
	 	          document.write('<option value="' + interfaceIndex + '">' + interfaceIndex + '</option>');
	          }
	       </script>
		</select>
	</td> 
  </tr>
</table> 

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
  <tr> 
    <td class="table_submit" width='30%'></td> 
    <td class="table_submit" align="left">
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  <input  class="submit" name="refreshVoiceQuality" id="refreshVoiceQuality" type="button" value="刷新统计" onClick="SubmitRefreshVoiceQuality();"> 
      <input  class="submit" name="resetVoiceQuality" id="resetVoiceQuality" type="button" value="重置统计" onClick="SubmitResetVoiceQuality();"> 
	</td>  
  </tr> 
</table>

<form id="ConfigForm"> 
<div>

    		<table width="100%" height="5" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed;word-break:break-all">
            <tr class="head_title">
                <td width="6%">编号</td>                
                <td width="21%">生成时间</td>
				<td width="9%">发送包数(个)</td>
				<td width="9%">接收包数(个)</td>
				<td width="9%">平均时延(ms)</td>                
				<td width="9%">平均抖动(ms)</td>                
				<td width="7%">丢包率(%)</td>                
				<td width="12%">远端IP</td>                
				<td width="7%">Mos值</td>
				<td width="11%">编解码</td>                
            </tr>
			<script type="text/javascript">
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
			</table>

</div>



<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
	<td></td> 
  </tr> 
</table> 

</form> 
</div>
</body>
</html>
