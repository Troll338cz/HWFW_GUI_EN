<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="/html/bbsp/common/managemode.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/topoinfo.asp"></script>
<script language="javascript" src="/html/bbsp/common/lanmodelist.asp"></script>
<script language="javascript" src="/html/bbsp/common/lanmodelist.asp"></script>
<title>Dmzinterface</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.Select
{
	width:260px;
	direction:ltr;  
}
.TextBox
{
	width:254px;  
}
.Select_2
{
	width:133px;
}
</style>

<script language="JavaScript" type="text/javascript">

var DmzAddFlag = true;
var DmzInfo = new Array();
var Dmzinterface = new Array();
var ProductType = '<%HW_WEB_GetProductType();%>';

var selctIndex = -1;

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
		b.innerHTML = dmzinterface_language[b.getAttribute("BindText")];
	}
}
function LoadFrame()
{
	loadlanguage();
	if (ProductType != '2')
	{	
		setControl(1);
	}
}


function stDmzinterface(domain,Interface, PhyPortName, IPAddress, SubnetMask, Enable)
{
    this.domain = domain;
	this.Interface = Interface;
	this.PhyPortName = PhyPortName;  
	this.IPAddress = IPAddress;
	this.SubnetMask = SubnetMask;	
	this.Enable = Enable;
}      

var Dmzinterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DMZ_Interface ,Interface|PhyPortName|IPAddress|SubnetMask|Enable,stDmzinterface);%>; 


function setControl(index)
{
    var record;	
	selctIndex = index;
	setDisable('btnApply1', 0);
    setDisable('cancelValue', 0);
	
	if (ProductType == '2')
	{
		if (-1 == index)
	    {
			if( Dmzinterface.length > 0 )
			{
				AlertEx(dmzinterface_language['bbsp_full']);
				return ;
			}
			else
			{
				record = new stDmzinterface("","","","","");
				setDisplay('ConfigForm', 1);
				HWSetTableByLiIdList(DmzConfigFormList, record, null);	
				return;
			}		
		}
		else if (index < -1)
		{
			return;
		}
		else 
		{

			record = Dmzinterface[0];
			setDisplay('ConfigForm', 1);
 
			HWSetTableByLiIdList(DmzConfigFormList, record, null);	
			return;	
		
		}	
	}
	else
	{
		record= Dmzinterface[0];
		setDisplay('ConfigForm', 1);
 
		HWSetTableByLiIdList(DmzConfigFormList, record, null);	
		return;		
	}


 
}

     
function filterWan(WanItem)
{
	if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false)))
	{
	
		return false;	
	}
	
	return true;
}


var WanInfo = GetWanListByFilter(filterWan);

var Lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 

var TopoEthNum = '<%GetLanPortNum();%>';

function MakeLANName(domain)
{
	 var InstId = domain.split('.')[4];
	 
	 if(isNaN(InstId) || parseInt(InstId) < 0 || parseInt(InstId) > TopoEthNum) 
	 {
		return "--";
	 }
	 else
	 {
		return ("LAN" + InstId);
	 }
}


function WriteOption()
{
	if (ProductType == '2')
	{
		$("#Interface").append('<option value="empty" id="blanktext1">'+ ""+ '</option>');
		$("#DMZPhyPortName").append('<option value="empty" id="blanktext2">'+ ""+ '</option>');	
	}
	
    for (var i = 0; i < WanInfo.length; i++)
    {

   	   if (WanInfo[i].Mode == 'IP_Routed' && WanInfo[i].IPv4Enable == '1'&& WanInfo[i].ServiceList.indexOf("INTERNET")  != -1 && !IsRadioWanSupported(WanInfo[i]) )
   	   {
			 $("#Interface").append('<option value=' + WanInfo[i].domain + ' id="wan_'
                        + i + '">'
                        + MakeWanName1(WanInfo[i]) + '</option>');
   	   }
    }  
	    
    for (var i = 0; i < parseInt(TopoEthNum); i++)
    {
        if (IsL3Mode(i+1) == "1")
        {
	
 		 $("#DMZPhyPortName").append('<option value=' + Lay3Enables[i].domain + ' id="lan_'
                        + i + '">'
                        + MakeLANName(Lay3Enables[i].domain) + '</option>');

   	   }
 
    }

	
}



