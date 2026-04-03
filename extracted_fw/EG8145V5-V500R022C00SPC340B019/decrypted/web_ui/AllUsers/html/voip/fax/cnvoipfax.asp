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

function stProfile(Domain, HW_DtmfMethod, HW_ServerType)
{
    this.Domain = Domain;
    this.HW_DtmfMethod = HW_DtmfMethod;
    this.HW_ServerType = HW_ServerType;
    var temp = Domain.split('.');
    this.profileid = temp[5];
}

var Profile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},DTMFMethod|X_HW_ServerType,stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);

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

function setVagInfo()
{
    if(Profile[0] == null)
    {
        return;
    }
    
    setSelect('FaxMode_select', VoiceTransmode[vagIndex].FaxT38_Enable);
    setSelect('T30NegotiateMode_select', VoiceTransswitch[vagIndex].X_HW_FaxModem_FaxNego);    
    
}

function FaxCancel()
{
	LoadFrame();
}

function LoadFrame()
{
    var FaxT38_Enable=document.getElementById('FaxMode_select');
    var X_HW_FaxModem_FaxNego=document.getElementById('T30NegotiateMode_select');

    var objTR = getElementByName('vag_tr');
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
	}
    
}

function CheckForm1()
{ 
    var FaxT38_Enable=document.getElementById('FaxMode_select');
    var X_HW_FaxModem_FaxNego=document.getElementById('T30NegotiateMode_select');
 
    if (FaxT38_Enable.value > 2)
    {
        return false;
    }

    if (X_HW_FaxModem_FaxNego.value > 2)
    {
        return false;
    }

    return true;
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


function AddSubmitParam(Form,type)
{  
    var domain;
    
    if(Profile[0] == null)
    {
        return false;
    }
    
    Form.addParameter('x.Enable',getValue('FaxMode_select'));
    Form.addParameter('y.FaxNego',getValue('T30NegotiateMode_select'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));    
    
    domain ='x=' + Profile[vagIndex].Domain + '.FaxT38'
         + '&y=' + Profile[vagIndex].Domain + '.X_HW_FaxModem';

    Form.setAction('set.cgi?' + domain + '&RequestFile=html/voip/fax/cnvoipfax.asp');
    setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
}

</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<table width="100%" border="0" cellpadding="0" cellspacing="1">
	<tr>
        <td class="width_per25 table_title" BindText='vspa_faxtran'></td>
        <td width="width_per75" class="table_right" colspan="10" > 
            <select name="FaxMode_select" id="FaxMode_select" size="1" class="width_150px"/>
            <option value="1">T.38传真</option>
			<option value="0" selected="selected">T.30传真</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="width_per25 table_title">T.30传真协商方式：</td>
        <td width="width_per75" class="table_right" colspan="10" >     
            <select name="T30NegotiateMode_select" id="T30NegotiateMode_select" size="1" class="width_150px"/>
			<option value="1" selected="selected">全控</option>
            <option value="0">自协商</option>
            </select>
        </td>
    </tr>
    
	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="">
    <tr >
        <td width="28%" class=" width_per25"></td>
        <td width="72%" class="" colspan="10" align="right">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply" onClick="Submit();"/> 
          <script type="text/javascript">
            document.getElementsByName('SaveApply_button')[0].value = sipuser['e8cvspa_apply'];    
          </script>
        <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel" onClick="FaxCancel();"/> 
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
