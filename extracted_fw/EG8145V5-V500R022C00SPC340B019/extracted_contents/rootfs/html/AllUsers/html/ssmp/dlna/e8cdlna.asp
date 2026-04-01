<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
<link rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" type="text/css" media="screen" />
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<style type="text/css">
.trTabContent td
{
	font-family:Arial;
	font-size:12px;
	border:1px solid  #dcdcdc;
	text-align:center;
}
.trTabContent
{
	background-color:#f4f4f4;
	color:#000000;
	height: 20px;
	padding: 1px;
}
</style>
<script language="JavaScript"type="text/javascript">
try 
{ 
	document.execCommand('BackgroundImageCache', false, true); 
} 
catch(e) 
{}
</script>

<script language="JavaScript" type="text/javascript">
function stDlnaService(domain,Enable,ShareAllPath)
{
	this.domain 	= domain;
	this.Enable = Enable;
	this.ShareAllPath = ShareAllPath;
}

function stdlnaDirectory(domain,Active,ContentDirectory,ContentDirectoryUTF)
{
	this.domain = domain; 
	this.Active = Active; 
	this.ContentDirectory = ContentDirectory;
	this.ContentDirectoryUTF = ContentDirectoryUTF;
}

var dlnaServices = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_DmsService,Enable|ShareAllPath,stDlnaService);%>;
var dlnaService = dlnaServices[0];

var dlnaDirectorys =<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_DmsService.Directory.{i},Active|ContentDirectory|ContentDirectoryUTF,stdlnaDirectory);%>;
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
function loadlanguage()
{
	
	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length; i++)
	{
		var b = all[i];
		var c = b.getAttribute("BindText");
		if(c == null)
		{
			continue;
		}
		b.innerHTML = DlnaLgeDes[c];
	}
	
	var all = document.getElementsByTagName("input");
	for (var i = 0; i < all.length; i++)
	{
		var b = all[i];
		var c = b.getAttribute("BindText");
		if(c == null)
		{
			continue;
		}
		b.value = DlnaLgeDes[c];
	}
	
}

function radioChooseDirOption()
{
	var radioIndex = getRadioVal('idRadioDirectory');

	if('1' == radioIndex)
	{		
		setDisplay('ConfigDlna',0);	
	}
	else
	{
		setDisplay('ConfigDlna',1);	
	}
	
	setDisplay('tablesubmit', 1);	
	 	
}

function LoadFrame()
{ 
  setRadio('idRadioDirectory', parseInt(dlnaService.ShareAllPath));
  setCheck('dlnaEnable',dlnaService.Enable);
  
	if('CMCC_RMS' == CfgMode.toUpperCase())
	{
		setDisable('dlnaEnable', 1);
	}
  
  if (dlnaDirectorys.length -1 == 0)
	{
		selectLine('record_no');
		setDisplay('ConfigDlna', 0);
	}
	else
	{
	  selectLine('record_0');
	  setDisplay('ConfigDlna', 1);
	}
	
  radioChooseDirOption();
	loadlanguage();
}

function CheckForm()
{	
	var UrlPath = getValue('UrlUtf')
	if (UrlPath == '')
	{
		AlertEx(DlnaLgeDes['s1607']);
		return false;
	}
	
	for(var i = 0; i < dlnaDirectorys.length-1; i++)
	{
		if(selctIndex == i)
		{
			continue;
		}
		if(UrlPath == dlnaDirectorys[i].ContentDirectory)
		{
			AlertEx(DlnaLgeDes['s1608']);
			return false;
		}	    
	}
	return true;
}
   
