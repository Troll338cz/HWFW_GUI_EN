<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<style>
.uriclass
{ 
	word-break:break-all;
	min-width:30px;
}

.regnameclass
{ 
	word-break:break-all;
	width:110px;
}



</style>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>Vdf Voip Status</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, vdfvoipstatus);%>"></script>
<script language="JavaScript" type="text/javascript">

function stLine(Domain, PhyReferenceList, DirectoryNumber, X_HW_Description, Status)
{
    this.Domain = Domain;
    this.PhyReferenceList = PhyReferenceList;
	this.DirectoryNumber = DirectoryNumber;
	this.X_HW_Description = X_HW_Description;
    this.Status = Status;
    
}
function stLineURI(Domain, URI)
{
	this.Domain = Domain;
    this.URI = URI;

}
function stAuth(Domain, AuthUserName)
{
    this.Domain = Domain;
    this.AuthUserName = AuthUserName;
    
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName,stAuth);%>;
var AllLineURI = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,URI,stLineURI);%>;
var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},PhyReferenceList|DirectoryNumber|X_HW_Description|Status,stLine);%>;
function GetPhoneNumber(inputstring)
{
	var number;
	if( inputstring.indexOf(":") >= 0) 
	{
		var URIpart = inputstring.split(':');
		var k1 = URIpart[1];
		var k2 = k1.split('@');
		var k3 = k2[0];
		if (k3 == "")
		{ 
			number = "--";
		}
		else
		{ 
			number = k3;
		}
	}
	else
	{
		var URIpart = inputstring.split('@');
		var k = URIpart[0];
		if (k == "")
		{ 
			number = "--";
		}
		else
		{ 
			number = k; 
		}
	}
	return number;
}

</script>
</head>



<body class="mainbody">

<div id="content" style="background-color:#fff">
<h1>
  <span class="language-string" name="PAGE_VOICE_STATUS_TITLE"><script>document.write(vdfvoipstatus['vspa_itvdf_status_title']);</script></span>
  </h1>
  	<h2>
  <span class="language-string" name="PAGE_VOICE_STATUS_SUBTITLE" style="font-family:Arial,sans-serif;"><script>document.write(vdfvoipstatus['vspa_itvdf_voice_view']);</script></span>
  	</h2>
  	<h3>
    <span class="language-string" name="PAGE_VOICE_STATUS_YOUR_PHONE_NUMBERS"><script>document.write(vdfvoipstatus['vspa_itvdf_status_your_number']);</script></span>  
    </h3>

<div class="h3-content">
	<div class="table voice-status">
      
      <script>
      		var html ='';
			html += '<table>';
			html += '<tr style="border-bottom: 1px solid #e6e6e6;">';
			html += '<td>';
			html += '<span style="float:left;width:30px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;padding-right: 15px;font-family:Arial,sans-serif;">';
			html += vdfvoipstatus['vspa_itvdf_seq'];
			html += '</span>';
			html += '</td>';
			html += '<td>';
			html += '<span style="float:left;width:110px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;padding-right: 15px;font-family:Arial,sans-serif;">';
			html += vdfvoipstatus['vspa_itvdf_connect'];
			html += '</span>';
			html += '</td>';
			html += '<td>';
			html += '<span style="float:left;width:160px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;padding-right: 15px;font-family:Arial,sans-serif;">';
			html += vdfvoipstatus['vspa_itvdf_phone_num'];
			html += '</span>';
			html += '</td>';
			html += '<td>';
			html += '<span style="float:left;width:171px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;padding-right: 15px;font-family:Arial,sans-serif;">';
			html += vdfvoipstatus['vspa_itvdf_name'];
			html += '</span>';
			html += '</td>';
			html += '<td>';
			html += '<span style="float:left;width:119px;word-wrap:break-word;word-break: break-all;padding-right: 15px;font-family:Arial,sans-serif;">';
			html += vdfvoipstatus['vspa_itvdf_status'];
			html += '</span>';
			html += '</td>';
			html += '</tr>';
      		for(var j = 0; j < AllLine.length - 1; j++)
      		{
				if(AllLineURI[j].URI != "")
				{
					vdfPhoneNumber = GetPhoneNumber(AllLineURI[j].URI);	
				}
				else if(AllLine[j].DirectoryNumber != "")
				{
					vdfPhoneNumber = GetPhoneNumber(AllLine[j].DirectoryNumber);
				}
				else if(AllAuth[j].AuthUserName != "")
				{
					vdfPhoneNumber = GetPhoneNumber(AllAuth[j].AuthUserName);
				}
				else
				{
					vdfPhoneNumber = "--";
				}
				html += '<tr>';
				html += '<td>';
      			html += '<span class="table-col hash_width table-col1" style="float:left;width:30px;padding-right: 15px;font-family:Arial,sans-serif;">';
      			html += (j + 1);
      			html += '</span>';
				html += '</td>';
      			
      			html += '<td>';
      			html += '	<span class="language-string" style="float:left;width:100px;word-wrap:break-word;word-break: break-all;padding-right: 15px;font-family:Arial,sans-serif;">';
      			html += vdfvoipstatus['vspa_itvdf_tel'] + htmlencode(AllLine[j].PhyReferenceList);
      			html += '	</span>';
      			html += '</td>';
      			
      			html += '<td>';
      			html += '	<span class="language-string" style="float:left;width:160px;word-wrap:break-word;word-break: break-all;padding-right: 15px;font-family:Arial,sans-serif;">';
      			html += htmlencode(vdfPhoneNumber);
				html += '	</span>';
      			html += '</td>';
      			
      			html += '<td>';
				html += '<span class="language-string"  style="float:left;width:161px;word-wrap:break-word;word-break: break-all;padding-right: 15px;font-family:Arial,sans-serif;">';
				if(AllLine[j].X_HW_Description == "")
				{
					html += "--";
				}
				else
				{
					html += htmlencode(AllLine[j].X_HW_Description);
				}
				html += '	</span>';
      			html += '</td>';
      			
      			html += '<td>';
      			html += '	<span class="language-string"  style="float:left;width:119px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';
      			
				if ( AllLine[j].Status == 'Up' )
				{
					html += vdfvoipstatus['vspa_state_up'];
				}
				else if ( AllLine[j].Status == 'Initializing' )
				{    
					html += vdfvoipstatus['vspa_state_ini'];
				}
				else if ( AllLine[j].Status == 'Registering' )
				{    
					html += vdfvoipstatus['vspa_state_reg'];
				}
				else if ( AllLine[j].Status == 'Unregistering' )
				{  
					html += vdfvoipstatus['vspa_state_unreg'];
				}
				else if ( AllLine[j].Status == 'Quiescent' )
				{    
					html += vdfvoipstatus['vspa_state_quies'];
				}
				else if ( AllLine[j].Status == 'Disabled' )
				{
					html += vdfvoipstatus['vspa_state_disable'];    
				}
				else if ( AllLine[j].Status == 'Error' )
				{
					html += vdfvoipstatus['vspa_state_err'];    
				}
				else if ( AllLine[j].Status == 'Testing' )
				{
					html += vdfvoipstatus['vspa_state_test'];    
				}
				else
				{
					html += "--";  
				}
      			html += '	</span>';
      			html += '</td>';
      			html += '</tr>';
      		}
			html += '</table>';
      		document.write(html);
	</script>
	</div>
</div>
</body>
</html>
