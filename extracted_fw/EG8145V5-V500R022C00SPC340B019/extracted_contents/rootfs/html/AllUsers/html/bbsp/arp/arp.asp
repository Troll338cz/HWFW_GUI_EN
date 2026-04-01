<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<title>Arp config</title>
<style type="text/css">
.tabnoline td
{
   border:0px;
}

 .firstCol
{
   width:24%;
   text-align:right ;
}

.secondCol
{
   width:24%;
}

.thirdCol
{
   width:20%;
   text-align:right ;
}

.alignledge
{
   width:3%;
}

.inputclass
{
   width:123px;
}

.inputclass_L
{
   width:254px;
}

</style>
<script language="JavaScript" type="text/javascript">
var selctIndex = -1;
var AddFlag = true;
var TableName = "arpInst";

var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsTELECOMFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_TELECOM);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var sysUserType = '0';
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';

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
		b.innerHTML = arp_language[b.getAttribute("BindText")];
	}
}

function stArp(domain,ipAddress,macAddress,Interface)
{
    this.domain = domain;
    this.ipAddress = ipAddress;
	this.macAddress = macAddress;
	this.Interface = Interface;
}

var Arps = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Arp.{i},IPAddress|MACAddress|Interface,stArp);%>;
var Arp = new Array();
for (var i = 0; i < Arps.length-1; i++)
{
    if ((curUserType != sysUserType) && (1 == IsPTVDFFlag) 
		&& (Arps[i].Interface.toString().toUpperCase() != "BR0") && (Arps[i].Interface != "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1"))
	{
		continue;	
	}
	
	Arp.push(Arps[i]);
}

function filterWan(WanItem)
{
    if (viettelflag ==1)
    {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
        {
            return false;
        }        
    }
	if(WanItem.Mode.indexOf("Route") < 0)
    {
        return false;
    }

	if(WanItem.EncapMode.toUpperCase() == "PPPOE")
	{
		return false;
	}

	return true;
}

var WanInfo =GetWanListByFilter(filterWan);

function stHost(Domain, IPInterfaceIPAddress, IPInterfaceSubnetMask)
{
    this.Domain = Domain;
	this.IPInterfaceIPAddress = IPInterfaceIPAddress;
	this.IPInterfaceSubnetMask = IPInterfaceSubnetMask;
}

var host = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress|IPInterfaceSubnetMask,stHost);%>;

function LoadFrame()
{ 
   if (Arp.length > 0)
   {
	   selectLine(TableName + '_record_0');
       setDisplay('ConfigForm',1);
   }	
   else
   {   
	   selectLine('record_no');
       setDisplay('ConfigForm',0);
   }

   loadlanguage();
   
   if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
   {  		 
        setDisable('Newbutton', 1);
        setDisable('DeleteButton', 1);
		setDisable('btnApply_ex', 1);
        setDisable('cancel', 1);
		setDisable('ipAddr', 1);
        setDisable('macAddr', 1);
   }
}


function AddSubmitParam(SubmitForm,type)
{							
	SubmitForm.addParameter('x.IPAddress',getValue('ipAddr'));	
	SubmitForm.addParameter('x.MACAddress',getValue('macAddr'));
	SubmitForm.addParameter('x.Interface',getValue('Intflist'));
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	if( selctIndex == -1 )
	{
		 SubmitForm.setAction('add.cgi?x=InternetGatewayDevice.X_HW_Arp'
							+ '&RequestFile=html/bbsp/arp/arp.asp');
	}
	else
	{
	     SubmitForm.setAction('set.cgi?x=' + Arp[selctIndex].domain
							+ '&RequestFile=html/bbsp/arp/arp.asp');
	}
    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
}

function MakeIntfPath(path)
{	
	if(path.toString().toUpperCase() == "BR0")
	{
		return "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1";	
	}
	for (var i = 0; i < WanInfo.length; i++)
    {
		var wanname1 = WanInfo[i].NewName;
		if(path.toString().toUpperCase() == wanname1.toString().toUpperCase())
		{
			return WanInfo[i].domain;
		}
    }
	return path;
}
function setCtlDisplay(record)
{
    if (record == null)
    {
    	setText('ipAddr','');
    	setText('macAddr','');
	    setSelect('Intflist', '');
    }
    else
    {
        setText('ipAddr',record.ipAddress);
    	setText('macAddr',record.macAddress);
		setSelect('Intflist', MakeIntfPath(record.Interface));
    }
}

