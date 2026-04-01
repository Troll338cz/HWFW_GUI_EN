<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type="text/css">
.nomargin {
	margin-left: 0px;
	margin-right:0px;
	margin-top: 0px;
}
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
GetIPTVPortInfo();

function GetIPTVPortInfo()
{
	if (IPTVUpPortInfo.length != 0)
	{
		var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
		var tempIPTVUpList = tempIPTVUpValue.split(".");
		self.parent.CurrentIPTVUpInfo = tempIPTVUpList[0];
	}
}

function InitIPTVUpFromValue()
{
	var isNeedAdd = 1;
	var Option = document.createElement("Option");
	Option.value = "";
	Option.innerText = "";
	Option.text = "";
	removeAllOption("IPTVUpPortID");
	getElById("IPTVUpPortID").appendChild(Option);

	for (var i = 1; i <= self.parent.TopoInfo.EthNum; i++)
	{
		isNeedAdd = 1;
		lanoption = "LAN" + i;
		if ((notSupportPON == "1") && (i > 3)) {
            isNeedAdd = 0;
            break;
        }
		for (var j = 0; j < self.parent.CurrentLANPortList.length; j++)
		{
			if (lanoption == self.parent.CurrentLANPortList[j])
			{
				isNeedAdd = 0;
				break;
			}
		}
		
		if (isNeedAdd == 1)
		{
			Option = document.createElement("Option");
			Option.value = lanoption;
			Option.innerText = lanoption;
			Option.text = lanoption;
			getElById("IPTVUpPortID").appendChild(Option);
		}
	}
	
	if (self.parent.CurrentIPTVUpInfo != "")
	{
		setSelect("IPTVUpPortID", self.parent.CurrentIPTVUpInfo);
	}
	
	return;
}

function IPTVUpCancle()
{
	LoadFrame();
	return;
}

function SetIPTVUpPort()
{
	var tempIPTVUPValue = getSelectVal("IPTVUpPortID").replace("LAN", LANPath);
	var resultInfo = -1;
	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : "y.IPTVUpPort=" + tempIPTVUPValue + "&x.X_HW_Token="+getValue('onttoken'),
		 url : "setajax.cgi?y=InternetGatewayDevice.X_HW_APService&RequestFile=html/bbsp/lanservicecfg/iptvupport.asp",
		 success : function(data) {
			var tempResultInfo = JSON.parse(hexDecode(data));
			resultInfo = tempResultInfo.result;
		 }
		});
	
	return resultInfo;
}

function IPTVUpSubmit()
{
	if(ConfirmEx(lanservicecfg_language["bbsp_lanservice_restart"])) 
	{
		setDisable('btnIPTVUpApply',1);
		setDisable('btnIPTVUpCancle',1);
		if (0 != SetIPTVUpPort())
		{
			AlertEx(lanservicecfg_language["bbsp_lanservice_set_iptvfail"]);
			LoadFrame();
			setDisable('btnIPTVUpApply',0);
			setDisable('btnIPTVUpCancle',0);
			return;
		}
		
		var Form = new webSubmitForm();		
		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
								+ '&RequestFile=html/bbsp/lanservicecfg/lanservicecfg.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));						
		Form.submit();
	}

	return;
}

function LoadFrame()
{
	InitIPTVUpFromValue();
	return;
}
</script>
</head>
<body  class="mainbody nomargin" onload="LoadFrame();">
	<form id="IPTVUpPortConfigForm" action="">
		<table id="table_IPTVUpInfo" border="0" cellpadding="0" cellspacing="1"  width="100%">
			<li id="IPTVUpPortID" RealType="DropDownList" DescRef="bbsp_lanservice_iptvup" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"  InitValue="Empty"/>
		</table>
		
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("IPTVUpPortConfigForm", null);
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			HWParsePageControlByID("IPTVUpPortConfigForm", TableClass, lanservicecfg_language, null);
		</script>
		
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per30"></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
					<button type="button" name="btnIPTVUpApply" id="btnIPTVUpApply"  class="ApplyButtoncss buttonwidth_100px" onClick='IPTVUpSubmit()'><script>document.write(lanservicecfg_language['bbsp_lanservice_iptvupapply']);</script></button> 
					<button type="button" name="btnIPTVUpCancle" id="btnIPTVUpCancle" class="CancleButtonCss buttonwidth_100px" onClick='IPTVUpCancle()'><script>document.write(lanservicecfg_language['bbsp_lanservice_iptvupcancle']);</script></button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
