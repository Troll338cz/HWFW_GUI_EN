<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>User Device Information</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style type="text/css" media="screen">
	.pix_70_130{
		width:130px;
	}
</style>
<script language="JavaScript" type="text/javascript">
var list = 5;
var MAX_DEV_TYPE=16;
var MAX_HOST_TYPE=16;
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';

function IsFreInSsidName()
{
	if(1 == IsPTVDFFlag)
	{
		return true;
	}
}

if (IsDevTypeFlag ==1)
{
	MAX_HOST_TYPE = 8;
	MAX_DEV_TYPE = 10;
}

var firstpage = 1;
var page = firstpage;
var lastpage = 0;
var DHCPLeaseTimes = new Array();
var UserDevices = new Array();

var STBPort = '<%HW_WEB_GetSTBPort();%>';

function IsValidPage(pagevalue)
{
	if (true != isInteger(pagevalue))
	{
		return false;
	}
	return true;
}

function initFirstPage(UserDevicesnum)
{
	if(UserDevicesnum == 0)
	{
		firstpage = 0;
	}

	page = firstpage;

	if( window.location.href.indexOf("?") > 0)
	{
	  page = parseInt(window.location.href.split("?")[1],10); 
		if (false == IsValidPage(page))
		{
		    if( window.location.href.indexOf("x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev") <= 0)
		    {		    
			    AlertEx(userdevinfo_language['bbsp_faulturl']);		
			    page = (0 == UserDevicesnum) ? 0:1;
			}
		}
	}

	lastpage = UserDevicesnum/list;
	if(lastpage != parseInt(lastpage,10))
	{
		lastpage = parseInt(lastpage,10) + 1;	
	}

	if( window.location.href.indexOf("?") > 0)
	{
		var href = window.location.href.split("?")[1];
	
		if( window.location.href.indexOf("x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev") > 0)
		{	
			page = window.location.href.split("?")[2].split('&')[0]; 
		}
		else
		{	
		    page = href;
		}
	}

	if( page > lastpage )
	{
		page = lastpage;
	}
}

function submit1(index)
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	window.location="userdetdevinfo.asp?" + index +  "?" + parseInt(page,10);
}

function submit2(index)
{
	var shell = null;
	var index_s=index.split("_")[1];
	var address = "\\\\"+UserDevices[index_s].IpAddr;
	try
	{
        shell = new ActiveXObject("wscript.shell");
    }
	catch(exception)
	{
		AlertEx(userdevinfo_language['bbsp_explorertooh']+"\r\n\r\n" +userdevinfo_language['bbsp_youcaninput']+"\""+address+"\""+userdevinfo_language['bbsp_accesscom']);
		return false;
	}
	shell.run("explorer "+address);
}

function GetHpa(MainName)
{
	var menuItems = top.Frame.menuItems;	
	
	for(var i in menuItems)
	{		
		if(MainName == menuItems[i].name)
		{
			return menuItems.length - i;
		}
	}
	
	return -1;
}

function GetZpa(MainName, SubItemName)
{
	var Hpa = GetHpa(MainName);
	if(Hpa == -1)
	{
		return -1;
	}
	
	var subItems = top.Frame.menuItems[top.Frame.menuItems.length - Hpa].subMenus;
	for(var i in subItems)
	{
		if(SubItemName == subItems[i].name)
		{	
			return i;
		}
	}
	
	return -1;
}

function gotoMACFilter(numpara1, mac, porttype, portid, index_a)
{
	if ("ETH" ==  porttype)
	{
		var MainName = userdevinfo_language['bbsp_macfilter_main_item'];
		var SubItemName = userdevinfo_language['bbsp_macfilter_sub_item'];

		var hpa = GetHpa(MainName);
		var zpa = GetZpa(MainName, SubItemName);
		if(hpa != -1 && zpa != -1)
		{
			top.Frame.showjump(hpa, zpa);
		}
		window.location='../../../html/bbsp/macfilter/macfilter.asp?' + mac;
	}
	else
	{
		var MainName = userdevinfo_language['bbsp_wlanmacfil_main_item'];
		var SubItemName = userdevinfo_language['bbsp_wlanmacfil_sub_item'];

		var hpa = GetHpa(MainName);
		var zpa = GetZpa(MainName, SubItemName);

		if(hpa != -1 && zpa != -1)
		{
			top.Frame.showjump(hpa, zpa);
		}
		window.location='../../../html/bbsp/wlanmacfilter/wlanmacfilter.asp?' + mac + '?' + portid;
	}
}


