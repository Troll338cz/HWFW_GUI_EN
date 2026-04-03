<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.tabal_noborder_bg {
	padding:0px 0px 10px 0px;
	background-color: #FAFAFA;
}
</style>
<script language="javascript">
var inter_index = -1;
var iptv_index = -1;
var SrvType = '';
var conditionpoolfeature ='<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_COND_POOL);%>';
var CfgModeWord = '<%HW_WEB_GetCfgMode();%>';
var click_bak = -1;

function filterWan(WanItem)
{
	if (!(Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))
	{
		return false;	
	}
	
	return true;
}
var Wan = GetWanListByFilter(filterWan);

var PolicyRouteListAll = GetPolicyRouteList();
var PolicyRouteList = new Array();
var i,j = 0;
for (i = 0; i < PolicyRouteListAll.length; i++)
{  
    if (PolicyRouteListAll[i] == null)
    {
        PolicyRouteList[j++] = PolicyRouteListAll[i];
        continue;
    }
     
    if (PolicyRouteListAll[i].Type.toUpperCase() == "EthernetType".toUpperCase())
    {
        PolicyRouteList[j++] = PolicyRouteListAll[i];
        continue;
    }
}

function DelServiceRoute()
{
	if (PolicyRouteList.length-1!=0)
	{
		 $.ajax({
			 type : "POST",
			 async : true,
			 cache : false,
			 data : PolicyRouteList[0].Domain+"="+"&x.X_HW_Token="+getValue('onttoken'),
			 url : "del.cgi?x=InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route&RequestFile=html/not_find_file.asp",
			 success : function(data) {
			 },
			 complete: function (XHR, TS) {
				XHR=null;
			 }
		});
	}
}

function CreateServiceRoute(SrvRouteWanName)
{
	if (PolicyRouteList.length-1==0)
	{
		 $.ajax({
			 type : "POST",
			 async : true,
			 cache : false,
			 data : "x.PolicyRouteType=EthernetType"+"&x.VenderClassId="+"&x.WanName="+SrvRouteWanName+"&x.EtherType=PPPoE"+"&x.X_HW_Token="+getValue('onttoken'),
			 url : "add.cgi?x=InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route&RequestFile=html/not_find_file.asp",
			 success : function(data) {
			 },
			 complete: function (XHR, TS) {
				XHR=null;
			 }
		});
	}
	else
	{	
		 $.ajax({
			 type : "POST",
			 async : true,
			 cache : false,
			 data : "x.PolicyRouteType=EthernetType"+"&x.VenderClassId="+"&x.WanName="+SrvRouteWanName+"&x.EtherType=PPPoE"+"&x.X_HW_Token="+getValue('onttoken'),
			 url : "set.cgi?x="+PolicyRouteList[0].Domain+"&RequestFile=html/not_find_file.asp",
			 success : function(data) {
			 },
			 complete: function (XHR, TS) {
				XHR=null;
			 }
		});
	}
}

function ShowNoneInternetWan()
{
	setText('pppoeUser', "");
	setText('pppoePassword', "");
	
	setDisable('pppoeUser', 1);
	setDisable('pppoePassword', 1);	
	return;
}

function getInternetWaninfo()
{
	var i = 0;
	for (i = 0; i < Wan.length; i++)
	{
		if ((Wan[i].ServiceList.toUpperCase().indexOf("INTERNET") >= 0)
         && (Wan[i].EncapMode.toUpperCase() == "PPPOE"))
		{
			inter_index = i;
			if (Wan[i].Mode == "IP_Routed")
			{
				setText('pppoeUser',Wan[i].UserName);
				setText('pppoePassword', Wan[i].Password);
			}
			else
			{
				setText('pppoeUser','');
				setText('pppoePassword', '');
			}
			break;
		}
	}
	return;
}

function getIptvWaninfo()
{
	for (var i = 0; i < Wan.length; i++)
	{ 
		if (Wan[i].Mode == 'IP_Routed' && Wan[i].ServiceList == 'IPTV' && Wan[i].IPv4Enable == '1' && Wan[i].IPv4AddressMode == 'Static')
		{
			iptv_index = i;
			break;
		}
	}	
	
	if (-1 == iptv_index)
	{
		return;
	}
	
	var wanenable = Wan[iptv_index].Enable;
	if (1 == wanenable)
	{
		SrvType = 'THREE';
	}
	else
	{
		SrvType = 'TWO';
	}
	
	var natenable = Wan[iptv_index].IPv4NATEnable;
	if (1 == natenable)
	{
		getElement("radiosrv")[0].checked = true;
		click_bak = 0;
	}
	else
	{
		getElement("radiosrv")[1].checked = true;
		click_bak = 1;
	}
	
}

