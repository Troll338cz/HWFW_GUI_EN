<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="Javascript" src="../common/portfwdprohibit.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="javascript" src="../common/ipmappinglist.asp"></script>

<script>
	function IpMappingItemClass(domain, Enable, Priority,Interface,StartIP,EndIP,SnatSrcIP,SnatSrcEndIp,Mode)
	{
		this.domain = domain;
		this.Enable = Enable;
		this.Priority = Priority;
		this.Interface =  Interface;
		this.StartIP =  StartIP; 
		this.EndIP =  EndIP;
		this.SnatSrcIP =  SnatSrcIP;
		this.SnatSrcEndIp =  SnatSrcEndIp;
		this.Mode = Mode;
	}

	var IpMappingList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_NAT.IPMapping.{i},Enable|Priority|Interface|StartIP|EndIP|SnatSrcIP|SnatSrcEndIp|Mode,IpMappingItemClass);%>;
		
	function GetIpMappingList()
	{
		return IpMappingList;
	}
    var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';
    var selctIndex = -1;
    var currentFile='ipmapping.asp';
    var CurrentMode;
    var TwoModeIpmapping = ('1' == '<%HW_WEB_GetFeatureSupport(FT_IPMAPPING_TWOMODE);%>') ? true : false;
    var ProductType = '<%HW_WEB_GetProductType();%>';
	var IsDTEDATA = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
    var isDslTedata = ((ProductType === '2') && (IsDTEDATA === '1')) ? '1' : '0';

	function SetEditMode()
	{
		CurrentMode = "EDIT";    
	}
	function SetAddMode()
	{
		CurrentMode = "ADD";    
	}

	function IsEditMode()
	{
		return CurrentMode=="EDIT" ? true : false;
	}
	function IsAddMode()
	{
		return CurrentMode=="ADD" ? true : false;
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
			b.innerHTML = ipmapping_language[b.getAttribute("BindText")];
		}
	}
	
    function GetIpMappingData()
    {
	    var CurrentDomain = (GetIpMappingList()[selctIndex] != null)?GetIpMappingList()[selctIndex].domain:"";
        return new IpMappingItemClass(CurrentDomain,"1", getValue("MappingPriority"),getSelectVal("MappingWan"), getValue("InnerIPstart"),getValue("InnerIPend"),getValue("PublicIP"),getValue("PublicIPEnd"),getSelectVal("Mode"));
    }
	
    function OnPageLoad()
    {
		loadlanguage();
		setDisable('Mode', 0);
		if(true == TwoModeIpmapping)
		{
			setDisplay('PublicIPRow', 0);
			setDisplay('PublicIPEndRow', 0);
			removeAllOption('Mode');
			setDisable('Mode', 1);		
			addOption('Mode','NAT','user-defined',ipmapping_language['bbsp_mode7']);							
			addOption('Mode','no-NAT','no-NAT',ipmapping_language['bbsp_mode6']);	
		}
        return true;
    }

    function endIpShouldNotEmpty(IpMappingItem) {
      if (
         (IpMappingItem.Mode === 'many-to-many-overload')
         || (IpMappingItem.Mode === 'many-to-many-no-overload')
         || (IpMappingItem.Mode === 'many-to-many')
         || (IpMappingItem.Mode === 'many one-to-one')
         ) {
          return true;
        }
        if ((IsDTEDATA === '1') && (IpMappingItem.Mode === 'many-to-one')) {
          return true;
        }
      return false;
    }

    function CheckParameter(IpMappingItem)
    {   
		var IpMappingList = GetIpMappingList();
        
        if (IsDTEDATA == 1) {
            if (IpMappingItem.Priority == '') {
                AlertEx(ipmapping_language['bbsp_priority_empty']);
                return false;
            }
        }

		if (IpMappingItem.Priority != '')
		{
		    if (false == CheckNumber(IpMappingItem.Priority, 1, 16))
			{
				AlertEx(ipmapping_language['bbsp_Priority_invalid']);
				return false;
			}
		}
		
		if (IpMappingItem.Interface == "")
        {
			AlertEx(ipmapping_language['bbsp_alert_wan']);
            return false;
        }
		
		if (IpMappingItem.StartIP == '')
		{
			AlertEx(ipmapping_language['bbsp_startip']);
            return false;
		}
		if (isValidIpAddress(IpMappingItem.StartIP) == false
		   || isAbcIpAddress(IpMappingItem.StartIP) == false 
           || isDeIpAddress(IpMappingItem.StartIP) == true 
           || isBroadcastIpAddress(IpMappingItem.StartIP) == true 
           || isLoopIpAddress(IpMappingItem.StartIP) == true ) 
           {              
                AlertEx(ipmapping_language['bbsp_startip_invalid']);
                return false;
           }
           
           if ((IpMappingItem.EndIP === '') && endIpShouldNotEmpty(IpMappingItem)) {
             AlertEx(ipmapping_language['bbsp_endip_empty']);
             return false;
            }

        if (IpMappingItem.EndIP != '')
        {
		    if (isValidIpAddress(IpMappingItem.EndIP) == false
			   || isAbcIpAddress(IpMappingItem.EndIP) == false 
			   || isDeIpAddress(IpMappingItem.EndIP) == true 
			   || isBroadcastIpAddress(IpMappingItem.EndIP) == true 
			   || isLoopIpAddress(IpMappingItem.EndIP) == true ) 
           {              
                AlertEx(ipmapping_language['bbsp_endip_invalid']);
                return false;
           }
		   if (IpMappingItem.Mode != "one-to-one")
		   {
		       if (IpAddress2DecNum(IpMappingItem.StartIP) > IpAddress2DecNum(IpMappingItem.EndIP))
		       {
				    AlertEx(ipmapping_language['bbsp_startbigend']);
				    return false;     	
		       }	
		   }
		}
		
		if (IpMappingItem.SnatSrcIP != '')
		{
		    if ((isValidIpAddress(IpMappingItem.SnatSrcIP) == false)
		   &&(isAbcIpAddress(IpMappingItem.SnatSrcIP) == false 
           || isDeIpAddress(IpMappingItem.SnatSrcIP) == true 
           || isBroadcastIpAddress(IpMappingItem.SnatSrcIP) == true 
           || isLoopIpAddress(IpMappingItem.SnatSrcIP) == true )) 
           {              
                AlertEx(ipmapping_language['bbsp_publicip_invalid']);
                return false;
           }
		}

		if ((IpMappingItem.SnatSrcIP == '') && (IpMappingItem.Mode != "user-defined") && (IpMappingItem.Mode != "no-NAT"))
		{
			AlertEx(ipmapping_language['bbsp_SnatSrcnone']);
			return false;

		}
		
		if ((IpMappingItem.SnatSrcEndIp == '') &&
			((IpMappingItem.Mode == "many-to-many-overload") || (IpMappingItem.Mode == "many-to-many-no-overload") ||
			(IpMappingItem.Mode == "many-to-many") || (IpMappingItem.Mode == "many one-to-one"))) {
			  AlertEx(ipmapping_language['bbsp_SnatEndnone']);
			  return false;

		}
		
		if (IpMappingItem.SnatSrcEndIp != '')
		{
		   if ((IpMappingItem.SnatSrcIP == '')&&(CurrentMode == "ADD"))
		   {
				AlertEx(ipmapping_language['bbsp_noSnatSrcIP']);
				return false;     	
		   }
		   
			if (isValidIpAddress(IpMappingItem.SnatSrcEndIp) == false
			   || isAbcIpAddress(IpMappingItem.SnatSrcEndIp) == false 
			   || isDeIpAddress(IpMappingItem.SnatSrcEndIp) == true 
			   || isBroadcastIpAddress(IpMappingItem.SnatSrcEndIp) == true 
			   || isLoopIpAddress(IpMappingItem.SnatSrcEndIp) == true ) 
		   {              
				AlertEx(ipmapping_language['bbsp_SnatSrcEndIpinvalid']);
				return false;
		   }
		   
		   if ((IpMappingItem.Mode != "one-to-one")
				&& (IpMappingItem.Mode != "many-to-one") 
				&& (IpMappingItem.Mode != "user-defined")
				&& (IpMappingItem.Mode != "no-NAT"))
		   {
			   if (IpAddress2DecNum(IpMappingItem.SnatSrcIP) > IpAddress2DecNum(IpMappingItem.SnatSrcEndIp))
			   {
					AlertEx(ipmapping_language['bbsp_startbigendSnatSrc']);
					return false;     	
			   }
			   if((IpAddress2DecNum(IpMappingItem.SnatSrcEndIp) - IpAddress2DecNum(IpMappingItem.SnatSrcIP)) > 199)
			   {
					AlertEx(ipmapping_language['bbsp_snatipnumfull']);
					return false;
			   }
		   }
		}
				
		if ((IpMappingItem.Mode == "many-to-many-no-overload") || (IpMappingItem.Mode == "many one-to-one")) 
		{
			var SnatSrcIpSegNum = IpAddress2DecNum(IpMappingItem.SnatSrcEndIp) - IpAddress2DecNum(IpMappingItem.SnatSrcIP);
			var InnerIpSegNum = IpAddress2DecNum(IpMappingItem.EndIP) - IpAddress2DecNum(IpMappingItem.StartIP);
			if(SnatSrcIpSegNum != InnerIpSegNum)
			{
				AlertEx(ipmapping_language['bbsp_IpSegNumNotEqual']);
				return false; 
			}
		}
		
		for (i = 0; i < IpMappingList.length - 1; i++)
        {
			if((selctIndex != i)
				&&(IpMappingList[i].Interface == IpMappingItem.Interface)
				&& (IpMappingList[i].StartIP == IpMappingItem.StartIP)
				&& (IpMappingList[i].EndIP == IpMappingItem.EndIP)
				&& (IpMappingList[i].SnatSrcIP == IpMappingItem.SnatSrcIP)
				&& (IpMappingList[i].Mode == IpMappingItem.Mode))
			{
			    
				if ((IpMappingItem.Mode == "many-to-many-overload") ||
				    (IpMappingItem.Mode == "many-to-many-no-overload") ||
					(IpMappingItem.Mode == "many-to-many") ||
					(IpMappingItem.Mode == "many one-to-one"))
			    {
				    if (IpMappingList[i].SnatSrcEndIp == IpMappingItem.SnatSrcEndIp)
					{
					    AlertEx(ipmapping_language['bbsp_ruleexist']);
			            return false; 
					}
				}
				else
				{
				    AlertEx(ipmapping_language['bbsp_ruleexist']);
			        return false; 
				}
			}
			if ((IpMappingList[i].Priority == IpMappingItem.Priority)
			    &&(IpMappingItem.Priority != '')
				&&(selctIndex != i))
			{
			    AlertEx(ipmapping_language['bbsp_ruleexist_priority']);
			    return false; 
			}
		}
		
	    return true;
    }
    

    function OnDeleteButtonClick(id) 
    {
        return OnRemoveButtonClick(id);
    }
	
    function CtrlRedAsteriskDisplay(mode)
	{
		switch(mode)
		{
			case "many-to-many-no-overload":
			case "many-to-many-overload":
			case "many-to-many":
			case "many one-to-one":
					setDisplay("InnerIPendRequire", 1);
					setDisplay("PublicIPRequire", 1);
					setDisplay("PublicIPEndRequire", 1);
					break;
			case "one-to-one":
			case "many-to-one":
              setDisplay("InnerIPendRequire", IsDTEDATA === '1' ? 1 : 0);
              setDisplay("PublicIPRequire", 1);
              setDisplay("PublicIPEndRequire", 0);
              break;
			case "user-defined":
			case "no-NAT":
					setDisplay("InnerIPendRequire", 0);
					setDisplay("PublicIPRequire", 0);
					setDisplay("PublicIPEndRequire", 0);
					break;
			default:
					break;
					
		}
	}

    function dtedataSelectInternetVDWan() {
        var mappingWanDropDownList = getElById("MappingWan");
        for (var i = 0; i < mappingWanDropDownList.length; i++) {
            var curOption = mappingWanDropDownList.options[i];
            var optionText = curOption.text;
            if ((optionText.indexOf("VDSL") >= 0) &&
                (optionText.indexOf("INTERNET") >= 0)) {
                curOption.selected = true;
                break;
            }
        }
    }
	
	function setControl(Index)
    {
        selctIndex = Index;
		var WanList = GetWanList();
		var Flag = 1;
		var IpMappingItem = GetIpMappingList();

		setDisable("ButtonApply", 0);
		setDisable("ButtonCancel", 0);			
		
		if (Index < -1)
        {
            return;
        }
        if (Index == -1)
        {
            if (isDslTedata === '1') {
                dtedataSelectInternetVDWan();
            }
            SetAddMode();
			setDisable("MappingWan", 0);
			setDisable("InnerIPend", 0);
			setDisable("PublicIPEnd", 1);
			CtrlRedAsteriskDisplay("user-defined");
			
            if (GetIpMappingList().length > 16)
            {
                AlertEx(ipmapping_language['bbsp_alert_recfull']);
                OnCancelButtonClick();
                return false;
            }
            return OnAddButtonClick();  
        }
        else
        {   
		    SetEditMode();
			for (var i = 0;i < WanList.length;i++)
			{
			    if (domainTowanname(WanList[i].domain) == GetIpMappingList()[Index].Interface)
				{
				    setDisable("MappingWan", 1);
					Flag = 0;
					break;
				}
			}
			setDisplay("TableConfigInfo", 1);			
			if (1 == Flag)
			{
			    setDisable("MappingWan", 0);
			}
			
			var EditRecord = new IpMappingItemClass();
			EditRecord = GetIpMappingList()[Index];
			if (EditRecord.Priority == 0)
			{
			    EditRecord.Priority = '';
			}
			var Mode = EditRecord.Mode; 
			
			CtrlRedAsteriskDisplay(Mode);
			
			if (Mode == "one-to-one")
			{			
				setDisable("InnerIPend", 1);
				setDisable("PublicIPEnd", 1);
			}
			else if(Mode == "many-to-one" || Mode == "user-defined")
			{
				setDisable("InnerIPend", 0);
				setDisable("PublicIPEnd", 1);
			}
			else
			{			
				setDisable("InnerIPend", 0);
				setDisable("PublicIPEnd", 0);
			}
			
			if  ((true == TwoModeIpmapping) && (Mode != "no-NAT"))
			{
				setDisable("ButtonApply", 1);
				setDisable("ButtonCancel", 1);			
			}
			
			HWSetTableByLiIdList(IpmappingConfigFormList, EditRecord, null);
			return;
        }
		
    }
    
    function OnAddButtonClick()
    {
		setDisplay("TableConfigInfo", "1");
		var AddRecord ;
		if(true == TwoModeIpmapping)
		{
			AddRecord = new IpMappingItemClass("","","","","","","","","no-NAT");		
		}
		else
		{
			AddRecord = new IpMappingItemClass("","","","","","","","","user-defined");		
		}
		HWSetTableByLiIdList(IpmappingConfigFormList, AddRecord, null);
		return; 		
    }
     
	function IpMappingConfigListselectRemoveCnt(obj) 
	{
		return;
	} 
	
    function OnRemoveButtonClick(TableID)
    {        
        var CheckBoxList = document.getElementsByName("IpMappingConfigListrml");
        var Form = new webSubmitForm();
        var Count = 0;
      
        for (var i = 0; i < CheckBoxList.length; i++)
        {
            if (CheckBoxList[i].checked != true)
            {
                continue;
            }
            
            Count++;
            Form.addParameter(CheckBoxList[i].value,'');
        }
        if (Count <= 0)
        {
            return false;
        }
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_NAT.IPMapping' + '&RequestFile=html/bbsp/ipmapping/ipmapping.asp');
        Form.submit();
        setDisable('ButtonApply',1);
    	setDisable('ButtonCancel',1);
        return;        
    }

	
	function OnApplyButtonClick()
	{
		var IpMappingItem = GetIpMappingData();
		
		var Enable = IpMappingItem.Enable;
		var Priority = IpMappingItem.Priority;
		var Mode = IpMappingItem.Mode;
		var Interface = IpMappingItem.Interface;
		var StartIP = IpMappingItem.StartIP;
		var EndIP = IpMappingItem.EndIP;
		var SnatSrcIP = IpMappingItem.SnatSrcIP;
		var SnatSrcEndIp = IpMappingItem.SnatSrcEndIp;
		var SnatSrcIPFlag = 1;
		var SnatSrcEndIpFlag = 1;

		if (TwoModeIpmapping)
		{
			SnatSrcIPFlag = 2;
			SnatSrcEndIpFlag = 2;
		}
		else
		{
			if (CheckParameter(IpMappingItem) == false)
			{
				return false;
			}
		}		

        if (Mode == "one-to-one")
		{
		    EndIP = StartIP;
		}
		if((Mode == "one-to-one") || (Mode == "many-to-one") || (Mode == "user-defined"))
		{
			SnatSrcEndIp = SnatSrcIP;
		}
		

		
		var SpecIpMappingCfgParaList = new Array(new stSpecParaArray("x.Enable",Enable, 1),
												 new stSpecParaArray("x.Priority",Priority, 1),
												 new stSpecParaArray("x.Mode",Mode, 1),
												 new stSpecParaArray("x.Interface",Interface, 1),
												 new stSpecParaArray("x.StartIP",StartIP, 1),
												 new stSpecParaArray("x.EndIP",EndIP, 1),
												 new stSpecParaArray("x.SnatSrcIP",SnatSrcIP, SnatSrcIPFlag),
												 new stSpecParaArray("x.SnatSrcEndIp",SnatSrcEndIp, SnatSrcEndIpFlag));

		var Parameter = {};
		Parameter.asynflag = null;
		Parameter.FormLiList = IpmappingConfigFormList;
		Parameter.SpecParaPair = SpecIpMappingCfgParaList;
		var url = "";
		if (IsAddMode() == true)
        {
            url = 'add.cgi?x=InternetGatewayDevice.X_HW_NAT.IPMapping' + '&RequestFile=html/bbsp/ipmapping/ipmapping.asp';
        }
        else
        {
            url = 'set.cgi?x='+IpMappingItem.domain + '&RequestFile=html/bbsp/ipmapping/ipmapping.asp';
        }
		
		var tokenvalue = getValue('onttoken');
		HWSetAction(null, url, Parameter, tokenvalue);
		
		setDisable('ButtonApply',1);
    	setDisable('ButtonCancel',1);
        return;		
	}
	
	function OnCancelButtonClick()
    {
		var CancelRecord = new IpMappingItemClass("", "", "", "", "","","","","user-defined");
		HWSetTableByLiIdList(IpmappingConfigFormList, CancelRecord, OnCancelButtonClickSpec);
		return;
	}
    function OnCancelButtonClickSpec()
    {
        if (GetIpMappingList().length-1 > 0 && IsAddMode())
        {
			var tableRow = getElementById("IpMappingConfigList");
            tableRow.deleteRow(tableRow.rows.length-1);
        }
        setDisplay("TableConfigInfo", "0");
        return;
    }
	
	function ISPChangeMode()
	{
	    setDisable("InnerIPend", 0);
		with (document.forms[0])
		{			    
			InnerIPstart.value = '';
			InnerIPend.value = '';
			PublicIP.value = '';
			PublicIPEnd.value = '';
			
			CtrlRedAsteriskDisplay(Mode.value);
			
			if (Mode.value == "one-to-one")
			{
			    setDisable("InnerIPend", 1);
				setDisable("PublicIPEnd", 1);
			}
			else if(Mode.value == "many-to-one" || Mode.value == "user-defined")
			{
				setDisable("PublicIPEnd", 1);
			}
			else
			{
				setDisable("PublicIPEnd", 0);
			}
		}
	}
		
	var TableClass = new stTableClass("width_per20", "width_per80", "", "Select");
	
