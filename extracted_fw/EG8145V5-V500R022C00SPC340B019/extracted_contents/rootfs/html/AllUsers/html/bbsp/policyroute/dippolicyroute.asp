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
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, vxlan_route_language);%>"></script>
<title>Policy Route</title>
</head>
<body  class="mainbody"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("policyroutetitle", GetDescFormArrayById(vxlan_route_language, "bbsp_dipmune"), GetDescFormArrayById(vxlan_route_language, "bbsp_diproute_title"), false);
</script> 
<div class="title_spread"></div>

<script language="javascript">
var selIndex = -1;
var OptionGroupMaxNum = '<%HW_WEB_GetSPEC(OPTION60_BIND_OPTIONGROUP_CNT.UINT32);%>';
var OptionCntInGroup = '<%HW_WEB_GetSPEC(OPTION60_BIND_COUNT_IN_GROUP.UINT32);%>';
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var is5182H = "<%HW_WEB_GetFeatureSupport(BBSP_FT_DATAPATH_NP);%>";

var curUserType = '<%HW_WEB_GetUserType();%>';
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var isUNICOMFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>';
function isGuangdongUNICOM(){
    return (CfgFtWordArea === '020' && isUNICOMFlag === '1');
}

function stVXLANConfig(domain,VNI) {
    this.domain = domain;
    this.VNI = VNI;
}

var VXLAN_VXLANConfig = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.VXLANMAP.VXLANView.{i},VNI, stVXLANConfig);%>;

function getIPMaskList(domain, DestIPMaskList, WanType, Device) {
    this.domain = domain;
    this.DestIPMaskList = DestIPMaskList;
    this.WanType = WanType;
    this.Device = Device;
}

var policyIPMaskList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_NSS.X_HW_IPTrafficList.{i},DestIPMaskList|WanType|Device, getIPMaskList);%>;

function loadlanguage() {
	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = vxlan_route_language[b.getAttribute("BindText")];
	}
}

function PolicyRouteItem(_domain, _WanType, _Device, _DestIPMaskList) {
    this.domain = _domain;
    this.WanType = _WanType;
    this.Device = _Device;
    this.DestIPMaskList = _DestIPMaskList;
}

function filterWan(WanItem) {
	if (!(Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))
	{
		return false;	
	}
	
	return true;
}

var stWanList = GetWanListByFilter(filterWan);
var Wanlist = [];
function IsValidWan(Wan) {
    if (viettelflag ==1) {
        if (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0) {
            return false;
        }
    }
    if (Wan.IPv4Enable != '1') {
        return false;
    }
    Wanlist.push(Wan);
    return true;
}

function displayWanList() {
    var Control = getElById("Device");
    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = WanList[i].domain;
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);
        Control.appendChild(Option);
    }

    if (is5182H) {
        for (i = 0; i < VXLAN_VXLANConfig.length; i++) {
            if (VXLAN_VXLANConfig[i]) {
                var Option = document.createElement("Option");
                var words = VXLAN_VXLANConfig[i].domain.split(".");
                Option.value = VXLAN_VXLANConfig[i].domain;
                Option.innerText = GetVxlanName(VXLAN_VXLANConfig[i].domain);
                Control.appendChild(Option);
            }
        }
    }
}

var TableName = "PolicyRouteConfigList";

var PolicyRouteList = [];
for (var i = 0; i < policyIPMaskList.length; i++) {
    if (policyIPMaskList[i] == null) {
        PolicyRouteList.push(policyIPMaskList[i]);
        continue;
    }
    if (policyIPMaskList[i].WanType == 1) {
        PolicyRouteList.push(policyIPMaskList[i]);
    }

}

window.onload = function() {
    GetWanListByFilter(IsValidWan);
    displayWanList();
    loadlanguage();
    if (curUserType === '1' && isGuangdongUNICOM()) {
        pageDisable();
        setDisplay("Newbutton",0);
        setDisplay("DeleteButton",0);
        setDisplay("Apply",0);
        setDisplay("Cancel",0);
    }
}

</script> 
<script language="JavaScript" type="text/javascript">
var OperatorFlag = 0;
var OperatorIndex = 0;

function GetInputRouteInfo() {
    return new PolicyRouteItem("", 1, getSelectVal("Device"), getValue("DestIPMaskList"));
}

function SetInputRouteInfo(RouteInfo) {
    setSelect("Device", RouteInfo.Device);
    setText("DestIPMaskList", RouteInfo.DestIPMaskList)
}

function OnNewInstance(index) {
   OperatorFlag = 1;
   setText("DestIPMaskList", '');
   document.getElementById("TableConfigInfo").style.display = "block";
}

