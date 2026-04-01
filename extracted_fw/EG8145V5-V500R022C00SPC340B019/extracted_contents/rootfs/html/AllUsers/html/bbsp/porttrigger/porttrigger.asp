<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wandns.asp"></script>
<script language="Javascript" src="../common/portfwdprohibit.asp"></script>
<title>Port Trigger</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.TextBox
{
	width:254px;  
}
.Select
{
	width:260px;  
}
.SelectWanName{
	width: 260px;
	direction:ltr;
}
</style>
<script language="JavaScript" type="text/javascript">
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var CfgModeWord = '<%HW_WEB_GetCfgMode();%>'; 
var TableName = "PTConfigList";
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var IsTDE2Mode = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsTalkTalkMode = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var isMegacablePWD = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
var isMapFlag = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_MAP);%>';
var mapEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Enable);%>';
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
		setObjNoEncodeInnerHtmlValue(b, porttrigger_language[b.getAttribute("BindText")]);
	}
}
   
function stPortTrigger(domain,Enable,TPort,TPortEnd,TProto,OPort,OPortEnd,OProto,name)
{
    this.domain = domain;   
    this.Enable = Enable;
    this.TPort = TPort;
    this.TPortEnd = TPortEnd;
    this.TProto = TProto;
    this.OPort = OPort;
    this.OPortEnd = OPortEnd;
    this.OProto = OProto;
    this.name = name;
}

function filterWan(WanItem)
{
    if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))) {
        return false;
    }
    if (CfgModeWord.toUpperCase() == "TRIPLETAP" || CfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || CfgModeWord.toUpperCase() == "TRIPLETAP6" || CfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
        if (WanItem.domain.indexOf(8) > -1) {
            return false;
        }
    }
    if (("1" == GetCfgMode().DT_HUNGARY) && (curUserType != sysUserType)) {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) {
            return true;
        } else {
            return false;
        }
    }

    return true;
}

function setAllDisable()
{
	setDisable('Newbutton',1);
	setDisable('DeleteButton',1);
	setDisable('btnApply_ex',1);
	setDisable('cancelValue',1);
	
	setDisable('Enable',1);
	setDisable('WANName',1);
	setDisable('TriggerProtocol',1);
	setDisable('OpenProtocol',1);
	setDisable('TriggerPort',1);
	setDisable('TriggerPortEnd',1);
	setDisable('OpenPort',1);
	setDisable('OpenPortEnd',1);
}

var wans = GetWanListByFilter(filterWan);

var WanIPPortTrigger = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_PortTrigger.{i},Enable|TriggerPort|TriggerPortEnd|TriggerProtocol|OpenPort|OpenPortEnd|OpenProtocol,stPortTrigger);%>;
var WanPPPPortTrigger = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_PortTrigger.{i},Enable|TriggerPort|TriggerPortEnd|TriggerProtocol|OpenPort|OpenPortEnd|OpenProtocol,stPortTrigger);%>;
var curUserType='<%HW_WEB_GetUserType();%>';
var IsTELECOMFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_TELECOM);%>';

function FindWanInfoByPortTrigger(portTriggerItem)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < wans.length; k++ )
	{
		wandomain_len = wans[k].domain.length;
		temp_domain = portTriggerItem.domain.substr(0, wandomain_len);
		
		if (temp_domain == wans[k].domain)
		{
			return wans[k];
		}
	}
	return null;
}

var PortTrigger = new Array();
var Idx = 0;
for (i = 0; i < WanIPPortTrigger.length-1; i++)
{
	var tmpWan = FindWanInfoByPortTrigger(WanIPPortTrigger[i]); 
	
	if (tmpWan == null)
    {
        continue;
    }
	
	if (tmpWan.ServiceList != 'TR069'
       && tmpWan.ServiceList != 'VOIP'
       && tmpWan.ServiceList != 'TR069_VOIP'
       && tmpWan.Mode == 'IP_Routed')
	{
   		PortTrigger[Idx] = WanIPPortTrigger[i];
   		PortTrigger[Idx].name = MakePortTriggerName(WanIPPortTrigger[i].domain);
		Idx ++;
	}
}
for (j = 0; j < WanPPPPortTrigger.length-1; j++,i++)
{
    var tmpWan = FindWanInfoByPortTrigger(WanPPPPortTrigger[j]); 
	
	if (tmpWan == null)
    {
        continue;
    }	
	
	if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.ServiceList != 'VOIP'
		&& tmpWan.ServiceList != 'TR069_VOIP'
		&& tmpWan.Mode == 'IP_Routed')
	{
   		PortTrigger[Idx] = WanPPPPortTrigger[j];
   		PortTrigger[Idx].name = MakePortTriggerName(WanPPPPortTrigger[j].domain);
		Idx ++;   
	}
}