</script>

</head>
<body  class="mainbody" onload="OnPageLoad();">
<script language="JavaScript" type="text/javascript">
	
	if (true == TwoModeIpmapping)
	{
		HWCreatePageHeadInfo("ipmappingtitle", GetDescFormArrayById(ipmapping_language, "bbsp_ipmapping"), GetDescFormArrayById(ipmapping_language, "bbsp_title_prompt_no_nat"), false);		
	}
	else
	{
		HWCreatePageHeadInfo("ipmappingtitle", GetDescFormArrayById(ipmapping_language, "bbsp_ipmapping"), GetDescFormArrayById(ipmapping_language, "bbsp_title_prompt"), false);
	}
	
</script>
<div class="title_spread"></div>
<script type="text/javascript">
var IpMappingConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),
                                    new stTableTileInfo("bbsp_priority","align_center width_per10","Priority"),
									new stTableTileInfo("bbsp_mode","align_center width_per20","Mode"),
									new stTableTileInfo("bbsp_wanname2","align_center width_per15","Interface"),
									new stTableTileInfo("bbsp_innerip","align_center width_per25","StartIPEndIP",false,"",0),
									new stTableTileInfo("bbsp_public","align_center width_per25","SnatSrcIPEndIP",TwoModeIpmapping,"",0),
									null);

