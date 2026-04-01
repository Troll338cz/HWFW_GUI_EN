<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Chinese -- VOIP Status</title>
<script language="JavaScript" type="text/javascript">

var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";

function stVoiceProfile(Domain, SignalingProtocol, X_HW_DigitMapSpecialEnable, X_HW_DigitMapSpecial )
{
    this.Domain = Domain;
	this.SignalingProtocol = SignalingProtocol;
	this.X_HW_DigitMapSpecialEnable = X_HW_DigitMapSpecialEnable;
	this.X_HW_DigitMapSpecial = X_HW_DigitMapSpecial;
}
var AllVoiceProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1, SignalingProtocol|X_HW_DigitMapSpecialEnable|X_HW_DigitMapSpecial, stVoiceProfile);%>;
											 
function stLinePhyList(Domain, PhyReferenceList)
{
    this.Domain = Domain;
    this.PhyReferenceList = PhyReferenceList;
}

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i}, PhyReferenceList, stLinePhyList);%>;

function stLineCallingFT(Domain, X_HW_PBXPrefixEnable, X_HW_CentrexPrefix)
{
    this.Domain = Domain;
	this.X_HW_PBXPrefixEnable = X_HW_PBXPrefixEnable;
    this.X_HW_CentrexPrefix = X_HW_CentrexPrefix;
}

var LineCallingFT = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i}.CallingFeatures, X_HW_PBXPrefixEnable|X_HW_CentrexPrefix,stLineCallingFT);%>;

function SubmitApply()
{
	var Form = new webSubmitForm();

	var ProfilePath = 'InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1';
	var LinePath = 'InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.' + getSelectVal('LineId') + '.CallingFeatures';
	
	Form.addParameter('x.X_HW_DigitMapSpecialEnable', getCheckVal('SpecDMEnable'));
	Form.addParameter('x.X_HW_DigitMapSpecial',getValue('SpecDM'));

	Form.addParameter('y.X_HW_PBXPrefixEnable',getCheckVal('PbxPreFixEnable'));
	Form.addParameter('y.X_HW_CentrexPrefix',getValue('PbxPreFix'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	Form.setAction('set.cgi?x=' + ProfilePath + 
				   '&y=' + LinePath +
				   '&RequestFile=html/voip/advdigitmap/advdm.asp');
	setDisable('Apply', 1);
	setDisable('Cancle', 1);
	Form.submit();
}

function SubmitCancle()
{
    setSelect('potsindex', 0);
    setCheck('ReverseEnable', 0);
	initDisplay();
}

function initDisplay()
{
	setCheck('SpecDMEnable',AllVoiceProfile[0].X_HW_DigitMapSpecialEnable);
	setText('SpecDM',AllVoiceProfile[0].X_HW_DigitMapSpecial);
	setCheck('PbxPreFixEnable',LineCallingFT[0].X_HW_PBXPrefixEnable);
	setText('PbxPreFix',LineCallingFT[0].X_HW_CentrexPrefix);
}

function LoadFrame()
{
	if ("H248" == AllVoiceProfile[0].SignalingProtocol || "H.248" == AllVoiceProfile[0].SignalingProtocol)
	{
		getElementByName('FramShow').disabled = true;
		
		getElementByName('SpecDMEnable').disabled = true;
		getElementByName('SpecDM').disabled = true;
		getElementByName('LineId').disabled = true;
		getElementByName('PbxPreFixEnable').disabled = true;
		getElementByName('PbxPreFix').disabled = true;
		
		getElementByName('Apply').disabled = true;
		getElementByName('Cancle').disabled = true;
	}
	initDisplay();
	
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

}
 
function OnLineIdChange()
{
	var lineindex = getSelectVal("LineId");
		
	if("1" == lineindex)
	{
		setCheck('PbxPreFixEnable',LineCallingFT[0].X_HW_PBXPrefixEnable);
		setText('PbxPreFix',LineCallingFT[0].X_HW_CentrexPrefix);	
	}
	else
	{
		setCheck('PbxPreFixEnable',LineCallingFT[1].X_HW_PBXPrefixEnable);
		setText('PbxPreFix',LineCallingFT[1].X_HW_CentrexPrefix);	
	}
}

</script>

</head>
<body class="mainbody"  onLoad="LoadFrame();">

<div id="FramShow" name="FramShow">
<table  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr >
	<td>
		<form id="ConfigForm">   
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="1">
				<tr>
					<td width="14%" rowspan="2" align="middle" class="head_title">特定数图设置</td>
					<td class="table_right" align="left" >启用:</td>
					<td class="table_right" align="left" colspan="2" ><input type='checkbox' name='SpecDMEnable' id='SpecDMEnable' value='1' /></td>
				</tr>
			
				<tr>
					<td class="table_right" align="left" >特定数图:</td>
					<td class="table_right" align="left" colspan="2" >
					<textarea name="SpecDM" id="SpecDM" cols="65" rows="3"></textarea>
					<span class="gray"> (长度)(0-8000)</span>
					
					</td>
				</tr>
				
				<tr>
					<td width="14%" rowspan="3" align="middle" class="head_title">PBX数图设置</td>
					<td class="table_right" align="left" >用户:</td>
					<td class="table_right" align="left" colspan="2" >
					
						<select name="LineId" id="LineId" style="width: 50px" onchange="OnLineIdChange()">
						<script language="JavaScript" type="text/javascript">
						var k;
						for (k = 1; k < AllLine.length; k++)
						{
						document.write('<option value="' + k + '">' + k + '</option>');
						}
						</script>
						</select>   
					</td>
				</tr>
				
				<tr>
					<td class="table_right" align="left" >启用:</td>
					<td class="table_right" align="left" colspan="2" ><input name='PbxPreFixEnable' type='checkbox' id='PbxPreFixEnable' value='1' /></td>
				</tr>
				
				<tr>
					<td width="13%" class="table_right" align="left" >PBX前缀:</td> 
					<td width="73%" class="table_right" align="left" colspan="2" ><input type="text" name="PbxPreFix" id = "PbxPreFix" style="width: 150px"/>
					<span class="gray">(长度)(0-7) </span></td>
				</tr>
			</table>
		</div>
		</form>
	</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
 <tr class="trTabCfgHead" >
<td width="25%" class="table_submit"></td>
	<td width="75%" class="table_submit" align="right">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<input name="Apply" id="Apply" class="submit" type="button" value="保存/应用" onclick="SubmitApply()"/>
		<input name="Cancle" id="Cancle" class="submit" type="button" value="取消" onClick="SubmitCancle();"/>
	</td>
 </tr>
</table>

</div>
</body>
</html>