if (isSupportHybrid == 1) {
    var BondingPortTrigger = '';
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/bbsp/bonding/bondingporttriggerinfo.asp",
        success : function(data) {
            BondingPortTrigger = dealDataWithFun(data);
        }
    });

    for (k = 0; k < BondingPortTrigger.length-1; k++) {
        PortTrigger[Idx] = BondingPortTrigger[k];
        PortTrigger[Idx].name = 'Bonding';
        Idx ++; 
    }
}

function addInterface()
{
    for(i=0;i<wans.length;i++)
    {
        addOption('WANName',wans[i].name,wans[i].domain,MakeWanName1(wans[i]));
    }
}

function getInterfaceWanList()
{
    var HU='<%HW_WEB_GetFeatureSupport(BBSP_FT_HU);%>';
    
    var WANNamelist = getElementById("WANName");
	WANNamelist.options.length = 0;
    for (i = 0; i < wans.length; i++)
    {
        if (wans[i].ServiceList != 'TR069'
            && wans[i].ServiceList != 'VOIP'
            && wans[i].ServiceList != 'TR069_VOIP'
            && wans[i].Mode == 'IP_Routed'
            && wans[i].IPv4Enable == '1')
        {
            if((HU==1) && (curUserType != '0') && ((wans[i].ServiceList == 'IPTV') || (wans[i].ServiceList == 'OTHER')))
            {
                 continue;
            }
            else
            {
				 $("#WANName").append('<option value=' + wans[i].domain 
                           + ' id="wan_' + i + '">'
                           + MakeWanName1(wans[i]) + '</option>');	
            }
        }
    }
}

function getInterfaceInternetWanList()
{
    var WANNamelist = getElementById("WANName");
	WANNamelist.options.length = 0;
    for (i = 0; i < wans.length; i++)
    {
        if (wans[i].Mode == 'IP_Routed' && wans[i].IPv4Enable == '1')
        {
            if (wans[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") == -1
                || IsRadioWanSupported(wans[i]))
            {
                 continue;
            }
            else
            {
                  $("#WANName").append('<option value=' + wans[i].domain 
                           + ' id="wan_' + i + '">'
                           + MakeWanName1(wans[i]) + '</option>');
            }
        }                  
    }
}

function RefreshWanInterface(isAdd)
{
    if (((curUserType != sysUserType) && (IsPTVDFFlag == 1))
         || (SingtelMode == '1'))
    {
        if(isAdd==true)
        {
			 getInterfaceInternetWanList();
        }
        else
        {
			getInterfaceWanList();
        }
    }
}


function MakePortTriggerName(PortTriggerDomain)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < wans.length; k++ )
	{
		wandomain_len = wans[k].domain.length;
		temp_domain = PortTriggerDomain.substr(0, wandomain_len);
		if (temp_domain == wans[k].domain)
		{
			return MakeWanName1(wans[k]);
		}
	}
}

function LoadFrame()
{
    if (PortTrigger.length > 0)
    {
 	    selectLine(TableName + '_record_0');  
        setDisplay('TableConfigInfo',1);
    }	
    else
    {	
 	    selectLine('record_no');     
        setDisplay('TableConfigInfo',0);
    }
	if((1 == IsTELECOMFlag) && (curUserType != sysUserType))
	{
		setAllDisable();
	}

	loadlanguage();
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
}

function UnsafeName_modify(compareChar)
{
   var unsafeString = "\"<>%\\^[]`\+\$\,=#&:;*/{}\t";
        
   if ( unsafeString.indexOf(compareChar) == -1 
        && compareChar.charCodeAt(0) >= 32
        && compareChar.charCodeAt(0) < 123 )
      return false; 
   else
      return true;
}  

