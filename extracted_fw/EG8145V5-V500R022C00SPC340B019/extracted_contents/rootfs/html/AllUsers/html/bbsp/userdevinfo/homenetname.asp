<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>User Device Information</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, userdevinfo_language);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/lanuserinfo.asp"></script>
<script language="JavaScript" type="text/javascript">
var list = 10;
var MAX_DEV_TYPE=16;
var MAX_HOST_TYPE=16;


var firstpage = 1;
var page = firstpage;
var lastpage = 0;
var DHCPLeaseTimes;
var UserDevices;
var fttrMainFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var ZqFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';


function NameList(Domain,MACAddress,Name)
{
	this.Domain 	= Domain;
	this.MACAddress	    = MACAddress;
	this.Name	= Name;
}
var HomeNetNameList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_WANSrcWhiteList, InternetGatewayDevice.X_HW_HOMENET_NAME.hosts.{i},MACAddress|Name, NameList);%>;
if (ZqFlag == 1 && fttrMainFlag != 1) {
	HomeNetNameList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_WANSrcWhiteList, InternetGatewayDevice.X_HW_HOMENET_NAME.hosts.{i},MACAddress|DhcpName, NameList);%>;
}

function FindNameItemByDevInfo(UserDevinfoItem)
{
	for (n=0; HomeNetNameList.length > 1 && n < HomeNetNameList.length -1; n++)
	{	
		if(HomeNetNameList[n].MACAddress.toUpperCase() == UserDevinfoItem.MacAddr.toUpperCase())
		{
			return n;
		}
	
	}
	return -1;
}

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

function IsDhcpOverdue(ipaddr, macaddr)
{
	var DhcpLeaseNum = DHCPLeaseTimes.length - 1;
	for (var i = 0; i < DhcpLeaseNum; i++)
	{
		if ((ipaddr == DHCPLeaseTimes[i].IPAddress) && (macaddr == DHCPLeaseTimes[i].MACAddress))
		{
			if (DHCPLeaseTimes[i].LeaseTimeRemaining > 0)
			{
				return false;
			}
		}
	}
	
	return true;
}

function appendstr(str)
{
	return str;
}

function getUserDeviceListId(tableID,colID)
{
	var UserDeviceListId = "Domain_table_" + tableID + "_" + colID ;
	return UserDeviceListId;
}

function shoulist(startlist , endlist, UserDevicesInfo)
{
	var outputlist = "";
	var id = 0;
	var tableID = "";
	if( 0 == UserDevicesInfo.length - 1 )
	{
		tableID = 2;
		outputlist = outputlist + appendstr("<tr class=\"tabal_center01 DevTableListTd\">");
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,1)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,2)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,3)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,4)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,5)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr("</tr>");

		$("#devlist").append(outputlist);
		return;
	}

	for(i=startlist;i <= endlist - 1;i++)   
	{
		id = i + 1;
		tableID = i + 2;
		outputlist = outputlist + appendstr("<tr class=\"tabal_center01 trTabContent DevTableListTd\" >");
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:10%" id=' + getUserDeviceListId(tableID,1) + '>'+id+'</td>');
		if(('--' == UserDevicesInfo[i].HostName) && ("1" == GetCfgMode().TELMEX))
		{
		    outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" id=' + getUserDeviceListId(tableID,2) + '>'+ htmlencode(UserDevicesInfo[i].MacAddr) +'</td>');
		}
		else
		{
		    outputlist = outputlist + appendstr('<td  class=\"DevTableListTd\" style="width:15%" id=' + getUserDeviceListId(tableID,2) + '>'+htmlencode(UserDevicesInfo[i].HostName.substr(0,MAX_HOST_TYPE)) +'</td>');
		}
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:15%" id=' + getUserDeviceListId(tableID,3) + '>'+htmlencode(UserDevicesInfo[i].MacAddr)	  +'</td>');
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:15%" id=' + getUserDeviceListId(tableID,4) + '>'+htmlencode(UserDevicesInfo[i].IpAddr)	  +'</td>');
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:20%" id=' + getUserDeviceListId(tableID,5) + '>'+htmlencode(UserDevicesInfo[i].DevType.substr(0,MAX_DEV_TYPE)) +'</td>');
		outputlist = outputlist + appendstr("</tr>");
	}

	$("#devlist").append(outputlist);
}