function submit3(index, IsBridgeFlag)
{
	var index_a=index.split("_")[1];
    var jumppageURL ="netapp.asp?";
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	if (curWebFrame == 'frame_XGPON')
	{
		jumppageURL ="netappsmart.asp?";
	}
	if( "X_RTK_BRIDGE" == UserDevices[index_a].IpType)
	{
		var numpara1 = UserDevices[index_a].IpAddr;
		var numpara2 = UserDevices[index_a].MacAddr;
		var porttype = UserDevices[index_a].PortType;
		var portid   = UserDevices[index_a].Port;
	
		gotoMACFilter(numpara1, numpara2, porttype, portid , index_a);
	} else {
		window.location=jumppageURL + UserDevices[index_a].IpAddr + "?"+ UserDevices[index_a].MacAddr + "?" + UserDevices[index_a].PortType + "?" + UserDevices[index_a].Port + "?" + parseInt(page,10); 
	}
}


function submit4(index)
{
	var index_a=index.split("_")[1];
		
	if (ConfirmEx(userdevinfo_language['bbsp_devinfodelconfirm'])) 
	{
		var Form = new webSubmitForm();
		Form.addParameter(UserDevices[index_a].Domain,'');
		if (false == IsValidPage(page))
		{
			AlertEx(userdevinfo_language['bbsp_faulturl']);
			return;
		}
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('del.cgi?' +'x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev' + '?' + parseInt(page,10) + '&RequestFile=html/bbsp/userdevinfo/userdevinfo.asp');
		Form.submit();
		DisableRepeatSubmit();
	}
}

function appendstr(str)
{
	return str;
}

function IsBridgeAddressSource(IPAddressSource)
{
	if(("Static"==IPAddressSource)||("DHCP"==IPAddressSource))
	{
		return false;
	}
	return true;
}

function IsSpecifiedDeviceType(obj)
{
	var arr = ["",userdevinfo_language['bbsp_phone'],userdevinfo_language['bbsp_pad'],
                userdevinfo_language['bbsp_pc'],userdevinfo_language['bbsp_stb'],userdevinfo_language['bbsp_other']];
    if (obj.UserSpecifiedDeviceType >0)
    {
        return arr[obj.UserSpecifiedDeviceType];
    }
    else
    {
        return "--";
    }
}

function showRdsGatewayUserSta(index) {
	if (IsRDSGatewayUserSsid(index) != 1) {
		return false;
	}
	if (DoubleFreqFlag == 1) {
		if (index != 5) {
			return true;
		}
		return false;
	}
	return true;
}

