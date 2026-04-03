<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, proute_language);%>"></script>
<title>Policy Route</title>
</head>
<body  class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("policyroutetitle", GetDescFormArrayById(proute_language, "bbsp_mune"), GetDescFormArrayById(proute_language, "bbsp_proute_title"), false);
</script> 
<div class="title_spread"></div>

<script language="javascript">
var selIndex = -1;
var OptionGroupMaxNum = '<%HW_WEB_GetSPEC(OPTION60_BIND_OPTIONGROUP_CNT.UINT32);%>';
var OptionCntInGroup = '<%HW_WEB_GetSPEC(OPTION60_BIND_COUNT_IN_GROUP.UINT32);%>';
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var cfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var isUNICOMFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>';
function isGuangdongUNICOM(){
    return (CfgFtWordArea === '020' && isUNICOMFlag === '1');
}
function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = proute_language[b.getAttribute("BindText")];
	}
}

function PolicyRouteItem(_Domain, _Type, _VenderClassId, _WanName, _IsUnBind, _IsDefaultRule)
{
    this.Domain = _Domain;
    this.Type = _Type;
    this.VenderClassId = _VenderClassId;
    this.WanName = _WanName;
	this.IsUnBind = _IsUnBind;
	this.IsDefaultRule = _IsDefaultRule;
}

function filterWan(WanItem)
{
	if (!(Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))
	{
		return false;	
	}
	
	return true;
}

var stWanList = GetWanListByFilter(filterWan);

function IsValidWan(Wan)
{
    if (cfgModeWord.toUpperCase() == "ROSUNION" && curUserType != '0') {
		if ((Wan.ServiceList.toString().toUpperCase().indexOf("IPTV") >=0) || (Wan.ServiceList.toString().toUpperCase().indexOf("VOIP") >=0) || (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)) {
			return false;
		}
	}
    if (viettelflag ==1)
    {
        if (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
        {
            return false;
        }        
    }
    if (Wan.IPv4Enable != '1')
    {
        return false;
    }

    if (Wan.Tr069Flag == "1")
    {
        return false;
    }

    return true;
}

function IsRouteWan(wanname)
{
	var WanInfo = GetWanInfoByWanName(wanname);

    if (WanInfo.Mode == 'IP_Routed')
    {
        return true; 
    }
	return false;
}

function IsVenderClassIdValid(VenderClassId)
{
    var uiDotCount = 0;
    var i;
    var chDot = '*';
    var uiLength = VenderClassId.length;

    for (i = 0; i < VenderClassId.length; i++)
    {
        if(VenderClassId.charAt(i)==',')
        {
            return false;
        }
	if(VenderClassId.charAt(i)==chDot)
        {
            uiDotCount++; 
        }
    }   

    if (uiDotCount > 2)
    {
        return false;
    }

    if (0== uiDotCount)
    {
        return true;
    }

    if ((1 == uiDotCount) 
        && (VenderClassId.charAt(0) != chDot) 
        && (VenderClassId.charAt(uiLength-1) != chDot))
    {
        return false;
    }

    if ((2 == uiDotCount) 
        && ((VenderClassId.charAt(0) != chDot) 
        || (VenderClassId.charAt(uiLength-1) != chDot)))
    {
        return false
    }

    return true;
}


function dhcpmainst(domain,startip,endip)
{
	this.domain 	= domain;
	this.startip	= startip;
	this.endip		= endip;
}
var TableName = "PolicyRouteConfigList";
var MainDhcpRange = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,MinAddress|MaxAddress,dhcpmainst);%>;
var PolicyRouteListAll = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterPolicyRoute, InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route.{i},PolicyRouteType|VenderClassId|WanName|IsUnBind|IsDefaultRule,PolicyRouteItem);%>;  

var PolicyRouteList = new Array();
var i,j = 0;
var PolicyRouteNum = 0;
var PolicyRouteInfo = new Array();
for(var k = 0; k < OptionGroupMaxNum; k++)
{
	PolicyRouteInfo[k] = new Array();
}