function shoulistCMCC(startlist , endlist, DHCPInfo)
{
	var outputlist = "";
	var id = 0;
	var tableID = "";
	if( 0 == DHCPInfo.length - 1 )
	{
		tableID = 2;
		outputlist = outputlist + appendstr("<tr class=\"tabal_center01 DevTableListTd\">");
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,1)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,2)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,3)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,4)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,5)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr('<td id='+getUserDeviceListId(tableID,6)+'>'+'--'+'</td>');
		outputlist = outputlist + appendstr("</tr>");

		$("#devlist").append(outputlist);
		return;
	}

	
	
	for(i=startlist;i <= endlist - 1;i++)   
	{
		id = i + 1;
		tableID = i + 2;
		outputlist = outputlist + appendstr("<tr class=\"tabal_center01 trTabContent DevTableListTd\" >");
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:5%" id=' + getUserDeviceListId(tableID,1) + '>'+id+'</td>');
	    
		DHCPInfo[i].name = (''==DHCPInfo[i].name)?'--':DHCPInfo[i].name;
		outputlist = outputlist + appendstr('<td  class=\"DevTableListTd\" style="width:20%" id=' + getUserDeviceListId(tableID,2) + '>'+htmlencode(DHCPInfo[i].name.substr(0,MAX_HOST_TYPE)) +'</td>');
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:20%" id=' + getUserDeviceListId(tableID,3) + '>'+htmlencode(DHCPInfo[i].mac)	  +'</td>');
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:20%" id=' + getUserDeviceListId(tableID,4) + '>'+htmlencode(DHCPInfo[i].ip)	  +'</td>');
		DHCPInfo[i].devtype = (''==DHCPInfo[i].devtype)?'--':DHCPInfo[i].devtype;
		outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:20%" id=' + getUserDeviceListId(tableID,5) + '>'+htmlencode(DHCPInfo[i].devtype.substr(0,MAX_DEV_TYPE)) +'</td>');

		if (0 == DHCPInfo[i].remaintime)
		{
			outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:15%" id=' + getUserDeviceListId(tableID,6) + '>'+'--' +'</td>');
		}
		else
		{
			outputlist = outputlist + appendstr('<td class=\"DevTableListTd\" style="width:15%" id=' + getUserDeviceListId(tableID,6) + '>'+htmlencode(DHCPInfo[i].remaintime) +'</td>');
		}
		
		outputlist = outputlist + appendstr("</tr>");
	}

	$("#devlist").append(outputlist);
}

function showlistcontrol(DHCPInfo,UserDevicesInfo)
{
	if(IsCmcc_rmsMode())
	{
		if(DHCPInfo.length - 1 == 0)
		{
			shoulistCMCC(0 , 0, DHCPInfo);
		}
		else if( DHCPInfo.length - 1 >= list*parseInt(page,10) )
		{
			shoulistCMCC((parseInt(page,10)-1)*list , parseInt(page,10)*list, DHCPInfo);
		}
		else
		{ 
			shoulistCMCC((parseInt(page,10)-1)*list , DHCPInfo.length - 1, DHCPInfo);
		}
	}
	else
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
}

function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	window.location="homenetname.asp?" + parseInt(page,10);
}

function submitprv()
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	page--;
	window.location="homenetname.asp?" + parseInt(page,10);
}

function submitnext()
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	page++;
	window.location="homenetname.asp?" + parseInt(page,10);
}

function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	
	window.location="homenetname.asp?" + parseInt(page,10);
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
	window.location="homenetname.asp?" + jumppage;
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

function LoadFrame()
{
	loadlanguage();
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
  <table class='width_100p DevTableListTd' border="1" align="center" cellpadding="0" cellspacing="0" id='devlist' style="border-collapse:collapse;">
    <tr class="Devhead_title DevTableListTd">
	<td style="width:5%" class='DevTableListTd' id="Domain_table_1_1" BindText='bbsp_number'></td> 
    <td style="width:20%" class='DevTableListTd' id="Domain_table_1_2" BindText='bbsp_hostname1'></td> 
	<td style="width:20%" class="DevTableListTd" id="Domain_table_1_3" BindText='bbsp_mac'></td> 
	<td style="width:20%" class="DevTableListTd" id="Domain_table_1_4" BindText='bbsp_ip'></td> 
    <td style="width:20%" class='DevTableListTd' id="Domain_table_1_5" BindText='bbsp_devtype'></td> 
	
	<script> 	
	if(IsCmcc_rmsMode())
	{
		document.write("<td style=\"width:15%\" class=\"DevTableListTd\" id=\"Domain_table_1_6\" BindText='bbsp_remainleasedcmcc'></td>");
	}
	</script> 
    </tr> 
</table> 
<div class="button_spread"></div>
  <table class='width_100p' border="0" cellspacing="0" cellpadding="0" > 
	<tr > 
		<td class='width_per40'></td> 
		<td class='title_bright1' > 
			<input name="first" id="first" class="submit" type="button" value="<<" onClick="submitfirst();"/> 
			<input name="prv" id="prv"  class="submit" type="button" value="<" onClick="submitprv();"/> 
			<input name="next"  id="next" class="submit" type="button" value=">" onClick="submitnext();"/> 
			<input name="last"  id="last" class="submit" type="button" value=">>" onClick="submitlast();"/> 
		</td>
		<td class='width_5p'></td>
		<td  class='title_bright1'>
			<script> document.write(userdevinfo_language['bbsp_goto']); </script> 
				<input  type="text" name="pagejump" id="pagejump" size="3" maxlength="3" style="width:20px;" />
			<script> document.write(userdevinfo_language['bbsp_page']); </script>
		</td>
		<td class='title_bright1'>
			<button name="jumpt"  id="jump" class="submit" type="button" onClick="submitjump();"> <script> document.write(userdevinfo_language['bbsp_jump']); </script></button> 
		</td>
	</tr> 
</table> 
<script> 
    GetLanUserInfo(function(para1, para2)
	{
		UserDevices = para2;
		DHCPLeaseTimes = para1;
		
		if(IsCmcc_rmsMode())
		{
			initFirstPage(para1.length - 1);	
		}
		else
		{
			initFirstPage(para2.length - 1);		
		}

		if (false == IsValidPage(page))
		{
			page = (0 == UserDevicesnum) ? 0:1;
		}
		$("#prv").after(parseInt(page,10) + "/" + lastpage);
	   
		   
		for (i=0; UserDevices.length > 0 && i < UserDevices.length -1; i++)
		{
			var Name_i = FindNameItemByDevInfo(UserDevices[i]);
	
			if(Name_i > -1)
			{
				UserDevices[i].HostName = HomeNetNameList[Name_i].Name;
			}	
		}


		showlistcontrol(para1,para2);

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