function OnAddNewSubmit() {
    var RouteInfo = GetInputRouteInfo();

    if (RouteInfo.Device.length == 0) {
        AlertEx(vxlan_route_language['bbsp_proutermsg2']);
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.WanType', RouteInfo.WanType);
    Form.addParameter('x.DestIPMaskList', RouteInfo.DestIPMaskList);
    Form.addParameter('x.Device',RouteInfo.Device);

	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_NSS.X_HW_IPTrafficList' + '&RequestFile=html/bbsp/policyroute/dippolicyroute.asp');
    Form.submit();
    DisableRepeatSubmit();
    setDisable('Apply', 1);
    setDisable('Cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}
 

function ModifyInstance(index) {
    OperatorFlag = 2;
    OperatorIndex = index;

    document.getElementById("TableConfigInfo").style.display = "block";
    SetInputRouteInfo(PolicyRouteList[index]);
} 
function OnModifySubmit() {
    var RouteInfo = GetInputRouteInfo();
    RouteInfo.domain = PolicyRouteList[OperatorIndex].domain;

    if (RouteInfo.Device.length == 0) {
        AlertEx(vxlan_route_language['bbsp_proutermsg2']);
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.WanType', RouteInfo.WanType);
    Form.addParameter('x.DestIPMaskList', RouteInfo.DestIPMaskList);
    Form.addParameter('x.Device',RouteInfo.Device);

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('set.cgi?' +'x='+ RouteInfo.domain + '&RequestFile=html/bbsp/policyroute/dippolicyroute.asp');
    Form.submit();
    setDisable('Apply', 1);
    setDisable('Cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}

function setControl(index) {
    if ($("#IPListRow").length == 0) {
        var IpListHtml = '<tr border="1" id="IPListRow"><td class="table_title width_per15" id="PolicyNumColleft">'+ vxlan_route_language['bbsp_iplistmh'] +'</td><td id="PolicyNumCol" class="table_right width_per85"><textarea style = "height: 80px;background: white;" id="DestIPMaskList" class="width_260px restrict_dir_ltr" ></textarea></td></tr>';
        $("#DeviceRow").after(IpListHtml);
    }
    $("#Device").css("width", "267px");
    setDisable("DestIPMaskList", 0);

    selIndex = index;
	if (index < -1) {
		return;
	}

    OperatorIndex = index;
	
    if (-1 == index) {
        return OnNewInstance(index);
    } else {
        return ModifyInstance(index);
    }
}

function PolicyRouteConfigListselectRemoveCnt(val)  {

}

function OnDeleteButtonClick(TableID)  {
    var CheckBoxList = document.getElementsByName(TableName + 'rml');
    var Count = 0;
    var i;
    for (i = 0; i < CheckBoxList.length; i++) {
        if (CheckBoxList[i].checked == true) {
            Count++;
        }
    }

    if (Count <= 0) {
        AlertEx(vxlan_route_language['bbsp_delpolicyroute']);
        return false;
    }

    var Form = new webSubmitForm();
    for (i = 0; i < CheckBoxList.length; i++) {
        if (CheckBoxList[i].checked != true) {
            continue;
        }
 
        Form.addParameter(CheckBoxList[i].value,'');
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_NSS.X_HW_IPTrafficList' + '&RequestFile=html/bbsp/policyroute/dippolicyroute.asp');
    Form.submit();
    setDisable('Apply', 1);
    setDisable('Cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}
  
function OnApply() {
    if (OperatorFlag == 1) {
        return OnAddNewSubmit();
    } else {
        return OnModifySubmit();
    }
}

function OnCancel() {
    getElById('TableConfigInfo').style.display = 'none';
    getElById('TableConfigInfo').style.display = 'none';
    
    if (selIndex == -1) {
         var tableRow = getElementById(TableName);
         if (tableRow.rows.length > 2)
         tableRow.deleteRow(tableRow.rows.length-1);
         return false;
     }
}

function OnChooseDeviceType(Select) {
    var wanname = getElementById("Device").value;
}

function GetVxlanName(domain) {
    
    for (var i = 0; i < VXLAN_VXLANConfig.length; i++) {
        if (domain == VXLAN_VXLANConfig[i].domain) {
            break;
        }
    }

    var words = domain.split(".");
    var innerText = words[words.length - 1] + '_VXLAN_INTERFACE_VNI_' + VXLAN_VXLANConfig[i].VNI;
    return innerText;
}

</script> 

<script language="JavaScript" type="text/javascript">
	var PolicyRouteConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
                                    new stTableTileInfo("bbsp_out_device","align_center restrict_dir_ltr","Device"),
                                    new stTableTileInfo("bbsp_iplist","align_center","DestIPMaskList",false,45),null);
	var ColumnNum = 3;
	var ShowButtonFlag = true;
    var TableDataInfo =  HWcloneObject(PolicyRouteList, 1);

    console.log(TableDataInfo);
    console.log(WanList);
    for (var i = 0; i < TableDataInfo.length -1; i++) {
        for (var j = 0; j < WanList.length; j++) {
            if (TableDataInfo[i].Device == WanList[j].domain) {
                TableDataInfo[i].Device = WanList[j].RealName;
            }
        }

        for (var j = 0; j < VXLAN_VXLANConfig.length - 1; j++) {
            if (TableDataInfo[i].Device == VXLAN_VXLANConfig[j].domain) {
                TableDataInfo[i].Device = GetVxlanName(VXLAN_VXLANConfig[j].domain);
                
            }
        }
    }
    console.log(TableDataInfo);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PolicyRouteConfiglistInfo, vxlan_route_language, null);
</script> 
  
<form id="TableConfigInfo" style="display:none">
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
        <li   id="Device"      RealType="DropDownList"  DescRef="bbsp_out_devicemh"          RemarkRef="Empty"     ErrorMsgRef="bbsp_proutermsg2"    Require="FALSE"    BindField="x.WanName"  Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty" ClickFuncApp="onchange=OnChooseDeviceType"/> 
		<script>
			var TableClass = new stTableClass("width_per15", "width_per85", "ltr");
			var PolicyRouteConfigFormList = new Array();
			PolicyRouteConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
			var formid_hide_id = null;
			HWParsePageControlByID("TableConfigInfo", TableClass, vxlan_route_language, formid_hide_id);
		</script>
	</table>
	<table width="100%"  cellspacing="1" class="table_button"> 
      <tr> 
        <td class='width_per15'></td> 
        <td class="table_submit pad_left5p"> 
          <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
          <input type="text" style="display:none" />
          <button type=button id='Apply' onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(vxlan_route_language['bbsp_app']);</script></button> 
          <button type=button id='Cancel' onclick="javascript:OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(vxlan_route_language['bbsp_cancal']);</script></button> </td> 
      </tr> 
    </table> 
  </form> 
</body>
</html>
