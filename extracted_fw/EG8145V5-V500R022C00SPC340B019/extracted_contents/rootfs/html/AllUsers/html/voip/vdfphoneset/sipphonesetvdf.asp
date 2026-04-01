<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>Phone Settings</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, vdfphoneset);%>"></script>
<style type="text/css">
input.button {
  border-radius: 3px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.6);
  font-size: 16px;
  font-weight: bold;
  padding: 0 20px;
  height: 34px;
  line-height: 34px;
  background-color: #ffffff;
}
input.button.button-apply {
  background-color: #b141ad;
  color: #fff;
}
.h3-content div.table, h3,.h3-content td, .h3-content th {
  padding-left: 0px;
}
.img_btn img{
width:60px;
height:30px;
}
.content-phone-settings .call-settings-table .table-col {
  height: 45px;
}
div.table-col {
  display: table-cell;
  padding-bottom: 3px;
  padding-top: 5px;
}

.h3-content td, .h3-content th {
  padding: 7px;
}
</style>
<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var vagIndex = 0;
var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';

function stProfile(Domain, Enable)
{
    this.Domain = Domain;
    this.Enable = Enable;
}

var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},Enable,stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);

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

function stLine(Domain, CallWaitingEnable, X_HW_CallHoldEnable, X_HW_3WayEnable, CallTransferEnable)
{
    this.Domain = Domain;
    this.CallWaitingEnable = CallWaitingEnable;
	this.X_HW_CallHoldEnable = X_HW_CallHoldEnable;
	this.X_HW_3WayEnable = X_HW_3WayEnable;
    this.CallTransferEnable = CallTransferEnable;
    
}
var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.CallingFeatures,CallWaitingEnable|X_HW_CallHoldEnable|X_HW_3WayEnable|CallTransferEnable,stLine);%>;
var LineList = new Array(new Array(),new Array(),new Array(),new Array());

for (var index = 0; index < AllLine.length-1; index++)
{
    var temp = AllLine[index].Domain.split('.');
    var Vagindex = GetVagIndexByInst(temp[5]);
    LineList[Vagindex].push(AllLine[index]);
}
vagIndex = GetVagIndexByInst(vagLastInst);

function ButtonCancel()
{
	LoadFrame();
}

function SetIdClassAndValue(id, Value)
{
	var x = document.getElementById(id);
	if(Value == 1)
	{
		x.className = "button button-on";
		x.value = 1;
	}
	else
	{
		x.className = "button button-off";
		x.value = 0;
	}
}


var callwait = new Array(new Array(),new Array(),new Array(),new Array());
var callhold = new Array();
var threeparty = new Array();
var calltransfer = new Array();
for (i = 0; i < AllLine.length - 1; i++)
{
    callwait[i] = "callwait" + i;
	callhold[i] = "callhold" + i;
	threeparty[i] = "threeparty" + i;
	calltransfer[i] = "calltransfer" + i;		
}

function ShowPhoneSetinfo()
{
	var phonesethtml = '';
	for(var i = 0; i < AllLine.length - 1; i++)
	{
		var j = i+1;
		phonesethtml +='<div class="h3-content">';
		phonesethtml +='<h3 class="call-settings-title"><span class="language-string" name="PAGE_PHONE_SETTINGS_CALL_SETTINGS">';
	    phonesethtml +=vdfphoneset['vspa_vdfsetline'];
        phonesethtml +='</span> ' + j + '</h3>';
		phonesethtml +='<table>';
		phonesethtml +='<thead>';

		phonesethtml +='<tr>';
		phonesethtml +='<th><span class="table-col table-col1" style="width:180px; float:left; font-weight:bold">';
		phonesethtml +=vdfphoneset['vspa_vdfservice'];
	    phonesethtml +='</span></th>';
        phonesethtml +='<th><span class="table-col table-col2" style="width:80px; float:left; font-weight:bold">';
		phonesethtml +=vdfphoneset['vspa_vdfstatus'];
	    phonesethtml +='</span></th>';
        phonesethtml +='<th><span class="table-col table-col3" style="width: 230px; float:left"></span></th>';
        phonesethtml +='<th><span class="table-col table-col4" style="width: 160px; float:left"></span></th>';
		phonesethtml +='</tr></thead>';
		
		phonesethtml +='<tbody>';
		phonesethtml +='<tr class="table-row">';
		phonesethtml +='<td><span class="table-col table-col1" style="width:180px; float:left">';
		phonesethtml +=vdfphoneset['vspa_vdcw'];
		phonesethtml +='</span></td>';
		phonesethtml +='<td><span class="table-col table-col2 img_btn" style="width:80px; float:left"><img id="'+ callwait[i] +'" onclick="changeImg(this)" /></span></td>';
		phonesethtml +='<td><span class="table-col table-col3" style="width:230px; float:left"></span></td>';
		phonesethtml +='<td><span class="table-col table-col4" style="width:160px; float:left"></span></td>';
		phonesethtml +='</tr>';
		
		phonesethtml +='<tr class="table-row">';
		phonesethtml +='<td><span class="table-col table-col1" style="width:180px; float:left">';
		phonesethtml +=vdfphoneset['vspa_vdfcallhold'];
		phonesethtml +='</span></td>';
		phonesethtml +='<td><span class="table-col table-col2 img_btn" style="width:80px; float:left"><img id="'+ callhold[i] +'" onclick="changeImg(this)" /></span></td>';
		phonesethtml +='<td><span class="table-col table-col3" style="width:230px; float:left"></span></td>';
		phonesethtml +='<td><span class="table-col table-col4" style="width:160px; float:left"></span></td>';
		phonesethtml +='</tr>';

		phonesethtml +='<tr class="table-row">';
		phonesethtml +='<td><span class="table-col table-col1" style="width:180px; float:left">';
		phonesethtml +=vdfphoneset['vspa_vdf3pty'];
		phonesethtml +='</span></td>';
		phonesethtml +='<td><span class="table-col table-col2 img_btn" style="width:80px; float:left"><img id="'+ threeparty[i] +'" onclick="changeImg(this)" /></span></td>';
		phonesethtml +='<td><span class="table-col table-col3" style="width:230px; float:left"></span></td>';
		phonesethtml +='<td><span class="table-col table-col4" style="width:160px; float:left"></span></td>';
		phonesethtml +='</tr>';
	
		phonesethtml +='<tr class="table-row">';
		phonesethtml +='<td><span class="table-col table-col1" style="width:180px; float:left">';
		phonesethtml +=vdfphoneset['vspa_vdfcalltransfer']; 
		phonesethtml +='</span></td>';
		phonesethtml +='<td><span class="table-col table-col2 img_btn" style="width:80px; float:left"><img id="'+ calltransfer[i] +'" onclick="changeImg(this)" /></span></td>';
		phonesethtml +='<td><span class="table-col table-col3" style="width:230px; float:left"></span></td>';
		phonesethtml +='<td><span class="table-col table-col4" style="width:160px; float:left"></span></td>';
		phonesethtml +='</tr>';
		phonesethtml +='</tbody>';
		phonesethtml +='</table>';
	
		phonesethtml +='</div>';
	}
	return phonesethtml;
}