function setRadioDisplay()
{
		setDisable('pppoeUser', 1);
		setDisable('pppoePassword', 1);
}

function radioClick()
{
	setRadioDisplay();
	
	if(getElement("radiosrv")[0].checked == true)
	{
		if (click_bak == 0)
		{
			return true;
		}
		if(-1 != inter_index)
		{
			setText('pppoeUser',Wan[inter_index].UserName);
			setText('pppoePassword', Wan[inter_index].Password);
			if (false == setMultiUser())
			{
				return false;
			}
		}
	}
	else
	{
		if (click_bak == 1)
		{
			return true;
		}
		$("#ConfigMultoSing").css("display","block");
		$("#BaseMask").css("display","block");
	}
}

function ClickHelp(val)
{
	val.id = 'devhelpinfo';
	val.NameStr = 'Web setup wizard help';
	val.name = '/CustomApp/helpinfo.asp';
	window.parent.OnChangeIframeShowPage(val); 
}

function CheckFormMulti()
{
	var Username = getValue('pppoeUser');
	var Password = getValue('pppoePassword');

	if ((Username != '') && (isValidAscii(Username) != ''))        
	{  
		AlertEx(guideinternet_language['bbsp_userh'] + Languages['Hasvalidch'] + isValidAscii(Username) + '".');          
		return false;       
	}
	
	if ((Password != '') && (isValidAscii(Password) != ''))      
	{  
		AlertEx(guideinternet_language['bbsp_pwdh'] + Languages['Hasvalidch'] + isValidAscii(Password) + '".');          
		return false;       
	}
	
	return true;
}

function GetPolicyRouteListLength(PolicyRouteList, Type)
{
	var Count = 0;

	if (PolicyRouteList == null)
	{
		return 0;
	}

	for (var i = 0; i < PolicyRouteList.length; i++)
	{
		if (PolicyRouteList[i] == null)
		{
			continue;
		}

		if (PolicyRouteList[i].Type == Type)
		{
			Count++;
		}
	}

	return Count;
}

function CheckForm()
{
	if(getElement("radiosrv")[0].checked == true)
	{
		if (false == CheckFormMulti())
		{
			return false;
		}
	}
	return true;
}

function setWanConnectionType(ConnectionType)
{
	 $.ajax({
		 type : "POST",
		 async : true,
		 cache : false,
		 data : "x.ConnectionType="+ConnectionType+"&x.X_HW_Token="+getValue('onttoken'),
		 url : "set.cgi?x="+Wan[inter_index].domain+"&RequestFile=html/not_find_file.asp",
		 success : function(data) {
		 },
		 complete: function (XHR, TS) {
			XHR=null;
		 }
		});
}

function setMultiUser()
{	
	var Form = new webSubmitForm();
	var urldomain = '';
	var SrvRouteWanName = '';
	if (false == CheckForm())
	{
		return false;
	}
	if (-1 != inter_index)
	{
		if (Wan[inter_index].Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0)
		{
			setWanConnectionType("IP_Routed");
		}
		DelServiceRoute();
	}
	if ('THREE' == SrvType.toUpperCase())
	{
		if (-1 != iptv_index)
		{
			Form.addParameter('y.NATEnabled',1);
			if (-1 != inter_index)
			{
				urldomain += '&y=' + Wan[iptv_index].domain;
			}
			else
			{
				urldomain = 'y=' + Wan[iptv_index].domain;
			}
		}
	}
	var url = 'set.cgi?' + urldomain + '&RequestFile=html/bbsp/guideinternet/guideinternettde.asp';
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction(url);
	Form.submit();
}

function SetIptvWanNat()
{
	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : "y.NATEnabled="+0+"&x.X_HW_Token="+getValue('onttoken'),
		 url : "set.cgi?y="+Wan[iptv_index].domain+"&RequestFile=html/not_find_file.asp",
		 success : function(data) {
		 },
		 complete: function (XHR, TS) {
			XHR=null;
		 }
		});
}

function setSingleUser()
{
	if (false == CheckForm())
	{
		return false;
	}
	
	var urldomain = '';
	var SrvRouteWanName = '';
	if (-1 != inter_index)
	{
		if (Wan[inter_index].Mode == "IP_Routed")
		{
			setWanConnectionType("PPPoE_Bridged");
		}
		SrvRouteWanName = domainTowanname(Wan[inter_index].domain);
		CreateServiceRoute(SrvRouteWanName);
	}

	if (-1 == iptv_index)
	{
		 AlertEx(installservice_language['bbsp_creatwan']);
		 return;
	}
	SetIptvWanNat();
}