var g_Index = -1;
function setControl(index)
{
	var record;
	selctIndex = index;
	
    if (index == -1)
	{
	    if(Arps.length - 1 >= 32)
	    {
	        setDisplay('ConfigForm', 0);
		    AlertEx(arp_language['bbsp_arpfull']);
		    return;
	    }
	    record = null;
        AddFlag = true;
        setDisplay('ConfigForm', 1);
        setCtlDisplay(record);
	}
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
	else
	{
	    record = Arp[index];
        AddFlag = false;
        setDisplay('ConfigForm', 1);
        setCtlDisplay(record);
	}

    g_Index = index;
    setDisable('btnApply_ex',0);
    setDisable('cancel',0);
   if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
   {  		 
        setDisable('Newbutton', 1);
        setDisable('DeleteButton', 1);
		setDisable('btnApply_ex', 1);
        setDisable('cancel', 1);
		setDisable('ipAddr', 1);
        setDisable('macAddr', 1);
   }
}

function arpInstselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{ 
    if (Arp.length == 0)
	{
	    AlertEx(arp_language['bbsp_noarp']);
	    return;
	}
	
	if (selctIndex == -1)
	{
	    AlertEx(arp_language['bbsp_savearp']);
	    return;
	}
    var rml = document.getElementsByName(TableName + 'rml');
	var SubmitForm = new webSubmitForm();
	var Count = 0;
	for (var i = 0; i < rml.length; i++)
	{
		if (rml[i].checked != true)
		{
			continue;
		}
		
		Count++;
		SubmitForm.addParameter(rml[i].value,'');
	}
    if (Count <= 0)
    {
        AlertEx(arp_language['bbsp_selectarp']);
        return ;
    }
        
	if (ConfirmEx(arp_language['bbsp_confirm1']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
	    return;
    }
    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/arp/arp.asp');   
	SubmitForm.submit();
}  

function PS_CheckReserveIP(Operation, Ip, MAC)
{
    var conflict = false;   
    
    $.ajax({
        type  : "POST",
        async : false,
        cache : false,
        data  : "act=" + Operation+ "&ip=" + Ip + "&mac=" + MAC + "&x.X_HW_Token="+getValue('onttoken'),
        url   : "pdtipconflictcheck",
        success : function(data) {
            conflict = true;
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            conflict = false;
        },
        complete: function (XHR, TS) { 
            XHR = null;
      }         
    }); 
    
    return conflict;
}

function MakeIntfName(path)
{
	if((path.toString().toUpperCase() == "BR0")||(path == "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1"))
	{
		return "LAN";	
	}

	for (var i = 0; i < WanInfo.length; i++)
    {
		var wanname1 = WanInfo[i].NewName;
		var wanname2 = WanInfo[i].domain;
		if((path.toString().toUpperCase() == wanname1.toString().toUpperCase())||(path == wanname2))
		{
			return MakeWanName(WanInfo[i]);
		}
    }

	return path;
}

function CheckBr0IpAddr(IpAddress)
{
    var right = 0;
	
    for (var i = 0; i < host.length-1; i++)
    {
        if (IpAddress == host[i].IPInterfaceIPAddress)
        {
            AlertEx(arp_language['bbsp_ipdifhost']);
            return false;
        }
        
        if (false == isSameSubNet(host[i].IPInterfaceIPAddress,host[i].IPInterfaceSubnetMask,IpAddress,host[i].IPInterfaceSubnetMask))
        {
            right = 0;
            continue;
        }
        else
        {
            right = 1;
            break;
        }
    }

	if(right == 0)
	{
		AlertEx(arp_language['bbsp_samesubnet']);
		return false;
	}

	return true;
}

function CheckWanIpAddr(IpAddress,path)
{
	var right = 0;

	for (var i = 0; i < WanInfo.length; i++)
    {
        if ( WanInfo[i].IPv4IPAddress != '0.0.0.0' && WanInfo[i].IPv4SubnetMask != '0.0.0.0'
            && WanInfo[i].IPv4IPAddress != '' && WanInfo[i].IPv4SubnetMask != '' )
        {
            if (IpAddress == WanInfo[i].IPv4IPAddress)
            {
                AlertEx(arp_language['bbsp_ipdifwan']);
                return false;
            }

			if(path == WanInfo[i].domain)
			{
				if (true == isSameSubNet(WanInfo[i].IPv4IPAddress,WanInfo[i].IPv4SubnetMask,IpAddress,WanInfo[i].IPv4SubnetMask))
				{
                	right = 1;
                	break;
				}
			}
        }
    }

	if (right != 1)
    {
        AlertEx(arp_language['bbsp_samesubnet']);
        return false;
	}
	
	return true;
}

function CheckForm()
{	
    var IpAddress;
	var MacAddress;
	var Interface;
	var ipver = 0;
    var right = 0;

	IpAddress = getValue('ipAddr');
	MacAddress = getValue('macAddr');
	Interface = getValue('Intflist');
	
	if (IpAddress == "") 
	{
	    AlertEx(arp_language['bbsp_ipisreq']);
		return false;
	}    

	if (MacAddress == "")
	{
	    AlertEx(arp_language['bbsp_macisreq']);
		return false;
	}

	if(CheckIpv6Parameter(IpAddress) == true)
	{
		ipver = 2;
	}
	else if((isAbcIpAddress(IpAddress) == true)&&(isDeIpAddress(IpAddress) == false)
		&&(isBroadcastIpAddress(IpAddress) == false)&&(isLoopIpAddress(IpAddress) == false))
	{
		ipver = 1;
	}
	else
	{
		AlertEx(arp_language['bbsp_ipaddr']+ IpAddress + arp_language['bbsp_invalid']);
		return false;
	}
    
    for (var i = 0; i < Arp.length; i++)
    {
        if (selctIndex != i)
        {
            if (Arp[i].ipAddress == IpAddress)
            {
                AlertEx(arp_language['bbsp_iprepeat']);
                return false;
            }
        }
        else
        {
            continue;
        }
    }

	if(ipver == 1)
	{
		if(Interface == "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1")
		{
			if( CheckBr0IpAddr(IpAddress) == false)
			{
				return false;
			}
		}
		else if(Interface != '')
		{
			if( CheckWanIpAddr(IpAddress, Interface) == false)
			{
				return false;		
			}
		}
		else
		{
			for (var i = 0; i < host.length-1; i++)
		    {
		        if (IpAddress == host[i].IPInterfaceIPAddress)
		        {
		            AlertEx(arp_language['bbsp_ipdifhost']);
		            return false;
		        }
		        
		        if (false == isSameSubNet(host[i].IPInterfaceIPAddress,host[i].IPInterfaceSubnetMask,IpAddress,host[i].IPInterfaceSubnetMask))
		        {
		            right = 0;
		            continue;
		        }
		        else
		        {
		            right = 1;
		            break;
		        }
		    }

		    if (right != 1)
		    {
		        for (var i = 0; i < WanInfo.length; i++)
		        {
		            if ( WanInfo[i].IPv4IPAddress != '0.0.0.0' && WanInfo[i].IPv4SubnetMask != '0.0.0.0'
		                && WanInfo[i].IPv4IPAddress != '' && WanInfo[i].IPv4SubnetMask != '' )
		            {
		                if (IpAddress == WanInfo[i].IPv4IPAddress)
		                {
		                    AlertEx(arp_language['bbsp_ipdifwan']);
		                    return false;
		                }
		                
		                if (false == isSameSubNet(WanInfo[i].IPv4IPAddress,WanInfo[i].IPv4SubnetMask,IpAddress,WanInfo[i].IPv4SubnetMask))
		                {
		                    right = 0;
		                    continue;
		                }
		                else
		                {
		                    right = 1;
		                    break;
		                }
		            }
		        }
		    }

		    if (right != 1)
		    {
		        AlertEx(arp_language['bbsp_samesubnet']);
		        return false;
		    }
		}
	}
   
   	if(("1" == "<%HW_WEB_GetFeatureSupport(HW_FT_DHCP_CHECK_STATIC_ARP);%>") 
		&& (true == PS_CheckReserveIP("checkArp", IpAddress, MacAddress)))
	{            
		AlertEx(arp_language['bbsp_ipconflict']);
		return false;
	}
	
   	return true;
}

function Cancel()
{
    setDisplay("ConfigForm", 0);
	
	if (AddFlag == true)
    {
        var tableRow = getElement(TableName);
        
        if (tableRow.rows.length == 1)
        {
            selectLine('record_no');
        }
        else if (tableRow.rows.length == 2)
        {
        } 
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + '_record_0');
        }
    }
    else
    {
        setText('ipAddr',Arp[selctIndex].ipAddress);
    	setText('macAddr',Arp[selctIndex].macAddress);
    }
    setDisable('btnApply_ex',0);
    setDisable('cancel',0);
}

