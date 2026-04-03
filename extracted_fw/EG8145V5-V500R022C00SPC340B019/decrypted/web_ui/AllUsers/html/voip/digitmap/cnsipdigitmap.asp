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
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipuser, sipinterface);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">

var vagIndex = 0;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';
var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
function GetVagIndexByInst(vagInst)
{
    for(var i = 0; i < AllProfile.length-1; i++)
    {
        if(AllProfile[i].profileid == vagInst)
        {
            return i;
        }
    }
    
    return 0;
}

function stProfile(Domain, X_HW_DigitMapMatchMode, DigitMapEnable)
{
    this.Domain = Domain;
    this.X_HW_DigitMapMatchMode = X_HW_DigitMapMatchMode;
    this.DigitMapEnable = DigitMapEnable;
}

function stDigitMap(Domain, DigitMap)
{
    this.Domain = Domain;
    this.DigitMap = DigitMap;
}
var SipDigitMap = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPDigitmap.1,DigitMap,stDigitMap);%>;

var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},X_HW_DigitMapMatchMode|DigitMapEnable,stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);

for (var i = 0; i < AllProfile.length-1; i++)
{
    AllProfile[i].DigitMap = SipDigitMap[i].DigitMap;
}

function stSipDigitMap(domain, DigitMapStartTimer, DigitMapShortTimer, DigitMapLongTimer)
{
    this.Domain = domain;
    this.DigitMapStartTimer = DigitMapStartTimer;
    this.DigitMapShortTimer = DigitMapShortTimer;
    this.DigitMapLongTimer = DigitMapLongTimer;
}
var SipDigitMapPara = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPDigitmap.1,DigitMapStartTimer|DigitMapShortTimer|DigitMapLongTimer,stSipDigitMap);%>;


function stSIPServer(Domain,X_HW_TWaitTimeMode, X_HW_OutNumberContainImmediateDialKeyEnable)
{
	this.Domain = Domain;
	this.X_HW_TWaitTimeMode = X_HW_TWaitTimeMode;
	this.X_HW_OutNumberContainImmediateDialKeyEnable = X_HW_OutNumberContainImmediateDialKeyEnable;
}
var AllSIPServer = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP,X_HW_TWaitTimeMode|X_HW_OutNumberContainImmediateDialKeyEnable,stSIPServer);%>;

function setVagInfo()
{
    if(AllProfile[0] == null)
    {
        return;
    }
    setText('StartTimerValue_text', SipDigitMapPara[vagIndex].DigitMapStartTimer);
    setText('ShortTimerValue_text', SipDigitMapPara[vagIndex].DigitMapShortTimer);
    setText('LongTimerValue_text', SipDigitMapPara[vagIndex].DigitMapLongTimer);
	setSelect('TWaitTime_select', AllSIPServer[vagIndex].X_HW_TWaitTimeMode);
	setSelect('OutNumberContainImmediateDialKey_select', AllSIPServer[vagIndex].X_HW_OutNumberContainImmediateDialKeyEnable);	
}

function AddSubmitParam(Form,type)
{    
    var domain;
    
    if(AllProfile[0] == null)
    {
        return false;
    }

    Form.addParameter('c.DigitMapStartTimer',getValue('StartTimerValue_text'));
    Form.addParameter('c.DigitMapShortTimer',getValue('ShortTimerValue_text'));
    Form.addParameter('c.DigitMapLongTimer',getValue('LongTimerValue_text'));
	Form.addParameter('z.DigitMap',getValue('DigitMap_textarea'));
    Form.addParameter('x.X_HW_DigitMapMatchMode',getSelectVal("DigitMapMode_select"));
	Form.addParameter('x.DigitMapEnable',getCheckVal('DigitMapEnable_checkbox'));
	Form.addParameter('w.X_HW_TWaitTimeMode',getSelectVal('TWaitTime_select'));
	Form.addParameter('w.X_HW_OutNumberContainImmediateDialKeyEnable',getSelectVal('OutNumberContainImmediateDialKey_select'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	
    domain ='c=' + SipDigitMapPara[vagIndex].Domain
          	     + '&x=' + AllProfile[vagIndex].Domain
				 + '&w=' + AllProfile[vagIndex].Domain + '.SIP'
                 + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1';

    Form.setAction('set.cgi?' + domain + '&RequestFile=html/voip/digitmap/cndigitmap.asp');
    setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
}

function CheckForm(type)
{
    var ulret = CheckForm1();    
    if (ulret != true )
    {
        return false;
    }
    
    return true;
}

function CheckForm1()
{
    var starttimer = getValue('StartTimerValue_text');
    var shorttimer = getValue('ShortTimerValue_text');
    var longtimer = getValue('LongTimerValue_text');

    if(parseInt(starttimer) < 0 || parseInt(starttimer) > 900)
    {
        AlertEx(sipuser['vspa_starttimerinva']);
        return false;
    }

    if(parseInt(shorttimer) < 0 || parseInt(shorttimer) > 900)
    {
        AlertEx(sipuser['vspa_shorttimerinva']);
        return false;
    }
        
    if(parseInt(longtimer) < 0 || parseInt(longtimer) > 900)
    {
        AlertEx(sipuser['vspa_longtimerinva']);
        return false;
    }
	 
	if (getValue('DigitMap_textarea').length > 8000)
    {
        AlertEx(sipinterface['vspa_digmaplength']);
        return false;
    }
	
	if (isSafeStringIn(getValue('DigitMap_textarea'), 'ABCDEFXabcdefxT0123456789-{}[]()*#,.Tt|LlSsZz') == false)
    {
        AlertEx(sipinterface['vspa_digmapvalid']);
        return false;
    }

    return true;
}

var dmm = sipinterface['vspa_dmmhint'];

function DigitmapCancel()
{
	LoadFrame();
}


function LoadFrame()
{
    var objTR = getElementByName('vag_tr');
	var startTimerShow = document.getElementById("start_timer");
	var tableRightShow = document.getElementById("right_table");
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
    
	document.getElementById('digitmap1').title = dmm;
	
	setText('DigitMap_textarea',AllProfile[vagIndex].DigitMap);
	setSelect("DigitMapMode_select", AllProfile[vagIndex].X_HW_DigitMapMatchMode);
	setCheck('DigitMapEnable_checkbox', AllProfile[vagIndex].DigitMapEnable);
	
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }
        b.innerHTML = sipinterface[b.getAttribute("BindText")];
    }

    setVagInfo();
	
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
	if (CfgMode.toUpperCase() == 'SCCT_FTTO') {
        setDisable('DigitMapEnable_checkbox',1);
        setDisable('DigitMap_textarea',1);
    }

    if (CfgMode.toUpperCase() == 'SCCT') {
        setDisable('DigitMapEnable_checkbox',0);
        setDisable('DigitMap_textarea',1);
    }

	if (CfgMode.toUpperCase() != 'JXCT' && CfgMode.toUpperCase() != 'ZJCT') {
		startTimerShow.style.display = 'none';
		tableRightShow.style.display = 'none';
	}
}