function SubmitForm()
{   
	var Form = new webSubmitForm();
	
	var UrlUtfPath= getValue('UrlUtf');
	
	if (UrlUtfPath.length > 503) 
	{
		AlertEx(DlnaLgeDes['s1610']);
		return false;
	}
	
	Form.addParameter('x.Enable',getCheckVal('dlnaEnable'));
	Form.addParameter('x.ShareAllPath',getRadioVal('idRadioDirectory'));
	Form.addParameter('Add_y.ContentDirectory',UrlUtfPath);         

	if( 1 == getRadioVal('idRadioDirectory'))
	{
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('set.cgi?x=InternetGatewayDevice.Services.X_HW_DmsService&RequestFile=html/ssmp/dlna/e8cdlna.asp');
	}
	else
	{
		var ulret = CheckForm();	
		if (ulret != true )
		{
			return false;
		}
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		if( -1 == selctIndex || -2 == selctIndex)
		{
			                 
			Form.setAction('complex.cgi?x=' + 'InternetGatewayDevice.Services.X_HW_DmsService'
												+ '&Add_y=' + 'InternetGatewayDevice.Services.X_HW_DmsService.Directory'
												+ '&RequestFile=html/ssmp/dlna/e8cdlna.asp');
		}
		else 
		{  
			Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.X_HW_DmsService'
												+ '&Add_y=' + dlnaDirectorys[selctIndex].domain
												+ '&RequestFile=html/ssmp/dlna/e8cdlna.asp');
		}
			
	}

	setDisable('btnApplydlna', 1);
	setDisable('cancelValue', 1);
	Form.submit();   
}

function DlnaWriteTabTail()
{
    document.write("<\/td><\/tr><\/table>");
}

function CancelConfig()
{
    LoadFrame();
}


var selctIndex = -1;

function setControl(index)
{
	var record;
	selctIndex = index;
	
	if (index == -1)
	{
		if (dlnaDirectorys.length-1 >= 10)
		{
			setText('UrlUtf','');	
			setDisplay('DeviceDir', 0);
			setDisplay('tablesubmit', 0);	
			AlertEx(DlnaLgeDes['s1606']);
			return;
		}
		else
		{
			record = new stdlnaDirectory('','','');
			setText('UrlUtf','');	
			setDisplay('ConfigForm', 1);
			setDisplay('DeviceDir', 1);
		}
	}
	else if (index == -2)
	{
		setDisplay('ConfigForm', 0);
		setDisplay('DeviceDir', 0);
	}
	else
	{
	
		record = dlnaDirectorys[index];
		
		var Tmpdlnapath = record.ContentDirectory;
		if("1_1" == record.ContentDirectory)
		{
			Tmpdlnapath = "usb1_1";
		}
						
		setText('UrlUtf',Tmpdlnapath);
		setDisplay('ConfigForm', 1);
		setDisplay('DeviceDir', 0);
	}
	setDisplay('tablesubmit', 1);	
	setDisable('btnApplydlna', 0);
	setDisable('cancelValue', 0);
}


function selectRemoveCnt(obj) 
{

} 

function stDelete(form,index)
{
	form.addParameter(dlnaDirectorys[index].domain, '');
}