function ValidName(name) 
{
   var i = 0;   
   
   for ( i = 0; i < name.length; i++ ) {
      if ( UnsafeName_modify(name.charAt(i)) == true )
         return false;
   }

   return true;
}

var TriggerPortSum = 0;
var OpenPortSum = 0;
function CountPortSum()
{
    TriggerPortSum = 0;
    OpenPortSum = 0;

    if (selctIndex == -1)
    {
        for (var k = 0; k < PortTrigger.length; k++)
        {   
            TriggerPortSum += (parseInt(PortTrigger[k].TPortEnd,10) - parseInt(PortTrigger[k].TPort,10) + 1);
            OpenPortSum += (parseInt(PortTrigger[k].OPortEnd,10) - parseInt(PortTrigger[k].OPort,10) + 1);
        }
    }
    else
    {
        for (var k = 0; k < PortTrigger.length; k++)
        {   
            if (selctIndex != k)
            {
                TriggerPortSum += (parseInt(PortTrigger[k].TPortEnd,10) - parseInt(PortTrigger[k].TPort,10) + 1);
                OpenPortSum += (parseInt(PortTrigger[k].OPortEnd,10) - parseInt(PortTrigger[k].OPort,10) + 1);
            }
        }
    }
}

function findSelectWanIdx(selectObj)
{
	var index = 0;
	var idx = -1;
	index = parseInt(selectObj.selectedIndex,10);
	for (var i = 0; i < wans.length; i++)
	{
		if (wans[i].domain == selectObj.options[index].value)
		{
			idx = i;
			break;
		}
	}
	return idx;
}