function shoulist(startlist , endlist, UserDevicesInfo)
{
	var outputlist = "";
	if(UserDevicesInfo.length - 1 == 0)
	{
		outputlist = outputlist + appendstr("<tr class=\"tabal_center01\">");
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		if (IsDevTypeFlag == 1)
		{
			outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
			outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		}
		outputlist = outputlist + appendstr('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		outputlist = outputlist + appendstr("</tr>");

		$("#devlist").append(outputlist);
		return;
	}

	for(i=startlist;i <= endlist - 1;i++)   
	{
		if (UserDevicesInfo[i].PortType.toUpperCase().indexOf("WIFI") >=0)
		{	
			var ssidindex = UserDevicesInfo[i].Port;	
			ssidindex = ssidindex.charAt(ssidindex.length-1);
			if ((1 == isSsidForIsp(ssidindex)) || (showRdsGatewayUserSta(ssidindex) == 1))
			{
				continue;
			}
		}
		
		var hostport = '';
		if( "LAN0" == UserDevicesInfo[i].Port.toUpperCase() || "SSID0" == UserDevicesInfo[i].Port.toUpperCase())
		{
			hostport = "--";
		}
		else
		{
			hostport = UserDevicesInfo[i].Port.toUpperCase();
			if(true == IsFreInSsidName())
			{
				var SL = GetSSIDList();
				var SLFre = GetSSIDFreList();
				for(var j = 0; j < SL.length; j++)
				{
					if(SL[j].name == UserDevicesInfo[i].Port.toUpperCase())
					{
						hostport = SLFre[j].name;
						break;
					}
				}
			}

			if(STBPort > 0)
			{
				var LanPort = "LAN" + STBPort;
				if(UserDevicesInfo[i].Port.toUpperCase() == LanPort)
				{
					hostport = userdevinfo_language['bbsp_lanstb'];
				}
			}
		}
		
		outputlist = outputlist + appendstr("<tr class=\"tabal_center01 trTabContent\" >");
		if((UserDevicesInfo[i].HostName == '--') && (GetCfgMode().TELMEX == "1")) {
			outputlist = outputlist + appendstr('<td >'+ htmlencode(UserDevicesInfo[i].MacAddr) +'</td>');
		} else {
			outputlist = outputlist + appendstr('<td style="width:10%" title="' + htmlencode(UserDevicesInfo[i].HostName)+ '">'+GetStringContent(htmlencode(UserDevicesInfo[i].HostName), MAX_HOST_TYPE) +'</td>');
		}
		if (IsDevTypeFlag == 1) {
			outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="' + htmlencode(UserDevicesInfo[i].UserDevAlias) + '">' + GetStringContent(htmlencode(UserDevicesInfo[i].UserDevAlias),MAX_DEV_TYPE) + '</td>');
			outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="' + htmlencode(IsSpecifiedDeviceType(UserDevicesInfo[i])) + '">'+GetStringContent(htmlencode(IsSpecifiedDeviceType(UserDevicesInfo[i])), MAX_DEV_TYPE) +'</td>');
		}
		outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="'+ htmlencode(hostport) +'">' + htmlencode(hostport) +'</td>');
		outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="'+htmlencode(UserDevicesInfo[i].DevType)+'">'+GetStringContent(htmlencode(UserDevicesInfo[i].DevType), MAX_DEV_TYPE) +'</td>');
		outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="'+ htmlencode(UserDevicesInfo[i].IpAddr)+'">'+htmlencode(UserDevicesInfo[i].IpAddr) +'</td>');
		outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="'+htmlencode(UserDevicesInfo[i].MacAddr)+'">'+htmlencode(UserDevicesInfo[i].MacAddr)	  +'</td>');
		outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:10%" title="'+userdevinfo_language[UserDevicesInfo[i].DevStatus]+'">'+userdevinfo_language[UserDevicesInfo[i].DevStatus]  +'</td>');		
		outputlist = outputlist + appendstr('<td ' + bottomBorderClass(true) + 'style="width:20%">');
		outputlist = outputlist + appendstr('<button name="btnApply" id='+ i +'  type="button" class="pix_70_130 submit_bbspuser1"  onClick="submit1(this.id);">'+ '&nbsp;');
		if (IsDevTypeFlag == 1)
		{
			outputlist = outputlist + appendstr(userdevinfo_language['bbsp_editinfo']);
		}
		else
		{
			outputlist = outputlist + appendstr(userdevinfo_language['bbsp_detinfo']);
		}
		outputlist = outputlist + appendstr('</button>');
		outputlist = outputlist + appendstr('<br />');	
		var IsBridgeFlag=IsBridgeAddressSource(UserDevicesInfo[i].IpType);	
		if (UserDevicesInfo[i].DevStatus.toUpperCase() != 'ONLINE')
		{
		    outputlist = outputlist + appendstr('<button name="btnApply" id=share_'+ i +'  type="button"  class="pix_70_130 submit_bbspuser1"  onClick="submit4(this.id);">'+ '&nbsp;');
		    outputlist = outputlist + appendstr(userdevinfo_language['bbsp_delete']);
		    outputlist = outputlist + appendstr('</button>');
		    outputlist = outputlist + appendstr('<br />');
		}
		else
		{	
			if(GetCfgMode().PTVDF != "1")
			{
				if(!IsBridgeFlag)
				{
				outputlist = outputlist + appendstr('<button name="btnApply" id=share_'+ i +'  type="button"  class="pix_70_130 submit_bbspuser1"  onClick="submit2(this.id);">'+ '&nbsp;');
				outputlist = outputlist + appendstr(userdevinfo_language['bbsp_comaccess']);
				outputlist = outputlist + appendstr('</button>');
				outputlist = outputlist + appendstr('<br />');
				}
			}
		}
		outputlist = outputlist + appendstr('<button name="btnApply" id=netapp_'+ i +'  type="button" class="pix_70_130 submit_bbspuser1"  onClick="submit3(this.id, '+ IsBridgeFlag +');">'+ '&nbsp;');
		if(!IsBridgeFlag)
		{
		outputlist = outputlist + appendstr(userdevinfo_language['bbsp_netapp']);
		}
		else
		{
				outputlist = outputlist + appendstr(userdevinfo_language['bbsp_macfilt']);
		}
		outputlist = outputlist + appendstr('</button>');
		outputlist = outputlist + appendstr('</td>');
		outputlist = outputlist + appendstr("</tr>");
	}

	$("#devlist").append(outputlist);
}

function showlistcontrol(UserDevicesInfo)
{
	if(UserDevicesInfo.length - 1 == 0)
	{
		shoulist(0 , 0, UserDevicesInfo);
	}
	else if( UserDevicesInfo.length - 1 >= list*parseInt(page,10) )
	{
		shoulist((parseInt(page,10)-1)*list , parseInt(page,10)*list, UserDevicesInfo);
	}
	else
	{
		shoulist((parseInt(page,10)-1)*list , UserDevicesInfo.length - 1, UserDevicesInfo);
	}
}

function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	window.location="userdevinfo.asp?" + parseInt(page,10);
}

function submitprv()
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	page--;
	window.location="userdevinfo.asp?" + parseInt(page,10);
}

