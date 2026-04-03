<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>Arp Info</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" type="text/javascript">
var list = 15;
var currentFile='arpinfo.asp';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

function GetMatchDevName(Interface)
{
    var _Interface = "";
    var _Name = "";
    
    if(Interface.charAt(Interface.length - 1) == '.')
    {
        _Interface = Interface.substr(0, Interface.length - 1);
    }
    else
    {
        _Interface = Interface;
    }
    
    if(_Interface.indexOf("WANConnectionDevice") != -1)
    {
        var Wans = GetWanList();
        
        for(var i in Wans)
        {   
            if(_Interface.toUpperCase() == Wans[i].domain.toUpperCase())
            {
                _Name = MakeWanName1(Wans[i]);
                break;
            }
        }
    }
    else if(_Interface.indexOf("LANEthernetInterfaceConfig") != -1)
    {
        _Name = "LAN" + _Interface.charAt(_Interface.length - 1);
    }
    else if(_Interface.indexOf("WLANConfiguration") != -1)
    {
        _Name = GetSSIDNameByDomain(_Interface);
    }
	else if(_Interface.indexOf("PON") != -1)
	{
		_Name = "PON";
	}
    else
    {
        _Name = "";
    }
    
    return (_Name.length == 0)?"--":_Name;
}

function NeighInfo(Domain,IPAddress,MACAddress,Interface,Status)
{
	this.Domain = Domain;
	this.IPAddress = IPAddress.toLowerCase();
	this.MACAddress	= (MACAddress.length == 0)?"--":MACAddress.toLowerCase();
	this.Interface = GetMatchDevName(Interface);
	this.Status = Status.toLowerCase();
}

var NeighInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterARPinfo, InternetGatewayDevice.X_HW_NeighborDiscovery.ARPTable.{i}, IPAddress|MACAddress|Interface|Status,NeighInfo);%>;
var NeighInfoNr = NeighInfo.length - 1;

var firstpage = 1;
if(NeighInfoNr == 0)
{
	firstpage = 0;
}

var lastpage = NeighInfoNr/list;
if(lastpage != parseInt(lastpage,10))
{
	lastpage = parseInt(lastpage,10) + 1;	
}

var page = firstpage;
if( window.location.href.indexOf("?") > 0)
{
  page = parseInt(window.location.href.split("?")[1],10); 
}

if(page < firstpage)
{
	page = firstpage;
}
else if( page > lastpage ) 
{
	page = lastpage;
}

function IsValidPage(pagevalue)
{
	if (true != isInteger(pagevalue))
	{
		return false;
	}
	return true;
}

function shoulist(startlist , endlist)
{
	var reachableStr;
	if( 0 == NeighInfoNr )
	{
		document.write("<tr class=\"tabal_01 align_center\">");
        document.write('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
        document.write('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
        document.write('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
        document.write('<td '+ bottomBorderClass(true) +'>'+'--'+'</td>');
		document.write("</tr>");
		return;
	}

	for(i=startlist;i <= endlist - 1;i++)
	{
        if ((NeighInfo[i].Status == "reachable") && (rosunionGame == "1")) {
            reachableStr=neigh_lang['bbsp_reachable'];
        }
        document.write("<tr class=\"tabal_01 align_center\" >");
        document.write('<td '+ bottomBorderClass(true) +'>'+ htmlencode(NeighInfo[i].IPAddress) +'</td>');
        document.write('<td '+ bottomBorderClass(true) +'>'+ htmlencode(NeighInfo[i].MACAddress) +'</td>');
        document.write('<td '+ bottomBorderClass(true) +'>'+ htmlencode(NeighInfo[i].Interface) +'</td>');
        document.write('<td '+ bottomBorderClass(true) +'>'+ htmlencode(reachableStr) +'</td>');
		document.write("</tr>");
	}
}

function showlistcontrol()
{
	if(NeighInfoNr == 0)
	{
		shoulist(0 , 0);
	}
	else if( NeighInfoNr >= list*parseInt(page,10) )
	{
		shoulist((parseInt(page,10)-1)*list , parseInt(page,10)*list);
	}
	else
	{
		shoulist((parseInt(page,10)-1)*list , NeighInfoNr);
	}
}

function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		return;
	}
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitprv()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page--;
	window.location = currentFile + "?" + parseInt(page,10);
}

function submitnext()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page++;
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		return;
	}
	
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitjump()
{
	var jumppage = getValue('pagejump');
	if((jumppage == '') || (isInteger(jumppage) != true))
	{
		setText('pagejump', '');
		return;
	}
	
	jumppage = parseInt(jumppage, 10);
	if(jumppage < firstpage)
	{
		jumppage = firstpage;
	}
	if(jumppage > lastpage)
	{
		jumppage = lastpage;
	}
	window.location= currentFile + "?" + jumppage;
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
		b.innerHTML = neigh_lang[b.getAttribute("BindText")];
	}
}

function LoadFrame()
{
	loadlanguage();
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("arpinfotitle", GetDescFormArrayById(neigh_lang, "bbsp_mune"), GetDescFormArrayById(neigh_lang, "neigh_tips"), false);
</script> 
<div class="title_spread"></div>

  <table class='tabal_bg' border="0" align="center" cellpadding="0" cellspacing="1" id='devlist' width="100%">
    <tr class="head_title">
	<script>
		document.write('<td class="per_18_21' + bottomBorderClass(false) +'" style="width:40%" BindText="neigh_ip"></td>' +
                       '<td class="per_18_21' + bottomBorderClass(false) +'" style="width:20%" BindText="neigh_mac"></td>' +
                       '<td class="per_18_21' + bottomBorderClass(false) +'" style="width:20%" BindText="neigh_interface"></td>' +
                       '<td class="per_18_21' + bottomBorderClass(false) +'" style="width:20%" BindText="neigh_status"></td>');        
	</script>
  </tr>

<script>
	showlistcontrol();
</script>

</table> 
  <table class='width_per100' border="0" cellspacing="0" cellpadding="0" > 
	<tr > 
		<td class='width_per40'></td> 
		<td class='title_bright1' >
		 	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
			<input name="first" id="first" class="PageNext jumppagejumplastbutton_wh_px" type="button" value="<<" onClick="submitfirst();"/> 
			<input name="prv" id="prv"  class="PageNext jumppagejumpbutton_wh_px" type="button" value="<" onClick="submitprv();"/> 
				<script>
					if (false == IsValidPage(page))
					{
						page = (0 == NeighInfoNr) ? 0:1;
					}
					document.write(parseInt(page,10) + "/" + lastpage);
				</script>
			<input name="next"  id="next" class="PageNext jumppagejumpbutton_wh_px" type="button" value=">" onClick="submitnext();"/> 
			<input name="last"  id="last" class="PageNext jumppagejumplastbutton_wh_px" type="button" value=">>" onClick="submitlast();"/> 
		</td>
		<td class='width_per5'></td>
		<td  class='title_bright1'>
			<script> document.write(neigh_lang['bbsp_goto']); </script> 
				<input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
			<script> document.write(neigh_lang['bbsp_page']); </script>
		</td>
		<td class='title_bright1'>
			<button name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="submitjump();"> <script> document.write(neigh_lang['bbsp_jump']); </script></button> 
		</td>
	</tr> 
</table> 
<script> 
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
</script> 
</body>
</html>