function CheckForm()
{
    var i = 0;

    {
         var selectObj = getElement('WANName');
         if ( selectObj.selectedIndex < 0 )
         {
             AlertEx(porttrigger_language['bbsp_creatwan']);
             return false;
         }
		 
		 if(1 == IsTDE2Mode)
		 {
		 	var idx = findSelectWanIdx(selectObj);         
		 	if ((-1 != idx) && ( wans[idx].IPv4NATEnable < 1 ))
		 	{
				AlertEx(MakeWanName1(wans[idx]) + porttrigger_language['bbsp_notnat']);
			 	setDisable('btnApply', 0);
			 	return false;
		 	}
		}
   }
    with (getElement('TableConfigInfo'))
    {      
		var i=0;
		var selectObj = getElement('WANName');
        var wanname = '';
        if ((isSupportHybrid == 1) && (selectObj.value == 'Bonding')) {
            wanname = 'Bonding';
        } else {
            var idx = findSelectWanIdx(selectObj);
            wanname=MakeWanName1(wans[idx]);
        }
	
        for(i=0;i<PortTrigger.length;i++)
		{
			if(wanname!=PortTrigger[i].name||i==selctIndex)
			{
				continue;
			}
			if(parseInt(getValue('TriggerPortEnd'),10)<=parseInt(PortTrigger[i].TPortEnd,10)&&parseInt(getValue('TriggerPortEnd'),10)>=parseInt(PortTrigger[i].TPort,10))
			{
				if(getValue('TriggerProtocol').indexOf(PortTrigger[i].TProto)!=-1||PortTrigger[i].TProto.indexOf(getValue('TriggerProtocol'))!=-1)
				{
					AlertEx(porttrigger_language['bbsp_triggerportrepeat']);
                	return false;
				}
			}
			if(parseInt(getValue('TriggerPort'),10)<=parseInt(PortTrigger[i].TPortEnd,10)&&parseInt(getValue('TriggerPort'),10)>=parseInt(PortTrigger[i].TPort,10))
			{
				if(getValue('TriggerProtocol').indexOf(PortTrigger[i].TProto)!=-1||PortTrigger[i].TProto.indexOf(getValue('TriggerProtocol'))!=-1)
				{
					AlertEx(porttrigger_language['bbsp_triggerportrepeat']);
                	return false;
				}
			}
			if(parseInt(getValue('TriggerPort'),10)<=parseInt(PortTrigger[i].TPort,10)&&parseInt(getValue('TriggerPortEnd'),10)>=parseInt(PortTrigger[i].TPortEnd,10))
			{
				if(getValue('TriggerProtocol').indexOf(PortTrigger[i].TProto)!=-1||PortTrigger[i].TProto.indexOf(getValue('TriggerProtocol'))!=-1)
				{
					AlertEx(porttrigger_language['bbsp_triggerportrepeat']);
                	return false;
				}
			}
			if(parseInt(getValue('OpenPortEnd'),10)<=parseInt(PortTrigger[i].OPortEnd,10)&&parseInt(getValue('OpenPortEnd'),10)>=parseInt(PortTrigger[i].OPort,10))
			{
				if(getValue('OpenProtocol').indexOf(PortTrigger[i].TProto)!=-1||PortTrigger[i].OProto.indexOf(getValue('OpenProtocol'))!=-1)
				{
					AlertEx(porttrigger_language['bbsp_openendportrepeat']);
                	return false;
				}
			}
			if(parseInt(getValue('OpenPort'),10)<=parseInt(PortTrigger[i].OPortEnd,10)&&parseInt(getValue('OpenPort'),10)>=parseInt(PortTrigger[i].OPort,10))
			{
				if(getValue('OpenProtocol').indexOf(PortTrigger[i].OProto)!=-1||PortTrigger[i].OProto.indexOf(getValue('OpenProtocol'))!=-1)
				{
					AlertEx(porttrigger_language['bbsp_openendportrepeat']);
                	return false;
				}
			}
			if(parseInt(getValue('OpenPort'),10)<=parseInt(PortTrigger[i].OPort,10)&&parseInt(getValue('OpenPortEnd'),10)>=parseInt(PortTrigger[i].OPortEnd,10))
			{
				if(getValue('OpenProtocol').indexOf(PortTrigger[i].OProto)!=-1||PortTrigger[i].OProto.indexOf(getValue('OpenProtocol'))!=-1)
				{
					AlertEx(porttrigger_language['bbsp_openendportrepeat']);
                	return false;
				}

			}
		}
		if (getElement('TriggerPort').value == "" || isValidPort(getElement('TriggerPort').value) == false
		|| (getValue('TriggerPort') != "" && getValue('TriggerPort').charAt(0) == '0'))
        {
            AlertEx(porttrigger_language['bbsp_triggerstartport'] + getElement('TriggerPort').value + porttrigger_language['bbsp_invalid']);
            return false;
        }
        if (getElement('TriggerPortEnd').value == "" || isValidPort(getElement('TriggerPortEnd').value) == false
		    || (getValue('TriggerPortEnd') != "" && getValue('TriggerPortEnd').charAt(0) == '0'))
        {
            AlertEx(porttrigger_language['bbsp_triggerendport'] + getElement('TriggerPortEnd').value + porttrigger_language['bbsp_invalid']);
            return false;
        }

        if (getElement('OpenPort').value == "" || isValidPort(getElement('OpenPort').value) == false
		    || (getValue('OpenPort') != "" && getValue('OpenPort').charAt(0) == '0'))
        {
             AlertEx(porttrigger_language['bbsp_openstartport'] + getElement('OpenPort').value + porttrigger_language['bbsp_invalid']);
             return false;
        }
        if (getElement('OpenPortEnd').value == "" || isValidPort(getElement('OpenPortEnd').value) == false
		|| (getValue('OpenPortEnd') != "" && getValue('OpenPortEnd').charAt(0) == '0'))
        {
             AlertEx(porttrigger_language['bbsp_openendport'] + getElement('OpenPortEnd').value + porttrigger_language['bbsp_invalid']);
             return false;
        }

        CountPortSum();

        if ((TriggerPortSum + parseInt(getElement('TriggerPortEnd').value,10) - parseInt(getElement('TriggerPort').value,10)+ 1) > 256)
        {
            AlertEx(porttrigger_language['bbsp_triggerportnumfull']);
            return false;
        }
        if ((OpenPortSum + parseInt(getElement('OpenPortEnd').value,10) - parseInt(getElement('OpenPort').value,10)+ 1) > 256)
        {
            AlertEx(porttrigger_language['bbsp_openportnumfull']);
            return false;
        }

        if(1 != IsTalkTalkMode)
	    {
	        if ((parseInt(getElement('TriggerPort').value,10) <= 21) && (parseInt(getElement('TriggerPortEnd').value,10) >= 21))
            {
                AlertEx(porttrigger_language['bbsp_triggerportnot21']);
                return false;
            }
            
            if ((parseInt(getElement('TriggerPort').value,10) <= 69) && (parseInt(getElement('TriggerPortEnd').value,10) >= 69))
            {
                AlertEx(porttrigger_language['bbsp_triggerportnot69']);
                return false;
            }
	    }

       tPortS = parseInt(getElement('TriggerPort').value,10);
       tPortE = parseInt(getElement('TriggerPortEnd').value,10); 
       if (tPortS > tPortE)
       {
            AlertEx(porttrigger_language['bbsp_triggerstartportleqend']);
            return false;
       }

       oPortS = parseInt(getElement('OpenPort').value,10);
       oPortE = parseInt(getElement('OpenPortEnd').value,10); 
       if (oPortS > oPortE)
       {
            AlertEx(porttrigger_language['bbsp_openstartportleqend']);
            return false;
       }
    }
    
    return true;
}

