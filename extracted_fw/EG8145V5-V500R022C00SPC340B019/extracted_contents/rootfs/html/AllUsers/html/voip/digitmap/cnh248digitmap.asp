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
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248user, h248interface);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">

var vagIndex = 0;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';
var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";

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

function stProfile(Domain, X_HW_DigitMapMatchMode)
{
    this.Domain = Domain;
    this.X_HW_DigitMapMatchMode = X_HW_DigitMapMatchMode;
    
}
var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1,X_HW_DigitMapMatchMode,stProfile);%>;
var Profile = new Array();
for (var i = 0; i < AllProfile.length-1; i++)
    Profile[i] = AllProfile[i];
	
	

var varDmAutoEnable = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Extend.DigitMapAutoMatchEnable);%>;
	
function stH248DigitMap(domain, DigitMapStartTimer, DigitMapShortTimer, DigitMapLongTimer)
{
    this.Domain = domain;
    this.DigitMapStartTimer = DigitMapStartTimer;
    this.DigitMapShortTimer = DigitMapShortTimer;
	this.DigitMapLongTimer = DigitMapLongTimer;
}
var H248DigitMapParas = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Digitmap,DigitMapStartTimer|DigitMapShortTimer|DigitMapLongTimer,stH248DigitMap);%>;


var H248DigitMapPara = H248DigitMapParas[0];

function AddSubmitParam(Form,type)
{    
    var domain;
    Form.addParameter('x.X_HW_DigitMapMatchMode',getValue('X_HW_DigitMapMatchMode'));
    Form.addParameter('t.DigitMapAutoMatchEnable',getCheckVal('DmAutoEnable')); 
	Form.addParameter('c.DigitMapStartTimer',getValue('StartDigitTimer_text'));
    Form.addParameter('c.DigitMapShortTimer',getValue('ShortTimerValue_text'));
    Form.addParameter('c.DigitMapLongTimer',getValue('LongTimerValue_text'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
    domain ='c=' + H248DigitMapPara.Domain
	       +'&x=' + Profile[0].Domain
		   + '&t=' + Profile[0].Domain + '.X_HW_H248' + '.Extend';
               
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
    var DigitMapStartTimer = getValue('StartDigitTimer_text');
    var DigitMapShortTimer = getValue('ShortTimerValue_text');
    var DigitMapLongTimer = getValue('LongTimerValue_text');
      
    if(parseInt(DigitMapStartTimer) < 0 || parseInt(DigitMapStartTimer) > 900)
    	{
        	AlertEx(h248user['vspa_starttimerinva']);
        	return false;
    	}
		
	    if(parseInt(DigitMapShortTimer) < 0 || parseInt(DigitMapShortTimer) > 900)
    	{
        	AlertEx(h248user['vspa_shorttimerinva']);
        	return false;
    	}
		
	    if(parseInt(DigitMapLongTimer) < 0 || parseInt(DigitMapLongTimer) > 900)
    	{
        	AlertEx(h248user['vspa_longtimerinva']);
        	return false;
    	}

    return true;
}
function DigmapCancel()
{
	LoadFrame();
}

function LoadFrame()
{
    var objTR = getElementByName('vag_tr');
    if(objTR!= null)
    {
        for(var i = 0; i < objTR.length; i++)
        {
            objTR[i].value = h248interface['vspa_profile'] + Profile[i].profileid;
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
    
    setText('StartDigitTimer_text', H248DigitMapPara.DigitMapStartTimer);
	setText('ShortTimerValue_text', H248DigitMapPara.DigitMapShortTimer);
	setText('LongTimerValue_text', H248DigitMapPara.DigitMapLongTimer);
	setSelect('X_HW_DigitMapMatchMode', Profile[0].X_HW_DigitMapMatchMode);
	setCheck('DmAutoEnable', varDmAutoEnable);
	
	
	
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

<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
   <tr>
        <td width="18%" class="table_title width_20p" BindText='vspa_startdigitimer'></td>
        <td width="82%" class="table_right" colspan="10" >
             <input type="text" id="StartDigitTimer_text" class="wid_125px"/>
			 <span class="gray"><script>document.write(h248user['vspa_uints']);</script></span>
     </td>
  </tr>
	
    <tr>
        <td class="table_title width_20p" BindText='vspa_longdigitimer'>
        </td>
        <td width="82%" class="table_right" colspan="10" >
             <input type="text" id="LongTimerValue_text" class="wid_125px"/>
			 <span class="gray"><script>document.write(h248user['vspa_uints']);</script></span>
      </td>
    </tr>
    <tr>
        <td class="table_title width_20p" BindText='vspa_shortdigitimer'>
        </td>
        <td width="82%" class="table_right" colspan="10" >
             <input type="text" id="ShortTimerValue_text" class="wid_125px"/>
			 <span class="gray"><script>document.write(h248user['vspa_uints']);</script></span>
      </td>
    </tr>
	<tr>
        <td class="table_title width_20p">数图匹配模式：</td>
        <td width="82%" class="table_right" colspan="10" >
             <select name="X_HW_DigitMapMatchMode" id="X_HW_DigitMapMatchMode" size="1">
				   <option value="Min">最短匹配</option>
				   <option value="Max">最长匹配</option>
		  </select>			
      </td>
    </tr>
	
	<tr>
        <td class="table_title width_25p">数图自适应匹配使能：</td>
        <td width="82%" class="table_right" colspan="10" >
        <input name="DmAutoEnable" id="DmAutoEnable" type='checkbox' size="18" checked="checked" />		
      </td>
    </tr>


 </table>
 
 
 
 
 
 
 
 
 <table width="100%" border="0" cellspacing="1" cellpadding="0" class="">
    <tr >
        <td class=" width_20p"></td>
        <td width="80%" class="" colspan="10"  align="right">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply" onClick="Submit();"/> 
          <script type="text/javascript">
            document.getElementsByName('SaveApply_button')[0].value = h248user['e8cvspa_apply'];    
          </script>
        <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel" onClick="DigmapCancel();"/> 
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