</script>
</head>
<body class="mainbody" onload="LoadFrame();">

<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
	<tr> 
        <td class="width_per25 table_title" BindText='vspa_digenable'></td>   
        <td width="75%" class="table_right" colspan="10"> 
        <input name='DigitMapEnable_checkbox' type='checkbox' id='DigitMapEnable_checkbox' value='0' />
        </td>
    </tr>
	
	<tr>
		<td class="table_title align_left width_per25">拨号计划规则：</td>
		<td width="75%" class="table_right" colspan="10" id="digitmap1">
		<textarea name="DigitMap_textarea" id="DigitMap_textarea" cols="65" rows="3"></textarea>
		</td>
    </tr>

    <tr>
		<td class="table_title align_left width_per25">匹配方式：</td>
		<td width="75%" class="table_right" colspan="10" >
		<select name="DigitMapMode_select" id="DigitMapMode_select">
		   <option value="Min">最短匹配</option>
		   <option value="Max">最长匹配</option>
		</select>
		</td>
   </tr>
   
       <tr>
		<td class="table_title align_left width_per25" BindText='vspa_Twaittime'></td>
		<td width="75%" class="table_right" colspan="10" >
		<select name="TWaitTime_select" id="TWaitTime_select">
		   <option value="0"><script>document.write(sipinterface['vspa_shortT']);</script></option>
		   <option value="1"><script>document.write(sipinterface['vspa_longT']);</script></option>
		</select>
		</td>
        </tr>

   		<tr>
		<td class="table_title align_left width_per25" BindText='vspa_outnumcontain'></td>
		<td width="75%" class="table_right" colspan="10" >
		<select name="OutNumberContainImmediateDialKey_select" id="OutNumberContainImmediateDialKey_select">
		   <option value="1">是</option>
		   <option value="0">否</option>
		</select>
		</td>
        </tr>
   
   <tr>
        <td class="table_title width_per25" id="start_timer">摘机不拨号：</td>
        <td width="75%" class="table_right" colspan="10" id="right_table" >
            <input type="text" id="StartTimerValue_text" class="wid_125px"/>
            <span class="gray"><script>document.write(sipinterface['vspa_uints']);</script></span>
        </td>
   </tr>

   <tr>
        <td class="table_title width_per25">短定时器：</td>
        <td width="75%" class="table_right" colspan="10" >
             <input type="text" id="ShortTimerValue_text" class="wid_125px"/>
			 <span class="gray"><script>document.write(sipinterface['vspa_uints']);</script></span>
        </td>
    </tr>
	
    <tr>
        <td class="table_title width_per25">长定时器：</td>
        <td width="75%" class="table_right" colspan="10" >
             <input type="text" id="LongTimerValue_text" class="wid_125px"/>
			 <span class="gray"><script>document.write(sipinterface['vspa_uints']);</script></span>
        </td>
    </tr></table>
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="">
    <tr >
        <td class=" width_per25"></td>
        <td width="75%" class="" colspan="10" align="right">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply" onClick="Submit();"/> 
          <script type="text/javascript">
            document.getElementsByName('SaveApply_button')[0].value = sipuser['e8cvspa_apply'];    
          </script>
        <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel" onClick="DigitmapCancel();"/> 
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