function CheckDMZinterface()
{	
	var Interface = getElement('Interface');
	var optionID = Interface.options[Interface.selectedIndex].id;
	var index = 0;
	var result = 0;
    var notestring = '';

	if ( Interface.selectedIndex < 0 )
	{
	    AlertEx(dmzinterface_language['bbsp_creatwan']);
        return false;
	}

	if (getValue("DMZPhyPortName") == "empty")
	{
	  AlertEx(dmzinterface_language['bbsp_nolan']);
	  return false;	
	}

	if (getValue("Interface") == "empty")
	{
	  AlertEx(dmzinterface_language['bbsp_nowan']);
	  return false;	
	}
	
    optionID = Interface.options[Interface.selectedIndex].id;

	index = optionID.split('_')[1];  

	if ( WanInfo[index].IPv4NATEnable < 1 )
	{
	     AlertEx(dmzinterface_language['bbsp_natof'] + MakeWanName1(WanInfo[index]) + dmzinterface_language['bbsp_disable']);
         return false;
	}

    with (getElement('divTableConfigForm')) 
	{

		if (getElement('IPAddress').value == '')
		{
			AlertEx(dmzinterface_language['bbsp_dmzisreq']);
			return false;
		}

		if (isAbcIpAddress(getElement('IPAddress').value) == false ) 
		{
			AlertEx(dmzinterface_language['bbsp_dmzinvalid']);
			return false;
		}

	}

	if (getValue('SubnetMask') == "" )
    {            
    	AlertEx(dmzinterface_language['bbsp_alert_masknill']);	
        return false;
    }
    if ( isValidSubnetMask(getValue('SubnetMask')) == false 
        || getValue('SubnetMask') == '255.255.255.255')
    {            
    	AlertEx(dmzinterface_language['bbsp_alert_mask'] + getValue('SubnetMask') + dmzinterface_language['bbsp_alert_invail']);	
        return false;
    }
	
	
   setDisable('btnApply1', 1);
   setDisable('cancelValue', 1);
   return true;
}



function ApplyConfig()
{

	if(false == CheckDMZinterface())
	{
		return false;
	}


    var SpecDmzCfgParaList = new Array();
    var Parameter = {};
    var url;


    
    SpecDmzCfgParaList.push(new stSpecParaArray("x.Enable",getCheckVal('DMZEnable'), 1),
							new stSpecParaArray("x.PhyPortName",getValue('DMZPhyPortName'), 1),
							new stSpecParaArray("x.Interface",getValue('Interface'), 1),
							new stSpecParaArray("x.IPAddress",getValue('IPAddress'), 1),
						    new stSpecParaArray("x.SubnetMask",getValue('SubnetMask'), 1)); 
    
	Parameter.asynflag = null;
	Parameter.FormLiList = DmzConfigFormList;
	Parameter.SpecParaPair = SpecDmzCfgParaList;
	var tokenvalue = getValue('onttoken');


		url = 'set.cgi?x=InternetGatewayDevice.X_HW_DMZ_Interface'
						   + '&RequestFile=html/bbsp/dmzinterface/dmzinterface.asp'
    
	HWSetAction(null, url, Parameter, tokenvalue);	
    setDisable('btnApply1',1);
	setDisable('cancelValue',1);
    return;	
}

function CancelConfig()
{
	if (ProductType == '2')
	{
	    setDisplay("ConfigForm", 0);
		
		if (selctIndex == -1)
	    {
	        var tableRow = getElement("dmzInst");

	        if (tableRow.rows.length > 2)
	        {
	            tableRow.deleteRow(tableRow.rows.length-1);
				return;
	        }
	    }	
	}
	else
	{
		setControl(1);
		return;	
	}


}
function getWannameDMZInterface( Interface )
{
	for(var i = 0;i < WanInfo.length; i++)
	{
		if(Interface== WanInfo[i].domain)
		{
		return WanInfo[i];
		}
	}
}