var AddFlag = false;
var selctIndex = -1;



function AddSubmitParam()
{   
	if (false == CheckForm())
	{
		return;
	}
	
    var DomainPrefix = getSelectVal('WANName')+'.X_HW_PortTrigger';
    if (isSupportHybrid == 1) {
        if (getSelectVal('WANName') == 'Bonding') {
            DomainPrefix = 'InternetGatewayDevice.Services.X_HW_Bonding.X_HW_PortTrigger';
        }
    }
	var url;

	var PTSpecCfgParaList = new Array(new stSpecParaArray("x.Enable",getCheckVal('Enable'), 1),
											 new stSpecParaArray("x.TriggerPort",getValue('TriggerPort'), 1),
											 new stSpecParaArray("x.TriggerPortEnd",getValue('TriggerPortEnd'), 1),
											 new stSpecParaArray("x.TriggerProtocol",getValue('TriggerProtocol'), 1),
											 new stSpecParaArray("x.OpenPort",getValue('OpenPort'), 1),
											 new stSpecParaArray("x.OpenPortEnd",getValue('OpenPortEnd'), 1),
											 new stSpecParaArray("x.OpenProtocol",getValue('OpenProtocol'), 1));
											 
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = PTConfigFormList;
	Parameter.SpecParaPair = PTSpecCfgParaList;

	if ( AddFlag == true )
	{
		url = 'add.cgi?x=' + DomainPrefix
						   +'&RequestFile=html/bbsp/porttrigger/porttrigger.asp';
	}
	else
	{
		url = 'set.cgi?x=' + PortTrigger[selctIndex].domain
						   +'&RequestFile=html/bbsp/porttrigger/porttrigger.asp';
	}
	var tokenvalue = getValue('onttoken');
	HWSetAction(null, url, Parameter, tokenvalue);
	
	setDisable('btnApply_ex',1);
	setDisable('cancelValue',1);
}

function setCtlDisplay(record)
{
    var endIndex = record.domain.lastIndexOf('X_HW_PortTrigger') - 1;
	var Interface = record.domain.substring(0,endIndex);

    if (isSupportHybrid == 1) {
        if (record.domain.indexOf('X_HW_Bonding') >= 0) {
            Interface = 'Bonding';
        }
    }
    setSelect('WANName',Interface);
    setSelect('TriggerProtocol',(record.TProto).toUpperCase());
    setSelect('OpenProtocol',(record.OProto).toUpperCase());
	
    getElement('TriggerPort').value = record.TPort;
    getElement('TriggerPortEnd').value = record.TPortEnd;
    getElement('OpenPort').value = record.OPort;
    getElement('OpenPortEnd').value = record.OPortEnd;
    setCheck('Enable', record.Enable);
}