function InitTableData()
{
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	var i = 0;
	
	if (Arp.length == 0)
	{
		TableDataInfo[Listlen] = new stArp();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].ipAddress = '--';
		TableDataInfo[Listlen].macAddress = '--';
	    TableDataInfo[Listlen].Interface = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, ArpConfiglistInfo, arp_language, null);
    	return;
	}
	else
	{
		for (i = 0;i < Arp.length; i++)
		{     
			TableDataInfo[Listlen] = new stArp();
			TableDataInfo[Listlen].domain = Arp[i].domain;
			TableDataInfo[Listlen].ipAddress = Arp[i].ipAddress;
			TableDataInfo[Listlen].macAddress = Arp[i].macAddress;
			TableDataInfo[Listlen].Interface = MakeIntfName(Arp[i].Interface);
			Listlen++;
		}
		TableDataInfo.push(null);
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, ArpConfiglistInfo, arp_language, null);
		for (i = 0;i < Arp.length; i++)
		{
			if((1 == IsTELECOMFlag) &&(curUserType != sysUserType))
			{
				var id = TableName + "_rml" + i;
				setDisable(id, 1);
			}
		}
	}
}

function InitIntfList()
{
	var Option = document.createElement("Option");
	var OptionBr0 = document.createElement("Option");

	if (!((curUserType != sysUserType) && (1 == IsPTVDFFlag)))
	{
		Option.value = "";
		Option.innerText = "";
		Option.text = "";
		getElById("Intflist").appendChild(Option);
	}
	
	OptionBr0.value = "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1";
	OptionBr0.innerText = "LAN";
	OptionBr0.text = "LAN";
	getElById("Intflist").appendChild(OptionBr0);

	if (!((curUserType != sysUserType) && (1 == IsPTVDFFlag)))
    {
		InitWanNameListControl2("Intflist", filterWan);
	}    

}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<div id="ConfigForm1" action="">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("arptitle", GetDescFormArrayById(arp_language, "bbsp_mune"), GetDescFormArrayById(arp_language, "bbsp_arp_title"), false);
</script> 
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
	var ArpConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),
										new stTableTileInfo("bbsp_ip","","ipAddress"),
										new stTableTileInfo("bbsp_mac","","macAddress"),
										new stTableTileInfo("bbsp_intf","","Interface"),
										null);
	InitTableData();