function submitnext()
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	page++;
	window.location="userdevinfo.asp?" + parseInt(page,10);
}

function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	
	window.location="userdevinfo.asp?" + parseInt(page,10);
}

function submitjump()
{
	var jumppage = getValue('pagejump');
	if(isInteger(jumppage) != true)
	{
		setText('pagejump', '');
		return;
	}
	if(jumppage < firstpage)
	{
		jumppage = firstpage;
	}
	if(jumppage > lastpage)
	{
		jumppage = lastpage;
	}
	window.location="userdevinfo.asp?" + jumppage;
}

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = userdevinfo_language[b.getAttribute("BindText")];
	}
}

function DisplayUserType()
{
	if (IsDevTypeFlag == 0) 
	{
		setDisplay("alias",0);
		setDisplay("devtpye",0);
	}
}
function LoadFrame()
{
	loadlanguage();
	DisplayUserType();
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("userdevinfotitle", GetDescFormArrayById(userdevinfo_language, "bbsp_mune"), GetDescFormArrayById(userdevinfo_language, "bbsp_userdevinfo_title"), false);
</script> 
<div class="title_spread"></div>

  <table class='width_per100' border="0" align="center" cellpadding="0" cellspacing="1" id='devlist'>
    <tr class="head_title">
	<script>
		document.write("<td class='width_per13" + bottomBorderClass(false) + "' BindText='bbsp_hostname'></td>")
	</script>
		<td class="per_8_15" BindText='bbsp_alias' id="alias"></td>
		<td class="per_8_15" BindText='bbsp_usertype' id="devtpye"></td>
	<script>
		document.write("<td class='per_8_15" + bottomBorderClass(false) + "' BindText='bbsp_devport'></td>" +
				       "<td class='per_8_15" + bottomBorderClass(false) + "' BindText='bbsp_devtype'></td>" +
					   "<td class='width_per16" + bottomBorderClass(false) + "' BindText='bbsp_ip'></td>" +
				       "<td class='width_per16" + bottomBorderClass(false) + "' BindText='bbsp_mac'></td>" +
				       "<td class='per_8_15" + bottomBorderClass(false) + "' BindText='bbsp_devstate'></td>" +
				       "<td class='per_15_20" + bottomBorderClass(false) + "' BindText='bbsp_app'></td>");		
	</script>
    </tr> 
</table> 
  <table class='width_per100' border="0" cellspacing="0" cellpadding="0" > 
	<tr > 
		<td class='width_per40'></td> 
		<td class='title_bright1' > 
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
			<input name="first" id="first" class="submit" type="button" value="<<" onClick="submitfirst();"/> 
			<input name="prv" id="prv"  class="submit" type="button" value="<" onClick="submitprv();"/> 
			<input name="next"  id="next" class="submit" type="button" value=">" onClick="submitnext();"/> 
			<input name="last"  id="last" class="submit" type="button" value=">>" onClick="submitlast();"/> 
		</td>
		<td class='width_per5'></td>
		<td  class='title_bright1'>
		<script>
			document.write(userdevinfo_language['bbsp_goto']);
			if (rosunionGame == "1") {
				$("#first").removeClass("submit").addClass("CancleButtonCss");
				$("#prv").removeClass("submit").addClass("CancleButtonCss");
				$("#next").removeClass("submit").addClass("CancleButtonCss");
				$("#last").removeClass("submit").addClass("CancleButtonCss");
				document.write('<input  type="text" name="pagejump" id="pagejump" size="3" maxlength="3" style="width:20px;" />');
			} else {
				document.write('<input  type="text" name="pagejump" id="pagejump" size="3" maxlength="3" style="width:20px;border:0px;" />');
			}
			document.write(userdevinfo_language['bbsp_page']);
		</script>
		</td>
		<td class='title_bright1'>
			<button name="jumpt"  id="jump" class="submit" type="button" onClick="submitjump();"> <script> document.write(userdevinfo_language['bbsp_jump']); </script></button> 
		</td>
	</tr> 
</table> 
<script>
	if (rosunionGame == "1") {
		$("#jump").removeClass("submit").addClass("CancleButtonCss");
	}
	GetLanUserInfo(function(para1, para2)
	{
		UserDevices = para2;
		DHCPLeaseTimes = para1;
		
		initFirstPage(para2.length - 1);
		if (false == IsValidPage(page))
		{
			page = (0 == UserDevicesnum) ? 0:1;
		}
		$("#prv").after(parseInt(page,10) + "/" + lastpage);

		showlistcontrol(para2);

		if(page == firstpage)
		{
			setDisable('first',1);
			setDisable('prv',1);
		}
		if(page == lastpage)
		{
			setDisable('next',1);
			setDisable('last',1);
		}
	});
</script> 
</body>
</html>