function setControl(index)
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(maptInfo_language["map041"]);
        return;
    }
    var record;
    var endIndex;

	selctIndex = index;
	setDisable('btnApply_ex',0);
    setDisable('cancelValue',0);

    if (index == -1)
    {
        if(PortTrigger.length >= 32)
	    {
	        setDisplay('TableConfigInfo', 0);
			if (GetCfgMode().PCCWHK == "1")
			{
				AlertEx(porttrigger_language['bbsp_triggerportfullpccw']);
			}
			else
			{
				AlertEx(porttrigger_language['bbsp_triggerportfull']);
			}
		    return;
	    }
    	setDisable('WANName', 0);
    	AddFlag = true;
        RefreshWanInterface(AddFlag);
        record = new stPortTrigger('','1','','','','','','','');
        setDisplay('TableConfigInfo', 1);
        setCtlDisplay(record);
        if (isMegacablePWD === '1') {
            setCheck('Enable', 0);
        }
    }
    else if (index == -2)
    {
        setDisplay('TableConfigInfo', 0);
    }
    else
    {
    	setDisable('WANName', 1);
    	AddFlag = false;
        RefreshWanInterface(AddFlag);
        record = PortTrigger[index];
        setDisplay('TableConfigInfo', 1);
        setCtlDisplay(record);
    }
	
	if((1 == IsTELECOMFlag) && (curUserType != sysUserType))
	{
		setAllDisable();
	}
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
}

function PTConfigListselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(maptInfo_language["map041"]);
        return;
    }
    if (PortTrigger.length == 0)
	{
	    AlertEx(porttrigger_language['bbsp_notrigger']);
	    return;
	}

	if (selctIndex == -1 && AddFlag == true)
	{
	    AlertEx(porttrigger_language['bbsp_savetrigger']);
	    return;
	}
    var rml = getElement(TableName + 'rml');
	var SubmitForm = new webSubmitForm();
    var noChooseFlag = true;
    if ( rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             {   
                 noChooseFlag = false;
				 SubmitForm.addParameter(rml[i].value,'');
             }
         }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
		SubmitForm.addParameter(rml.value,'');
    }
    if ( noChooseFlag )
    {
        AlertEx(porttrigger_language['bbsp_selecttrigger']);
        return ;
    }
  
	if (ConfirmEx(porttrigger_language['bbsp_confirm1']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
	    return;
    }
    setDisable('btnApply_ex',1);
    setDisable('cancelValue',1);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/porttrigger/porttrigger.asp');   
	SubmitForm.submit();
}    

TOTAL_APP = 5;
var FIRST_APP = "Choose...";
var v = new Array(TOTAL_APP);

v[0] = new cV("Aim Talk", 1);
v[0].e[0] = new iVe("4099", "4099", "1", "5191", "5191", "1" );

v[1] = new cV("Asheron's Call", 1);
v[1].e[0] = new iVe("9000", "9013", "2", "9000", "9013", "2" );

v[2] = new cV("Calista IP Phone", 1);
v[2].e[0] = new iVe("5190", "5190", "1", "3000", "3000", "2" );

v[3] = new cV("Net2Phone", 1);
v[3].e[0] = new iVe("6801", "6801", "2", "6801", "6801", "2" );

v[4] = new cV("Rainbow Six/Rogue Spea", 1);
v[4].e[0] = new iVe("2346", "2346", "1", "2436", "2436", "0" );

function cV(name, entryNum)
{   
    this.name = name;
    this.eNum = entryNum;
    this.e = new Array(6);
}

function iVe(eStart, eEnd, proto, iStart, iEnd, oProto)
{
    this.eStart = eStart;
    this.eEnd = eEnd;
    this.proto = proto;
    this.iStart = iStart;
    this.iEnd = iEnd;
    this.oProto = oProto;
}

function trimspace(str)
{
    var strTemp = new String(str);
    while (-1 != strTemp.search(" "))
    {
         strTemp = strTemp.replace(" ", "");  
    }
    return strTemp; 
}

function clearAll()
{

}

