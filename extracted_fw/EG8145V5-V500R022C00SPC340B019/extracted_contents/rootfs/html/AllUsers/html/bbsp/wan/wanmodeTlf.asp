<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet" type="text/css" href='../../../Cuscss/<%HW_WEB_GetCusSource(gateway.css);%>' type='text/css'/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list.asp);%>"></script>
<title>Router - Bridge</title>
<style type="text/css">
td#WanInfoTitleBarTwo {
    color: rgb(202,81,81);
}
</style>
<script language="JavaScript" type="text/javascript">

var AccessClass = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_AccessCtrl.AccessClass);%>';	

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

function ApplyConfig()
{
	if (AccessClass.toUpperCase() == "SERVICE02")
	{
		return;
	}

	if(internetPPPWanInfo.length == 0)
	{
		AlertEx(Languages['wanNotExsit']);
		return false;
	}
	setDisable('btnApply', 1);
	var wanMode = (getSelectVal('WanMode').indexOf("IP_Routed") >= 0)?"IP_Routed":"PPPoE_Bridged";
	if(internetPPPWanInfo[0].Mode.toUpperCase() == "IP_ROUTED" && wanMode == "PPPoE_Bridged")
	{
		AlertEx(Languages['bbsp_titlewebinfotwo']);
	}
	var SpecPPPWanCfgParaList = new Array(new stSpecParaArray("x.ConnectionType", wanMode, 1));
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = WanModeConfigFormList;
	Parameter.SpecParaPair = SpecPPPWanCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=' + internetPPPWanInfo[0].domain + '&RequestFile=html/bbsp/wan/wanmodeTlf.asp';
				  
	HWSetAction(null, url, Parameter, tokenvalue);
}

function LoadFrame()
{
	setDisable("WanMode", 0);
	setDisable("btnApply"), 0;
	if (AccessClass.toUpperCase() == "SERVICE02")
	{
		setDisable("WanMode", 1);
		setDisable("btnApply", 1);
	}
		
	setSelect('WanMode', "IP_Routed");
	if(internetPPPWanInfo.length > 0)
	{
		setSelect('WanMode', internetPPPWanInfo[0].Mode);
	}
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
	<form id="ConfigForm">
		<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
			<li   id="WanInfoTitleBar"    RealType="HorizonBar"    DescRef="bbsp_titlewebinfo"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"                   InitValue="Empty"/>                                                            
			<li   id="WanMode"            RealType="DropDownList"  DescRef="bbsp_dropwebinfo"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.ConnectionType" 	Elementclass="SelectText"  InitValue="[{TextRef:'routerType',Value:'IP_Routed'},{TextRef:'bridgedType',Value:'IP_Bridged'}]"/>   
		</table>
		<script>
			var TableClass = new stTableClass("table_title width_per25", "table_right", "");
			WanModeConfigFormList = HWGetLiIdListByForm("ConfigForm");
			HWParsePageControlByID("ConfigForm", TableClass, Languages, null);
		</script>
  		<table id="ConfigPanelButtons" width="100%"  class="table_button"> 
    		<tr> 
      			<td>
	    			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	  				<button name="btnApply" id="btnApply" type="button" class="btn-default-orange-small right" onClick="ApplyConfig();return false;"><script>document.write(Languages['bbsp_proceed']);</script></button>  
				</td> 
    		</tr> 
  		</table> 
	</form>
</body>
</html>