for(var m = 0; m < OptionGroupMaxNum; m++)
{
	PolicyRouteInfo[m][0] = 0;
	PolicyRouteInfo[m][1] = 0;
}
var IndexList = new Array();
var l = 0;
for (i = 0; i < PolicyRouteListAll.length; i++)
{
	if (PolicyRouteListAll[i] && PolicyRouteListAll[i].Type.toUpperCase() == "SourceIP".toUpperCase())
	{
		var tempArrayVolume= PolicyRouteListAll[i].Domain.split(".");
		var Index = tempArrayVolume[tempArrayVolume.length-1];
	}
	IndexList[l++] = Index;
}


for (i = 0; i < PolicyRouteListAll.length; i++)
{  	
	if (PolicyRouteListAll[i] && PolicyRouteListAll[i].Type.toUpperCase() == "SourceIP".toUpperCase())
	{
		var tempArrayVolume= PolicyRouteListAll[i].Domain.split(".");
		var Index = tempArrayVolume[tempArrayVolume.length-1];
		for(var n = 0; n < OptionGroupMaxNum; n++)
		{
			if(PolicyRouteInfo[n][0] == 0)
			{
				PolicyRouteInfo[n][0] = 1;
				PolicyRouteInfo[n][1] = Index;
				break;
			}
		}
		
		for(var n = 0; n < OptionGroupMaxNum; n++ )
		{	
			if(PolicyRouteInfo[n][0] == 1)
			{	
				var ExistFlag = false;
				for(l = 0; l < IndexList.length; l++)
				{
					if(PolicyRouteInfo[n][1] == IndexList[l])
					{
						ExistFlag = true;
						break;
					}
				}
				if(false == ExistFlag)
				{
					PolicyRouteInfo[n][0] = 0;
					PolicyRouteInfo[n][1] = 0;
				}
			}
		}
	}
    if (PolicyRouteListAll[i] == null)
    {
        PolicyRouteList[j++] = PolicyRouteListAll[i];
        continue;
    }
     
    if (PolicyRouteListAll[i].Type.toUpperCase() == "SourceIP".toUpperCase())
    {
        PolicyRouteList[j++] = PolicyRouteListAll[i];
        continue;
    }
 
}

window.onload = function()
{
    InitWanNameListControlWanname("WanNameList", IsValidWan);
    loadlanguage();
	if (curUserType === '1' && isGuangdongUNICOM()) {
		pageDisable();
		setDisplay("Newbutton",0);
      	setDisplay("DeleteButton",0);
        setDisplay("Apply",0);
      	setDisplay("Cancel",0);
	}
    if ((cfgModeWord.toUpperCase() != "ROSUNION") || ((cfgModeWord.toUpperCase() == "ROSUNION") &&
        (curUserType != "1"))) {
        return;
    }
    var BoxList = document.getElementsByName(TableName + 'rml');
    for (var i = 0; i < BoxList.length; i++) {
        var number = "PolicyRouteConfigList_"+ i +"_2";
        if ((document.getElementById(number).innerHTML.indexOf("VOIP") >= 0) ||
            (document.getElementById(number).innerHTML.indexOf("TR069") >= 0)) {
            var id = "PolicyRouteConfigList_rml" + i;
            setDisable(id, 1);
        }
    }
}

</script> 
<script language="JavaScript" type="text/javascript">
var OperatorFlag = 0;
var OperatorIndex = 0;

function GetInputRouteInfo()
{
    return new PolicyRouteItem("","SourceIP", getValue("VenderClassId"), getSelectVal("WanNameList"), getCheckVal("IsUnBind"), getCheckVal("IsDefaultRule"));  
}

function SetInputRouteInfo(RouteInfo)
{
    setText("VenderClassId", RouteInfo.VenderClassId);
    setSelect("WanNameList", RouteInfo.WanName); 
	setCheck("IsUnBind", RouteInfo.IsUnBind); 
	setCheck("IsDefaultRule", RouteInfo.IsDefaultRule); 
}