var ColumnNum = 6;
var ShowButtonFlag = true;
var IpmappingConfigFormList = new Array();
var UserInfo = GetIpMappingList();
var IpMappingList = GetIpMappingList();
var TableDataInfo =  HWcloneObject(UserInfo, 1);
var SnatSrc = '--';

for (var i = 0; i < TableDataInfo.length - 1; i++)
{
	TableDataInfo[i].Interface = GetWanFullName(domainTowanname(IpMappingList[i].Interface));
    if (IpMappingList[i].StartIP != '')
	{
	    if (IpMappingList[i].EndIP != '')
		{
		    TableDataInfo[i].StartIPEndIP = IpMappingList[i].StartIP +'--' + '<br/>'+IpMappingList[i].EndIP;
		}
		else
		{
		    TableDataInfo[i].StartIPEndIP = IpMappingList[i].StartIP;
		}
	}
	else
	{
		TableDataInfo[i].StartIPEndIP = '--';
	}
	
	if (IpMappingList[i].SnatSrcIP != '')
	{
	    if (IpMappingList[i].SnatSrcEndIp != '')
		{
		    TableDataInfo[i].SnatSrcIPEndIP = IpMappingList[i].SnatSrcIP +'--' + '<br/>' +IpMappingList[i].SnatSrcEndIp;
		}
		else
		{
		    TableDataInfo[i].SnatSrcIPEndIP = IpMappingList[i].SnatSrcIP;
		}
	}
	if (IpMappingList[i].SnatSrcIP == '')
	{
		TableDataInfo[i].SnatSrcIPEndIP = '--';
	}
	if (IpMappingList[i].Priority == 0)
	{
	    TableDataInfo[i].Priority = '--';
	}	
	if ((TwoModeIpmapping) && ('user-defined' == IpMappingList[i].Mode))
	{
		TableDataInfo[i].Mode = ipmapping_language['bbsp_mode7'];
	}
}