</script>
	
<form id='ConfigForm' style="display:none;">
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="ipAddr"     RealType="TextBox"          DescRef="bbsp_ipmh"        RemarkRef="Empty"                ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.IPAddress"   Elementclass="width_254px"  InitValue="Empty"/>
		<li   id="macAddr"    RealType="TextBox"          DescRef="bbsp_macmh"       RemarkRef="bbsp_macaddrform"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.MACAddress"  Elementclass="width_254px"  InitValue="Empty"/>
	    <li   id="Intflist"   RealType="DropDownList"     DescRef="bbsp_intfmh"      RemarkRef="Empty"                ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"   Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		var ArpConfigFormList = new Array();
		ArpConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
		var formid_hide_id = null;
		HWParsePageControlByID("ConfigForm", TableClass, arp_language, formid_hide_id);
        InitIntfList();
	</script>
     <table   cellpadding="0" cellspacing="0" width="100%" class="table_button"> 
       <tr>
	      <td class="width_per25"></td>
            <td class="table_submit">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit();"><script>document.write(arp_language['bbsp_app']);</script></button>
                <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="Cancel();"><script>document.write(arp_language['bbsp_cancel']);</script></button>
            </td>
          
        </tr>
    </table>
</form> 
<div class="func_spread"></div>
</div>
</body>
</html>