function LoadFrame()       
{
	for(var i = 0; i < AllLine.length - 1; i++)     
	{	
		SetImgValue(callwait[i], AllLine[i].CallWaitingEnable);
		SetImgValue(callhold[i], AllLine[i].X_HW_CallHoldEnable);
		SetImgValue(threeparty[i], AllLine[i].X_HW_3WayEnable);
		SetImgValue(calltransfer[i], AllLine[i].CallTransferEnable);
	}
	if(AllLine.length - 1 >= 1)   
	{
		setDisplay('PhoneSetApplyCancel', 1);
	}
} 

function CheckForm(type)                      
{
    return true;
}

function AddSubmitParam(Form,type)
{ 	
	var domain = "";
	var add = "";
	var des = "";
	var x = "";
	domain ='x=' + AllProfile[vagIndex].Domain;
	for(var count = 0; count < AllLine.length - 1; count ++)
	{
		des = "";
		add = 'Add' + count;
		des = add +'.CallWaitingEnable';
		x = document.getElementById(callwait[count]);
		Form.addParameter(des, x.value);
		
		des = add +'.X_HW_CallHoldEnable';
		x = document.getElementById(callhold[count]);
		Form.addParameter(des, x.value);

		des = add +'.X_HW_3WayEnable';
		x = document.getElementById(threeparty[count]);
		Form.addParameter(des, x.value);
		
		des = add +'.CallTransferEnable';
		x = document.getElementById(calltransfer[count]);
		Form.addParameter(des, x.value);
	
		domain += '&' + add +'=' + LineList[vagIndex][count].Domain;
	}

	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('set.cgi?' + domain + '&RequestFile=html/voip/vdfphoneset/sipphonesetvdf.asp');
    setDisable('SaveApply_button',1);  
    setDisable('Cancel_button',1);     
}

function SetImgValue(Buttonid, ButtonValue)
{
	var Btnelement = document.getElementById(Buttonid);
	if(null == Btnelement)
	{
		return;
	}

	if(1 == ButtonValue)
	{
		Btnelement.src="../../../images/checkon.gif";
		Btnelement.value = 1;
	}
	else
	{
		Btnelement.src="../../../images/checkoff.gif";
		Btnelement.value = 0;
	}	
}
function changeImg(element)
{
	if (element.src.match("checkon"))
	{
		element.src="../../../images/checkoff.gif";
		element.value = 0;
	}
	else
	{
		element.src="../../../images/checkon.gif";
		element.value = 1;
	}
}
</script>
</head>

<body class="mainbody" onLoad="LoadFrame();"> 
<div class="white-background">
 <div id="content" class="content-phone-settings">
  <h1>
    <span class="language-string" name="PAGE_PHONE_SETTINGS_TITLE"></span>
	  <script>
		document.write(vdfphoneset['vspa_vdfphonesetting']);
	  </script>
	</h1>
  <h2>
    <span class="language-string" name="PAGE_PHONE_SETTINGS_SUBTITLE">
	  <script language="JavaScript" type="text/javascript">
	    document.write(vdfphoneset['vspa_vdfsetwarn']);
	  </script>
	</span></h2>
	<div>
	<script>
		var html = '';
		html += ShowPhoneSetinfo();
		document.write(html);
	</script>
  </div>

<div id="PhoneSetApplyCancel" class="clearfix apply-cancel" style="display:none">
  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
     <input name="Cancel_button" id="Cancel_button" type="button" class="button button-cancel" value="Cancel" onClick="ButtonCancel();"/> 
          <script type="text/javascript">
			document.getElementsByName('Cancel_button')[0].value = vdfphoneset['vspa_vdfsetcancel']; 			
          </script> 
  <input name="SaveApply_button" id="SaveApply_button" type="button" class="button button-apply" value="Apply" onClick="Submit();"/> 
          <script type="text/javascript">
			document.getElementsByName('SaveApply_button')[0].value = vdfphoneset['vspa_vdfsetapply'];  
          </script> 
</div>
</div>
</div>

</body>
</html>