function appSelect(sName) 
{
    clearAll();
           
    with (getElement('TableConfigInfo')) 
    {   
         if (sName == FIRST_APP) 
         {
             return;
         }     
         for(var iIdx = 0; iIdx < TOTAL_APP; iIdx++) 
         {  
             if(v[iIdx].name == sName) 
             {   
                  switch (v[iIdx].e[0].proto)
                  {
                      case '0':
                          setSelect('TriggerProtocol','TCP/UDP');
                          break;
                      case '1':
                          setSelect('TriggerProtocol','TCP');
                          break;
                      case '2':
                          setSelect('TriggerProtocol','UDP');
                          break;
                  }

                  switch (v[iIdx].e[0].oProto)
                  {
                      case '0':
                          setSelect('OpenProtocol','TCP/UDP');
                          break;
                      case '1':
                          setSelect('OpenProtocol','TCP');
                          break;
                      case '2':
                          setSelect('OpenProtocol','UDP');
                          break;
                  }

                  getElement('TriggerPort').value = v[iIdx].e[0].eStart;
                  getElement('TriggerPortEnd').value = v[iIdx].e[0].eEnd;
                  getElement('OpenPort').value = v[iIdx].e[0].iStart;
                  getElement('OpenPortEnd').value = v[iIdx].e[0].iEnd;
               }
        }
    }
}
        
function radioClick()
{
    if (getRadioVal('radiosrv') == 1)
    {
        setDisable('constsrvName',0);          
    }
    else
    {
        setDisable('constsrvName',1);   
    }
}

function displayBlankValue()
{
    setSelect('TriggerProtocol','UDP');
    setSelect('OpenProtocol','UDP');
    setText('TriggerPort','');
    setText('TriggerPortEnd','');
    setText('OpenPort','');
    setText('OpenPortEnd','');
    setCheck('Enable', '');
}

function CancelConfig()
{
    setDisplay("TableConfigInfo", 0);
	
	if (selctIndex == -1)
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
        var record = PortTrigger[selctIndex];
        setCtlDisplay(record);
    } 
}

function ShowPorttriggerEnableStatus(statusflag)
{
	var porttrigger_status = '' ;
	if (statusflag == "1" || statusflag == 1)
	{
		porttrigger_status += '<TD >' + porttrigger_language['bbsp_porttrigger_enable'] + '&nbsp;</TD>';
	}
	else
	{
		porttrigger_status += '<TD >' + porttrigger_language['bbsp_porttrigger_disable'] + '&nbsp;</TD>';
	}	
	document.write(porttrigger_status);
}

function InitPTTableList()
{
	for (var i = 0; i < TableDataInfo.length - 1; i++)
	{
		TableDataInfo[i].Enable = TableDataInfo[i].Enable == 1 ? porttrigger_language['bbsp_porttrigger_enable'] : porttrigger_language['bbsp_porttrigger_disable'];
		TableDataInfo[i].TPort = TableDataInfo[i].TPort + '-' + TableDataInfo[i].TPortEnd
		TableDataInfo[i].OPort = TableDataInfo[i].OPort + '-' + TableDataInfo[i].OPortEnd;
		TableDataInfo[i].TProto = TableDataInfo[i].TProto.toUpperCase();
		TableDataInfo[i].OProto = TableDataInfo[i].OProto.toUpperCase();
	}
}

