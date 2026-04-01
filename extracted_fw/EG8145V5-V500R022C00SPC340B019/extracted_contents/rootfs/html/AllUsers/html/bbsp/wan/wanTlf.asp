<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet" type="text/css" href='../../../Cuscss/<%HW_WEB_GetCusSource(gateway.css);%>'/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<style>
#WanSInfoBar {
    background: #f3f3f4;
    line-height: 14px;
    padding: 10px 4px;
}
.table_right input {
    width: 180px;
    height: 24px;
    line-height: 24px;
    padding-left: 10px;
}
#pppoeUserRemark {
    color: rgb(202, 81, 81) !important;
    display: block;
}
</style>
<script language="JavaScript" type="text/javascript">

function filterWan(wanItem)
{
	if ((wanItem.ServiceList.toUpperCase().indexOf("INTERNET") >= 0)
         && (wanItem.EncapMode.toUpperCase() == "PPPOE"))
	{
		return true;	
	}
	
	return false;
}
var internetPPPWanInfo = GetWanListByFilter(filterWan);

function CheckForm()
{
	var Username = getValue('pppoeUser');
	var Password = getValue('pppoePassword');

	if (internetPPPWanInfo.length == 0)
	{
		AlertEx(Languages['wanNotExsit']);
		return false; 
	}

	if ((Username != '') && (isValidAscii(Username) != ''))        
	{  
		AlertEx(Languages['wan_useNamemh'] + Languages['Hasvalidch'] + isValidAscii(Username) + '".');          
		return false;       
	}
	
	if ((Password != '') && (isValidAscii(Password) != ''))      
	{  
		AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + isValidAscii(Password) + '".');          
		return false;       
	}
	
	return true;
}

function LoadFrame()
{
	if(internetPPPWanInfo.length == 0)
	{
		setText('pppoeUser', "");
		setText('pppoePassword', "");
	}
	else
	{
		setText('pppoeUser', internetPPPWanInfo[0].UserName);
		setText('pppoePassword', internetPPPWanInfo[0].Password);
	}
}

function CancelConfig()
{
	LoadFrame();
}

function ApplyConfig()
{
	if (false == CheckForm())
	{
		return false;
	}
    setDisable('btnCancel', 1);
    setDisable('btnApply', 1);
	
	var SpecPPPWanCfgParaList = new Array(new stSpecParaArray("x.Username", getValue('pppoeUser'), 1),
										  new stSpecParaArray("x.Password", getValue('pppoePassword'), 1));
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = pppWanConfigFormList;
	Parameter.SpecParaPair = SpecPPPWanCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=' + internetPPPWanInfo[0].domain + '&RequestFile=html/bbsp/wan/wanTlf.asp';
				  
	HWSetAction(null, url, Parameter, tokenvalue);
};

</script>
</head>
<body onLoad="LoadFrame();" >
<form id="ConfigForm">
	<table id="ConfigPanel"  width="100%" cellspacing="1" cellpadding="0"> 
		<li   id="BasicInfoBar"      RealType="HorizonBar"         DescRef="WanBasicInfoTlf"     RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty" 	   InitValue="Empty"/> 	
		<li   id="WanSInfoBar"       RealType="HorizonBar"         DescRef="wanInfobarTlf"       RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"      InitValue="Empty"/> 		
        <li   id="pppoeUser"         RealType="TextBox"            DescRef="wan_useName"         RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"      InitValue="Empty"/>
        <li   id="pppoePassword"     RealType="TextBox"            DescRef="IPv4Password"        RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"      InitValue="Empty"/>
     </table>
	 <script>
		 var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			pppWanConfigFormList = HWGetLiIdListByForm("ConfigForm");
			HWParsePageControlByID("ConfigForm", TableClass, Languages, null);
	  </script>
  		<table id="ConfigPanelButtons" width="100%"  class="table_button"> 
    		<tr> 
      			<td>
	    			<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 
        			<button name="cancelValue" id="btnCancel" type="button" class="btn-default-orange-small right" onClick="CancelConfig();"><script>document.write(dmz_language['bbsp_cancel']);					</script></button> 					
	  				<button name="btnApply1" id="btnApply" type="button" class="btn-default-orange-small right" onClick="ApplyConfig();"><script>document.write(dmz_language['bbsp_save']);</script></button> 

				</td> 
    		</tr> 
  		</table> 	  
</form>
</body>
</html>