function clickRemove() 
{	
	var Form = new webSubmitForm();	
	var cnt = 0;  
	var rml = getElement('rml');
	if (rml != null)
	{    
	  with (document.forms[0])
	  {
	      if (rml.length > 0)
	      {
	          for (var i = 0; i < rml.length; i++)
	          {
	              if (rml[i].checked == true)
	              {
	              	 
	                  stDelete(Form,i);
	                  cnt++;
	              }
	          }
	
	      }
	      else if (rml.checked == true)
	      {
				
					stDelete(Form,0);
					cnt++;
	      }
	  }
		if( 0 != cnt)
		{
			Form.setAction('del.cgi?RequestFile=html/ssmp/dlna/e8cdlna.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();	
		}
	}
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<form id="Configure"> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabTest"> 
    <tr> 
      <td class="prompt"> <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
          <tr> 
            <td class='title_common' BindText='s1600'></td> 
          </tr> 
           <tr> 
      <td class="title_common">  
	  <div>	
	  <table>
          <tr> 
            <td class='width_13p align_left'><img style="margin-bottom:2px" src="../../../images/icon_01.gif" width="15" height="15" /></td> 
            <td class='width_87p align_left'><script>document.write(DlnaLgeDes['s0531']);</script></td> 
          </tr>
		 </table>
	 </div>
		  <tr>
		  <td class="title_common">
		  <script>document.write(DlnaLgeDes['s0532']);</script>
		  </td>
		  </tr>
       </td> 
    </tr> 
        </table></td> 
    </tr> 
  </table> 
  <div class="title_spread"></div>
  <table cellpadding="0" cellspacing="0" class="tabal_bg" width="100%"> 
    <tr> 
      <td class="table_title width_25p" BindText='s1601'></td> 
      <td class="table_right"> <input type="checkbox" id='dlnaEnable' name='dlnaEnable'></td> 
    </tr> 
    <tr> 
      <td  class="table_title width_25p" BindText='s1410'></td> 
      <td class="table_right">
      	<input name="idRadioDirectory" id="idRadioAllDirectory" type="radio" value="1" onclick="radioChooseDirOption();"/> 
				<script>document.write(DlnaLgeDes['s1603']);</script>
				<input name="idRadioDirectory" id="idRadioChooseDirectory" type="radio" value="0" checked="checked" onclick="radioChooseDirOption();"/> 
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">				
				<script>document.write(DlnaLgeDes['s1604']);</script></td> 
    </tr> 
  </table> 
  <div id="ConfigDlna" style="display:none"> 
	<script language="JavaScript" type="text/javascript">
	writeTabCfgHeader('Dlna','100%');
	</script> 
	
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="DlnaInst">
      <tr class="head_title">
        <td class="per_15_20">&nbsp;</td>
        <td ><div class="align_center"><script>document.write(DlnaLgeDes['s1604']);</script></div></td>
      </tr>
        <script language="JavaScript" type="text/javascript">
        	if(dlnaDirectorys.length -1 == 0)
				{
					document.write('<TR id="record_no"' +' class="tabal_center01 " onclick="selectLine(this.id);">');
					document.write('<TD >--</TD>');
					document.write('<TD >--</TD>');
					document.write('</TR>');
				}
				else
				{
					for (var i = 0; i < dlnaDirectorys.length - 1; i++)
					{
						if( i%2 == 0 )
						{						
							document.write('<TR id="record_' + i 
										+'" class="tabal_01 " onclick="selectLine(this.id);">');
						}
						else
						{
							document.write('<TR id="record_' + i 
										+'" class="tabal_02 " onclick="selectLine(this.id);">');				
						}						
								        
						document.write('<TD class="align_center">' + '<input id = \"rml'+i+'\" type="checkbox" name="rml"'  + ' value="' 
												+ htmlencode(dlnaDirectorys[i].domain) + '" onclick="selectRemoveCnt(this);">' + '</TD>');
												
						var dlnapath = dlnaDirectorys[i].ContentDirectory;
						if("1_1" == dlnaDirectorys[i].ContentDirectory)
						{
							dlnapath = "usb1_1";
						}
						document.write('<td title="'+ htmlencode(dlnapath) +'">'+GetStringContent(htmlencode(dlnapath), 64)+'</td>');
					}
				}
        </script>
    </table>
	
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr id="DeviceDir"> 
      <td class="table_title" style="width: 120px"><script>document.write(DlnaLgeDes['s1609']);</script></td> 
      <td class="table_right">
      	<input type="text" id="UrlBase" name="UrlBase" style="display:none"> 
      	<input type='text' id="UrlUtf" name='UrlUtf' disabled="disabled" class='width_60p' ><font class="color_red">*</font>
      	<input id="MediaChooseInput" name="MediaChooseInput" alt="../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true" title="" class="thickbox" type="button" BindText="s1605"/>
        <script>
          document.getElementsByName('MediaChooseInput')[0].title = DlnaLgeDes['s1436'];
        </script>
      </td> 
    </tr> 
  </table> 
	<script language="JavaScript" type="text/javascript">
	DlnaWriteTabTail();
	</script>
	<div id="ConfigForm"></div>
	</div>
  <div class="button_spread"></div>
  <table id="tablesubmit" cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
    <tr align="right"> 
      <td class='width_25p'></td> 
      <td class="table_submit" align="right"> 
      	<input name="btnApplydlna" id="btnApplydlna" type="button" BindText="s0526" class="submit" onClick="SubmitForm();">
        <input name="cancelValue" id="cancelValue" type="button" BindText="s0527" class="submit" onClick="CancelConfig();"></td> 
    </tr> 
  </table> 
</form> 
</body>
</html>