function SetPTTableListTitle()
{
	for (var i = 0; i < PortTrigger.length; i++)
	{
		var checkId = TableName + '_rml' + i;
		if((1 == IsTELECOMFlag) && (curUserType != sysUserType))
		{
			setDisable(checkId, 1);
		}
		else
		{
			setDisable(checkId, 0);
		}
	}
}
function InitWanInterface()
{	
	var HU='<%HW_WEB_GetFeatureSupport(BBSP_FT_HU);%>';
	for (i = 0; i < wans.length; i++)
	{ 
		if (wans[i].ServiceList != 'TR069'
			&& wans[i].ServiceList != 'VOIP'
			&& wans[i].ServiceList != 'TR069_VOIP'
			&& wans[i].Mode == 'IP_Routed'
			&& wans[i].IPv4Enable == '1')
		{
			if((HU==1) && (curUserType != '0') && ((wans[i].ServiceList == 'IPTV') || (wans[i].ServiceList == 'OTHER')))
			{
				continue;
			}
			else
			{
				$("#WANName").append('<option value=' + wans[i].domain + ' id="wan_'
                        + i + '">'
                        + MakeWanName1(wans[i])  + '</option>');
			}
		}
	}	
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
var bbsp_porttrigger_title = 'bbsp_porttrigger_title';
if (IsPTVDFFlag == 1) {
    bbsp_porttrigger_title = 'bbsp_PTVDF_porttrigger_title';
}

HWCreatePageHeadInfo("porttrigger", GetDescFormArrayById(porttrigger_language, "bbsp_mune"), GetDescFormArrayById(porttrigger_language, bbsp_porttrigger_title), false);

</script> 
<div class="title_spread"></div>
 
<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
	var PTConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per7","DomainBox"),
									new stTableTileInfo("bbsp_wanname","align_center width_per13 restrict_dir_ltr","name"),
									new stTableTileInfo("bbsp_enabletrigger","align_center width_per13","Enable"),
									new stTableTileInfo("bbsp_triggerport","align_center width_per18","TPort"),
									new stTableTileInfo("bbsp_openport","align_center width_per18","OPort"),
									new stTableTileInfo("bbsp_terggetprotocol","align_center width_per16","TProto"),
									new stTableTileInfo("bbsp_openprotocol","align_center width_per16","OProto"),null);
									
	var ColumnNum = 7;
	var ShowButtonFlag = true;
	var PTTableConfigInfoList = new Array();
	var TableDataInfo =  HWcloneObject(PortTrigger, 1);
	TableDataInfo.push(null);
	
	InitPTTableList();
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PTConfiglistInfo, porttrigger_language, null);
	SetPTTableListTitle();
</script>

<form id="TableConfigInfo" style="display:none"> 
<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="Enable"     RealType="CheckBox"         DescRef="bbsp_enabletriggermh"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"        InitValue="Empty"/>
		<li   id="WANName"            RealType="DropDownList"     DescRef="bbsp_wannamemh"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"     Elementclass="SelectWanName"          InitValue="Empty"/>
		<li   id="TriggerProtocol"       RealType="DropDownList"     DescRef="bbsp_triggerprotocolmh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.TriggerProtocol"       Elementclass="Select"   InitValue="[{TextRef:'bbsp_TCP',Value:'TCP'},{TextRef:'bbsp_UDP',Value:'UDP'},{TextRef:'bbsp_TCPUDP',Value:'TCP/UDP'}]" />                                                                   
		<li   id="OpenProtocol"       RealType="DropDownList"     DescRef="bbsp_openprotocolmh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.OpenProtocol"       Elementclass="Select"  InitValue="[{TextRef:'bbsp_TCP',Value:'TCP'},{TextRef:'bbsp_UDP',Value:'UDP'},{TextRef:'bbsp_TCPUDP',Value:'TCP/UDP'}]" />                                                                   
		<li   id="TriggerPort"    RealType="TextBox"          DescRef="bbsp_triggerstartportmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.TriggerPort"      InitValue="Empty" MaxLength="5"/>
		<li   id="TriggerPortEnd"    RealType="TextBox"          DescRef="bbsp_triggerendportmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.TriggerPortEnd"      InitValue="Empty" MaxLength="5"/>
		<li   id="OpenPort"    RealType="TextBox"          DescRef="bbsp_openstartportmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.OpenPort"      InitValue="Empty" MaxLength="5"/>
		<li   id="OpenPortEnd"    RealType="TextBox"          DescRef="bbsp_openendportmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.OpenPortEnd"      InitValue="Empty" MaxLength="5"/>
	</table>
	<script language="JavaScript" type="text/javascript">
	PTConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
	var formid_hide_id = null;
	HWParsePageControlByID("TableConfigInfo", TableClass, porttrigger_language, formid_hide_id);
	
	InitWanInterface();
    if (isSupportHybrid == 1) {
        $("#WANName").append('<option value="Bonding" id="BONDING">' + bonding_other_language['bbsp_bonding'] + '</option>');
    }
	</script>
 <table class="table_button" width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <tr> 
      <td class="width_per25"></td> 
      <td class="table_submit">
	    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	  	<button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="AddSubmitParam();"><script>document.write(porttrigger_language['bbsp_app']);</script></button> 
        <button name="cancelValue" id="cancelValue" type="button"  class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(porttrigger_language['bbsp_cancel']);</script></button>
	</td> 
    </tr> 
  </table> 
   <div style="height:10px;">
  </div>
</form>
</body>
</html>