function ShowDMZEnableStatus(statusflag)
{
	if (statusflag == "1" || statusflag == 1)
	{
		return dmzinterface_language['bbsp_dmz_enable'];
	}
	else
	{
		return dmzinterface_language['bbsp_dmz_disable'];
	}	
}


</script>
</head>

<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("dmzinterface", GetDescFormArrayById(dmzinterface_language, "bbsp_mune"), GetDescFormArrayById(dmzinterface_language, "bbsp_dmzinterface_title"), false);
</script>
<div class="title_spread"></div>

<script type="text/javascript">
var TableDataInfo = new Array(null);
var DmzinterfaceConfiglistInfo = new Array(new stTableTileInfo("bbsp_enabledmzinterface","align_center width_per25","Enable"),
								 new stTableTileInfo("bbsp_LANPort","align_center width_per15","PhyPortName"),
								 new stTableTileInfo("bbsp_waninterface","align_center width_per15","Interface"),							
								 new stTableTileInfo("bbsp_dmzinterface_ip","align_center width_per20","IPAddress",false,15),
								 new stTableTileInfo("bbsp_dmzinterface_submask","align_center width_per20","SubnetMask"),null);	

	TableDataInfo =  HWcloneObject(Dmzinterface, 1);
							 
	TableDataInfo[0].Enable = ShowDMZEnableStatus(TableDataInfo[0].Enable);
	
	if (TableDataInfo[0].Interface == '')
	{
		TableDataInfo[0].Interface = '--';
	}
	else
	{
		TableDataInfo[0].Interface = MakeWanName1(getWannameDMZInterface(TableDataInfo[0].Interface));	
	}
	
	if(TableDataInfo[0].PhyPortName == '')
	{
		TableDataInfo[0].PhyPortName = '--';
	}
	else
	{
		TableDataInfo[0].PhyPortName = MakeLANName(TableDataInfo[0].PhyPortName);	
	}
	
	if(	TableDataInfo[0].IPAddress == '')
	{
		TableDataInfo[0].IPAddress = '--';
	}
	
	if(	TableDataInfo[0].SubnetMask == '')
	{
		TableDataInfo[0].SubnetMask = '--';
	}
	
	
	HWShowTableListByType(1, "dmzInst", false, 5, TableDataInfo, DmzinterfaceConfiglistInfo, dmzinterface_language, null);

	

					 
</script>

<form id="ConfigForm" >
<div class="list_table_spread"></div>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
<li   id="DMZEnable"         RealType="CheckBox"        DescRef="bbsp_enabledmzinterface"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"         InitValue="Empty"/>
<li   id="DMZPhyPortName"    RealType="DropDownList"  	DescRef="bbsp_LANPort"          	 RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.PhyPortName"    InitValue="Empty" />                                                                   
<li   id="Interface"    	 RealType="DropDownList"  	DescRef="bbsp_waninterface"          RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"    InitValue="Empty" />                                                                   
<li   id="IPAddress"     	 RealType="TextBox"         DescRef="bbsp_dmzinterface_ip"       RemarkRef="Empty"	   ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.IPAddress"     Elementclass="width_254px"  InitValue="Empty" MaxLength="15"/>
<li   id="SubnetMask"      	 RealType="TextBox"         DescRef="bbsp_dmzinterface_submask"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.SubnetMask"    Elementclass="width_254px"  InitValue="Empty" MaxLength="15"/>

</table>
<script>
var TableClass = new stTableClass("table_title width_per25", "table_right", "", "Select");
DmzConfigFormList = HWGetLiIdListByForm("ConfigForm");
HWParsePageControlByID("ConfigForm", TableClass, dmzinterface_language, null);
WriteOption();
</script>
  <table id="ConfigPanelButtons" width="100%" cellpadding="2" cellspacing="0" class="table_button"> 
    <tr> 
      <td class="width_per25"></td> 
      <td class="table_submit">
	    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	  	<button name="btnApply1" id="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="ApplyConfig();"><script>document.write(dmzinterface_language['bbsp_app']);</script></button> 
        <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(dmzinterface_language['bbsp_cancel']);</script></button> 
	</td> 
    </tr> 
  </table> 
</form>
</script> 
</body>
</html>