function IsRepeateVenderClassId(RouteInfo)
{
    var NewVenderId = RouteInfo.VenderClassId.split(',');
    var OldVenderId;
    var i = 0;
    var j = 0;
    var k = 0;

    for (i = 0; i < NewVenderId.length - 1; i++)
    {   
        for (j = i + 1; j < NewVenderId.length; j++)
        {
            if (NewVenderId[i].toLowerCase() == NewVenderId[j].toLowerCase())
            {
                return true;
            } 
        }
    }
        
    for (k = 0; k < PolicyRouteList.length-1; k++)
    {
        if (RouteInfo.Domain == PolicyRouteList[k].Domain)
        {
            continue;
        }
        
        OldVenderId = PolicyRouteList[k].VenderClassId.split(',');        
        for (i = 0; i < NewVenderId.length; i++)
        {
            for (j = 0; j < OldVenderId.length; j++)
            {
                if (NewVenderId[i].toLowerCase() == OldVenderId[j].toLowerCase())
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

function OnNewInstance(index)
{
   OperatorFlag = 1;
   setText("VenderClassId", '');
   setCheck("IsUnBind", false); 
   setCheck("IsDefaultRule", false); 
   document.getElementById("TableConfigInfo").style.display = "block";
}

function CheckVenderClassId(RouteInfo, bAdd)
{
    var TempVenderId = RouteInfo.VenderClassId.split(',');
    var i;

    if (0 == TempVenderId.length)
    {
        return false;
    }
    else if(OptionCntInGroup < TempVenderId.length)
    {
        if ('' == proute_language['bbsp_eachvendorfullEnd'])
        {
            AlertEx(proute_language['bbsp_eachvendorfull']);
        }
        else
        {
            AlertEx(proute_language['bbsp_eachvendorfull']+OptionCntInGroup+proute_language['bbsp_eachvendorfullEnd']);
        }
        return false;
    }

    for (i = 0; i < TempVenderId.length; i++)
    {
        if (TempVenderId[i].length == 0)
        {
            AlertEx(proute_language['bbsp_proutermsg1']);
            return false;
        } 

        if ( (isValidAscii(TempVenderId[i]) != '') || (IsVenderClassIdValid(TempVenderId[i]) == false) )
        {
            AlertEx(proute_language['bbsp_vendorinvalid']);
            return false;
        }
    		 
    	if(false == isSafeStringExc(TempVenderId[i],'#='))
    	{
    		AlertEx(proute_language['bbsp_60'] + TempVenderId[i] + proute_language['bbsp_60invalid']);
    		return false;
    	}  
    }

    if ((true != bAdd) && (RouteInfo.VenderClassId == PolicyRouteList[OperatorIndex].VenderClassId))
    {
        return true;
    }
    
    if (true == IsRepeateVenderClassId(RouteInfo))
    {
        AlertEx(proute_language['bbsp_vendorrepeat']);
        return false;
    }

    return true; 
}

function OnAddNewSubmit()
{
    var RouteInfo = GetInputRouteInfo();
	for(i = 0; i < OptionGroupMaxNum; i++)
	{
		if(PolicyRouteInfo[i][0] == 0)
		{
			var IpMin = (64*i) ? 64*(i) : 2;
    		var IpMax = (255 == 64*(i + 1) -1) ? 254 : 64*(i + 1) -1;
			break;
		}
	}
	var IpStartOld = MainDhcpRange[0].startip.split('.');
	var IpEndOld = MainDhcpRange[0].endip.split('.');
	var IpMinOld = parseInt(IpStartOld[3]);
	var IpMaxOld = parseInt(IpEndOld[3]);
	if(IpMin < IpMinOld || IpMax > IpMaxOld)
	{
		AlertEx(proute_language['bbsp_ippoolpolicyrouteinvalid']);
		return false;
	}

    if (true != CheckVenderClassId(RouteInfo, true))
    {
        return false;
    }

    if (RouteInfo.WanName.length == 0)
    {
        AlertEx(proute_language['bbsp_proutermsg2']);
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.PolicyRouteType', RouteInfo.Type);
    Form.addParameter('x.VenderClassId',RouteInfo.VenderClassId);
    Form.addParameter('x.WanName',RouteInfo.WanName);
	if(IsRouteWan(RouteInfo.WanName))
	{
	   Form.addParameter('x.IsUnBind',RouteInfo.IsUnBind);
	   Form.addParameter('x.IsDefaultRule',RouteInfo.IsDefaultRule);
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken')); 	
    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route' + '&RequestFile=html/bbsp/policyroute/policyroute.asp');
    Form.submit();
    DisableRepeatSubmit();
    setDisable('Apply', 1);
    setDisable('Cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}
 

function ModifyInstance(index)
{
    OperatorFlag = 2;
    OperatorIndex = index;
    
    document.getElementById("TableConfigInfo").style.display = "block";
    SetInputRouteInfo(PolicyRouteList[index]);

} 
function OnModifySubmit()
{
    var RouteInfo = GetInputRouteInfo();
    RouteInfo.Domain = PolicyRouteList[OperatorIndex].Domain;

    if (true != CheckVenderClassId(RouteInfo, false))
    {
        return false;
    }

    if (RouteInfo.WanName.length == 0)
    {
        AlertEx(proute_language['bbsp_proutermsg2']);
        return false;
    }

    var numberId = "PolicyRouteConfigList_" + OperatorIndex + "_2";
    if (((curUserType == "1") && (cfgModeWord.toUpperCase() == "ROSUNION")) &&
        ((document.getElementById(numberId).innerHTML.indexOf("VOIP") >= 0) ||
        (document.getElementById(numberId).innerHTML.indexOf("TR069") >= 0))) {
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.PolicyRouteType', RouteInfo.Type);
    Form.addParameter('x.VenderClassId',RouteInfo.VenderClassId);
    Form.addParameter('x.WanName',RouteInfo.WanName);
	if(IsRouteWan(RouteInfo.WanName))
	{
	   Form.addParameter('x.IsUnBind',RouteInfo.IsUnBind);
	   Form.addParameter('x.IsDefaultRule',RouteInfo.IsDefaultRule);
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
    Form.setAction('set.cgi?' +'x='+ PolicyRouteList[OperatorIndex].Domain + '&RequestFile=html/bbsp/policyroute/policyroute.asp');
    Form.submit();
    setDisable('Apply', 1);
    setDisable('Cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}
  
function setControl(index)
{ 
    selIndex = index;
	if (index < -1)
	{
		return;
	}

    OperatorIndex = index;   
    var RouteList = "PolicyRouteConfigList_record_"+index;
    getElById("IsUnBindRow").style.display = ""; 
    getElById("IsDefaultRuleRow").style.display = "";

    if (index == -1) {
        setDisable('Apply', 0);
        setDisable('Cancel', 0);
        setDisable('WanNameList', 0);
        if (PolicyRouteList.length-1 == OptionGroupMaxNum) {
            AlertEx(proute_language['bbsp_vendorfull']);
            var tableRow = getElementById(TableName);
             tableRow.deleteRow(tableRow.rows.length-1);
            return false;
        }
        var wanname = getElementById("WanNameList").value;
        if(!IsRouteWan(wanname)) {
           getElById("IsUnBindRow").style.display = "none"; 
           getElById("IsDefaultRuleRow").style.display = "none";
        }
        return OnNewInstance(index);
    } else {
        if ((cfgModeWord.toUpperCase() == "ROSUNION") && (curUserType == "1")) {
            if ((document.getElementById(RouteList).innerHTML.indexOf("VOIP") >= 0) ||
                (document.getElementById(RouteList).innerHTML.indexOf("TR069") >= 0)) {
                setDisable('Apply', 1);
                setDisable('Cancel', 1);
                setDisable('WanNameList', 1);
            }
        }
        if(!IsRouteWan(PolicyRouteList[index].WanName)) {
           getElById("IsUnBindRow").style.display = "none";
           getElById("IsDefaultRuleRow").style.display = "none";
        }
        return ModifyInstance(index);
    }
}

function PolicyRouteConfigListselectRemoveCnt(val) 
{

}

function OnDeleteButtonClick(TableID) 
{
    var CheckBoxList = document.getElementsByName(TableName + 'rml');
    var Count = 0;
    var i;
    for (i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked == true)
        {
            Count++;
        }
    }

    if (Count <= 0) {
        AlertEx(proute_language['bbsp_delpolicyroute']);
        return false;
    }

    var Form = new webSubmitForm();
    for (i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }

        var numberId = "PolicyRouteConfigList_" + i + "_2";
        if (((curUserType == "1") && (cfgModeWord.toUpperCase() == "ROSUNION")) &&
            ((document.getElementById(numberId).innerHTML.indexOf("VOIP") >= 0) ||
            (document.getElementById(numberId).innerHTML.indexOf("TR069") >= 0))) {
            return;
        }

        Form.addParameter(CheckBoxList[i].value,'');
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route' + '&RequestFile=html/bbsp/policyroute/policyroute.asp');
    Form.submit();
    setDisable('Apply', 1);
    setDisable('Cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}
  
function OnApply()
{
    if (OperatorFlag == 1)
    {
        return OnAddNewSubmit();
    }
    else
    {
        return OnModifySubmit();
    }
}

function OnCancel()
{
    getElById('TableConfigInfo').style.display = 'none';
    getElById('TableConfigInfo').style.display = 'none';
    
    if (selIndex == -1)
    {
         var tableRow = getElementById(TableName);
         if (tableRow.rows.length > 2)
         tableRow.deleteRow(tableRow.rows.length-1);
         return false;
     }
}

function InitTableData()
{
	var RecordCount = PolicyRouteList.length - 1;
    var i = 0;
    for (i = 0; i < RecordCount; i++)
    {
		TableDataInfo[i].domain = PolicyRouteList[i].Domain;
		TableDataInfo[i].VenderClassId = PolicyRouteList[i].VenderClassId;
		TableDataInfo[i].WanName = GetWanFullName(PolicyRouteList[i].WanName);
		TableDataInfo[i].IsUnBind = PolicyRouteList[i].IsUnBind;
		TableDataInfo[i].IsDefaultRule = PolicyRouteList[i].IsDefaultRule
    }
}

function OnChooseDeviceType(Select)
{
    getElById("IsUnBindRow").style.display = "none"; 
    getElById("IsDefaultRuleRow").style.display = "none";  

    var wanname = getElementById("WanNameList").value;

    if (IsRouteWan(wanname))
    {
        getElById("IsUnBindRow").style.display = ""; 
		getElById("IsDefaultRuleRow").style.display = "";  
    }
}

</script> 

<script language="JavaScript" type="text/javascript">
	var PolicyRouteConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
                                    new stTableTileInfo("bbsp_vendor","align_center","VenderClassId",false,45),
									new stTableTileInfo("bbsp_wanname","align_center restrict_dir_ltr","WanName"),null);
	var ColumnNum = 3;
	var ShowButtonFlag = true;
	var TableDataInfo =  HWcloneObject(PolicyRouteList, 1);
	InitTableData();
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PolicyRouteConfiglistInfo, proute_language, null);
</script> 
  
<form id="TableConfigInfo" style="display:none">
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="VenderClassId"       RealType="TextBox"          DescRef="bbsp_vendormh"         RemarkRef="bbsp_prnote"     ErrorMsgRef="bbsp_proutermsg1"    Require="TRUE"     BindField="x.VenderClassId"   Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty"  MaxLength="256"/>
		<li   id="WanNameList"      RealType="DropDownList"  DescRef="bbsp_wannamemh"          RemarkRef="Empty"     ErrorMsgRef="bbsp_proutermsg2"    Require="FALSE"    BindField="x.WanName"  Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty" ClickFuncApp="onchange=OnChooseDeviceType"/> 
        <li   id="IsUnBind"         RealType="CheckBox"  DescRef="bbsp_IsUnBind"           RemarkRef="bbsp_UnBnote"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.IsUnBind"   InitValue=""/>		
	    <li   id="IsDefaultRule"    RealType="CheckBox"  DescRef="bbsp_IsDefaultRule"      RemarkRef="bbsp_DfRnote"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.IsDefaultRule"  InitValue=""/>			
		<script>
			var TableClass = new stTableClass("width_per15", "width_per85", "ltr");
			var PolicyRouteConfigFormList = new Array();
			PolicyRouteConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
			var formid_hide_id = null;
			HWParsePageControlByID("TableConfigInfo", TableClass, proute_language, formid_hide_id);
		</script>
	</table>
	<table width="100%"  cellspacing="1" class="table_button"> 
      <tr> 
        <td class='width_per15'></td> 
        <td class="table_submit pad_left5p"> 
          <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
          <input type="text" style="display:none" />
          <button type=button id='Apply' onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(proute_language['bbsp_app']);</script></button> 
          <button type=button id='Cancel' onclick="javascript:OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(proute_language['bbsp_cancal']);</script></button> </td> 
      </tr> 
    </table> 
  </form> 
</body>
</html>