HWShowTableListByType(1, "IpMappingConfigList", ShowButtonFlag, ColumnNum, TableDataInfo, IpMappingConfiglistInfo, ipmapping_language, null);
</script>

<form id="TableConfigInfo" style="display:none">
<div class="list_table_spread"></div>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
<li   id="MappingPriority"           RealType="TextBox"            DescRef="bbsp_td_priority"                 RemarkRef="bbsp_bt_Priority"                   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Priority"   InitValue="Empty" MaxLength="2"/>
<script>
if (IsDTEDATA == 1) {
    document.write('<li id="Mode" RealType="DropDownList" DescRef="bbsp_td_mode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Mode"InitValue="[{TextRef:\'bbsp_mode1\',Value:\'user-defined\'},{TextRef:\'bbsp_mode2\',Value:\'one-to-one\'},{TextRef:\'bbsp_mode3\',Value:\'many-to-one\'},{TextRef:\'bbsp_mode8\',Value:\'many-to-many\'},{TextRef:\'bbsp_mode9\',Value:\'many one-to-one\'},{TextRef:\'bbsp_mode6\',Value:\'no-NAT\'}]" ClickFuncApp="onchange=ISPChangeMode"/>');
} else {
    document.write('<li id="Mode" RealType="DropDownList" DescRef="bbsp_td_mode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Mode"InitValue="[{TextRef:\'bbsp_mode1\',Value:\'user-defined\'},{TextRef:\'bbsp_mode2\',Value:\'one-to-one\'},{TextRef:\'bbsp_mode3\',Value:\'many-to-one\'},{TextRef:\'bbsp_mode4\',Value:\'many-to-many-overload\'},{TextRef:\'bbsp_mode5\',Value:\'many-to-many-no-overload\'},{TextRef:\'bbsp_mode6\',Value:\'no-NAT\'}]" ClickFuncApp="onchange=ISPChangeMode"/>');
}
</script>
<li   id="MappingWan"                RealType="DropDownList"       DescRef="bbsp_td_wanname2"                 RemarkRef="Empty"                          ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Interface"  InitValue="Empty"/>
<li   id="InnerIPstart"              RealType="TextBox"            DescRef="bbsp_td_starip"                  RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.StartIP"    InitValue="Empty" MaxLength="15"/>
<li   id="InnerIPend"                RealType="TextBox"            DescRef="bbsp_td_endip"                    RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.EndIP"      InitValue="Empty" MaxLength="15"/>
<li   id="PublicIP"                  RealType="TextBox"            DescRef="bbsp_td_publicip"                 RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.SnatSrcIP"  InitValue="Empty" MaxLength="15"/>
<li   id="PublicIPEnd"               RealType="TextBox"            DescRef="bbsp_td_publicipend"                 RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.SnatSrcEndIp"  InitValue="Empty" MaxLength="15"/>
</table>
<script>
IpmappingConfigFormList = HWGetLiIdListByForm("TableConfigInfo");
HWParsePageControlByID("TableConfigInfo", TableClass, ipmapping_language, null);
getElById("MappingPriority").title = ipmapping_language['bbsp_Priority_note'];
</script>

<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per20'>
        </td>
        <td class="table_submit pad_left20p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(ipmapping_language['bbsp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(ipmapping_language['bbsp_cancel']);</script></button>
        </td>
    </tr>
</table>

</form>
<div style="height:10px;"></div>

<script>
    function IsRouteWan(Wan) {
        if (curCfgModeWord.toUpperCase() == "TRIPLETAP" || curCfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || curCfgModeWord.toUpperCase() == "TRIPLETAP6" || curCfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
            if (Wan.domain.indexOf(8) > -1) {
                return false;
            }
        }
        if ((Wan.Mode == "IP_Routed") &&
            ((Wan.ProtocolType =="IPv4") || (Wan.ProtocolType =="IPv4/IPv6")) &&
            ((Wan.ServiceList !="TR069") && (Wan.ServiceList !="VOIP") && (Wan.ServiceList !="TR069_VOIP"))) {
            return true;
        } 
        return false;
    }
    InitWanNameListControl2("MappingWan", IsRouteWan);
</script>

</body>
</html>