function OnClickguide(varflag)
{
	if (varflag == '0')
	{
		$("#ConfigMultoSing").css("display", "none");
		$("#BaseMask").css("display","none");
		getInternetWaninfo();
		getIptvWaninfo();
	}
	else
	{
		setDisable('cancelbut',1);
		setDisable('confirmbut',1);
		
		if (false == setSingleUser())
		{
			return false;
		}				
		var Form = new webSubmitForm();
				
		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
								+ '&RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));						
		Form.submit();
	}
}

function LoadFrame()
{
	ShowNoneInternetWan();
	if (0 == Wan.length)
	{
		return;
	}
	getInternetWaninfo();
	getIptvWaninfo();
	setRadioDisplay();
	return;
}

</script>
</head>
<body onload="LoadFrame();" class="iframebody">
<div id="BaseMask" style=""></div>
<div id="ConfigMultoSing" class="ConfigResultWindow">
<div class="DivSpread_30PX"></div>
<div id="AlarmText" class="AlarmTitleTextCss" BindText="bbsp_changesignleinfo"></div>
<div class="DivSpread_20PX"></div>
<div id="ChooseButtonId" class="ChooseButtonCss">
<td class="table_submit"> <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<input type="button"  class="BluebuttonGreenBgcss buttonfloatleft Buttonwidth_120px" id="cancelbut" onClick="OnClickguide('0');" value="" BindText="bbsp_cancle"/>
<input type="button"  class="BluebuttonGreenBgcss buttonfloatright Buttonwidth_120px" id="confirmbut" onClick="OnClickguide('1');" value="" BindText="bbsp_apply"/>
</div>
</div>

<div style="height:20px;"></div>
<div id="DivMultiUser" class="FuctionPageAreaCss">
<div id="DivMultiUserTitle" class="FunctionPageTitleCss">
<input type="radio" id="radiosrv" name="radiosrv" class="PageTitleTextCss" onclick='radioClick();' checked="true" value="1"> 
<script>document.write(guideinternet_language['bbsp_multiusertitle']);</script>
</input>
</div>
<div style="height:30px;"></div>
<form id = "MultiDynamicConfigForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_noborder_bg"> 
<tr><td BindText="bbsp_dynamicaddr" class="PageSumaryTitleCss padleft"></td></tr></table> 
<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
<li   id="pppoeUser"        		RealType="TextBox"      	  DescRef="bbsp_pppoeuser"        	   RemarkRef="Empty"     				ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   InitValue="Empty"   MaxLength="64"/>
<li   id="pppoePassword"            RealType="TextBox"            DescRef="bbsp_pppoepwd"              RemarkRef="Empty"                    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   InitValue="Empty"   MaxLength="64"/>
</table>
<script>
var TableClass = new stTableClass("PageSumaryTitleCss tablecfg_title width_per40", "tablecfg_right width_per60", "ltr");
var MultiDynamicConfigFormList = new Array();
MultiDynamicConfigFormList = HWGetLiIdListByForm("MultiDynamicConfigForm");
HWParsePageControlByID("MultiDynamicConfigForm", TableClass, guideinternet_language, null);
</script>
</form>

<div style="height:30px;"></div>
</div>

<div style="height:20px;"></div> 
<div id="DivSingleUser" class="FuctionPageAreaCss">
<div id="DivSingleUserTitle" class="FunctionPageTitleCss">
<input type="radio" name="radiosrv" class="PageTitleTextCss" onclick='radioClick();' value="2"> 
<script>document.write(guideinternet_language['bbsp_singleusertitle']);</script>
</input>
</div>
<div style="height:30px;"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_noborder_bg"> 
<tr><td BindText="bbsp_dynamicaddr" class="PageSumaryTitleCss padleft"></td></tr>
</table> 

<div id="signleuserinfo" class="PageSumaryInfoCss">
<script>
	document.write(guideinternet_language['bbsp_signleinfo1']);
	document.write('<a id="help" href="#" name="help" class="helpclass" onClick="ClickHelp(this);">');
	document.write(guideinternet_language['bbsp_signleinfo2']);
	document.write('</a>');
	document.write(guideinternet_language['bbsp_signleinfo3']);
</script>
</div>
<div style="height:30px;"></div>
</div>

<script>
	ParseBindTextByTagName(guideinternet_language, "div",  1);
	ParseBindTextByTagName(guideinternet_language, "span",  1);
	ParseBindTextByTagName(guideinternet_language, "td",    1);
	ParseBindTextByTagName(guideinternet_language, "input", 2);
</script>
</body>
</html>
