<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>Chinese -- VR business flow</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style type="text/css">
.tabnoline td
{
   border:0px;
}
</style>
<script language="JavaScript" type="text/javascript"> 

var selctIndex = -1;
var enableVR = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_VR.Enable);%>';
var vrFlowIndex = -1;

function loadlanguage() {
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = cloudVR_language[b.getAttribute("BindText")];
    }
}

function stVRAddress(domain,VRAddress) {
    this.domain = domain;
    this.VRAddress = VRAddress;
}


var VRServerAddress = new Array();

VRServerAddress = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_VR.Server.{i},ServerAddress,stVRAddress);%>;
    

function removeClick() {
    var rml = getElement('rml');
  
    if (rml == null) {
       return;
    }
       
 
    var Form = new webSubmitForm();

    var k;      
    if (rml.length > 0) {
        for (k = 0; k < rml.length; k++) {
            if ( rml[k].checked == true ) {
                Form.addParameter(rml[k].value,'');
            }  
        }
    } else if ( rml.checked == true ) {
        Form.addParameter(rml.value,'');
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));   
    Form.setAction('del.cgi?&RequestFile=html/bbsp/cloudVR/cloudVR.asp');
    Form.submit();
}

function LoadFrame() {
    setDisplay('Newbutton',0);
    setDisplay('DeleteButton',0);
    setDisable('VREdit_button',0); 
    
    setDisplay('ConfigForm1',0);
    if (enableVR == "1") {
        getElById("VR_enable_checkbox").checked = true;
    } else if (enableVR == "0") {
        getElById("VR_enable_checkbox").checked = false;
    }
    loadlanguage();
}

function setBtnDisable() {
    setDisable('btnApply_ex',1);
    setDisable('VRDelete_button',1);
    setDisable('VRAdd_button',1);
    setDisable('VREdit_button',1);
}

function OnSelectMacRecord(recId) {
    selectLine(recId);
}

function OnEditMacFilter() {
    var recordId = 'record_' + selctIndex;
    setDisplay('vr_edit_tr',0);
    if((selctIndex < 0) && (VRServerAddress.length <= 1)) {
        AlertEx(cloudVR_language['bbsp_vr_noselect']);
        return;
    }

    if (selctIndex < 0) {
        AlertEx(cloudVR_language['bbsp_rulenum5']);
        return ;
    }
    
    selectLine(recordId);
}

function CheckForm(type) {
    var ServerAddress = null;
    if (adressCfgModeIsIpMode() == true) {
        var SubnetMask = getValue('DestSubnetMask-text');
        var IPAddress = getValue('DestIPAddress-text');
        if (getValue('DestIPAddress-text') == '' && getValue('DestSubnetMask-text') == '') {
            AlertEx(cloudVR_language['bbsp_vr_adressreq']);
            return false;
        } else if (getValue('DestIPAddress-text') == '') {
            AlertEx(cloudVR_language['bbsp_vr_ipreq']);
            return false;
        } else if (getValue('DestSubnetMask-text') == '') {
            AlertEx(cloudVR_language['bbsp_vr_maskreq']);
            return false;
        }
        
        if (isValidIpAddress(IPAddress) == false) {
            AlertEx(cloudVR_language['bbsp_ipisinvalid']);
            return false;
        }
        if (isValidSubnetMask(SubnetMask) == false) {
            AlertEx(cloudVR_language['bbsp_maskisinvalid']);
            return false;
        }
        ServerAddress = getValue('DestIPAddress-text') + "/" +  getValue('DestSubnetMask-text');
    } else {
        ServerAddress = getValue('domainName-text');
        if (ServerAddress == '') {
            AlertEx(cloudVR_language['bbsp_vr_adressreq']);
            return false;
        }
    }

    for (var i = 0; i < VRServerAddress.length-1; i++) {
        if (selctIndex != i) {
            if (ServerAddress.toUpperCase() == VRServerAddress[i].VRAddress.toUpperCase()) {
                AlertEx(cloudVR_language['bbsp_rulenum'] + ServerAddress + cloudVR_language['bbsp_rulenum1']);
                return false;
            }
        } else {
            continue;
        }
    }

    return true;
}

function AddParam(SubmitForm,type) {
    var ServerAddress = null;
    if (adressCfgModeIsIpMode() == true) {
        ServerAddress = getValue('DestIPAddress-text') + "/" +  getValue('DestSubnetMask-text');
    } else {
        ServerAddress = getValue('domainName-text');
    }
    SubmitForm.addParameter('x.ServerAddress',ServerAddress);
    SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    if ( selctIndex == -1 ) {
         SubmitForm.setAction('add.cgi?x=InternetGatewayDevice.Services.X_HW_VR.Server'
                                + '&RequestFile=html/bbsp/cloudVR/cloudVR.asp');
    } else {
         SubmitForm.setAction('set.cgi?x=' + VRServerAddress[selctIndex].domain
                            + '&RequestFile=html/bbsp/cloudVR/cloudVR.asp');
    }
}

function AddSubmitParam(SubmitForm,type) {
    AddParam(SubmitForm,type);
    setBtnDisable();
}


function setCtlDisplay(record) {
    if(record.VRAddress != '') {
        if(record.VRAddress.split('/').length == 2 
        && isValidIpAddress(record.VRAddress.split('/')[0]) == true 
        && isValidSubnetMask(record.VRAddress.split('/')[1]) == true) {
            setSelect('VR-adrr-selects',"IpMode");
        } else {
            setSelect('VR-adrr-selects',"DomainMode");
        }
    }
    onChangeAdrrType();
    
    if (adressCfgModeIsIpMode() == true) {
        if (record.VRAddress != "") {
            var IPAddress = record.VRAddress.split('/')[0];
            var SubnetMask = record.VRAddress.split('/')[1];
            setText('DestIPAddress-text',IPAddress);
            setText('DestSubnetMask-text',SubnetMask);
        } else {
            setText('DestIPAddress-text',"");
            setText('DestSubnetMask-text',"255.255.255.255");
        }
        
    } else {
        setText('domainName-text',record.VRAddress);
    }
}

function setControl(index) {   
    var record;
    selctIndex = index;
    if (index == -1) {
        if (VRServerAddress.length >= 8+1) {
            setDisplay('ConfigForm', 0);
            setDisable('btnApply_ex',1);
            AlertEx(cloudVR_language['bbsp_rulenum4']);
            return;
        } else {
            record = new stVRAddress('','');
            setDisplay('ConfigForm', 1);
            setDisplay('vr_edit_tr',1);
            setCtlDisplay(record);
            setDisable('btnApply_ex',0);
        }
    } else if (index == -2) {
        setDisplay('ConfigForm', 0);
        setDisable('btnApply_ex',0);
    } else {
        record = VRServerAddress[index];

        setDisable('VREdit_button',0);
        setDisable('btnApply_ex',0);

        setDisplay('ConfigForm', 1);
        setDisplay('vr_edit_tr',1);
        setCtlDisplay(record);
    }
}

function OnDeleteBtClick() { 
    var noChooseFlag = true;
    var SubmitForm = new webSubmitForm();   
    if ((VRServerAddress.length-1) == 0) {
        AlertEx(cloudVR_language['bbsp_vr_nodata']);
        return;
    }

    for (var i = 0; i < VRServerAddress.length - 1; i++) {
        var j = i + 1;
        var rmId = 'VRAddress' + j +'_checkbox';
        var rm = getElement(rmId);
        if (rm.checked == true) {
            noChooseFlag = false;
            SubmitForm.addParameter(VRServerAddress[i].domain,'');
        }
    }

    if ( noChooseFlag ) {
        AlertEx(cloudVR_language['bbsp_rulenum2']);
        return ;
    }

    if (ConfirmEx(cloudVR_language['bbsp_rulenum3']) == false) {
        return;
    }
 
    setBtnDisable();
    
    SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
    SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/cloudVR/cloudVR.asp');
    
    SubmitForm.submit();
}

function CancelValue() {   
    if (selctIndex == -1) {
        var tableRow = getElement("VRInfo");

        if (tableRow.rows.length == 1) {
        } else if (tableRow.rows.length == 2) {
            addNullInst('VR business flow');
        } else {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine('record_0');
        }
    } else {
        setText('MACAddress_text',VRServerAddress[selctIndex].VRAddress);
    }
}

function clickCheckboxAll() {
    for (var i = 0; i < VRServerAddress.length - 1; i++) {
        var index = i + 1;
        var chkboxShow = 'VRAddress' + index +'_checkbox';
        var enableVal = getCheckVal("VRAddress_checkbox");
        if (!(vrFlowIndex == index)) {
            setCheck(chkboxShow,enableVal);
            clickCheckbox(index);
        }
    }
}
function clickCheckbox(index) {
    var chkboxShow = 'VRAddress' + index +'_checkbox';
    var chkboxHide = 'VRAddress' + index +'_checkboxCopy';
    var enableVal = getCheckVal(chkboxShow);
    if (!(vrFlowIndex == index)) {
        setCheck(chkboxHide,enableVal);
    }
}

function clickAdd() {
    setDisplay('vr_edit_tr',0);

    var tab = document.getElementById('VR business flow').getElementsByTagName('table');
    var row,col;
    var rowLen = tab[0].rows.length;
    var firstRow = tab[0].rows[0];
    var lastRow = tab[0].rows[rowLen - 1];

    if (lastRow.id == 'record_null') {
        selectLine("record_null");
        return;
    } else if (lastRow.id == 'record_no') {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
    }

    row = tab[0].insertRow(rowLen); 

    var appName = navigator.appName;
    if (appName == 'Microsoft Internet Explorer') {
        g_browserVersion = 1; 
        row.className = 'trTabContent';
        row.id = 'record_null';
        row.attachEvent("onclick", function(){selectLine("record_null");});
    } else {
        g_browserVersion = 2; 
        row.setAttribute('class','trTabContent');
        row.setAttribute('id','record_null');
        row.setAttribute('onclick','selectLine(this.id);');
    }

    for (var i = 0; i < firstRow.cells.length; i++) {
        col = row.insertCell(i);
        col.innerHTML = '----';
    } 
    selectLine("record_null");
}

function onChangeAdrrType(){
    if (adressCfgModeIsIpMode() == true) {
        setDisplay('StaticRouteIpTr',1);
        setDisplay('StaticRouteIpMaskTr',1);
        setDisplay('StaticRouteDomainTr',0);
    } else {
        setDisplay('StaticRouteIpTr',0);
        setDisplay('StaticRouteIpMaskTr',0);
        setDisplay('StaticRouteDomainTr',1);
    }
    
    if (selctIndex == -1) {
        if (adressCfgModeIsIpMode() == true) {
            setText('DestIPAddress-text',"");
            setText('DestSubnetMask-text',"255.255.255.255");
        } else {
            setText('domainName-text',"");
        }
    }
}

function adressCfgModeIsIpMode() {
    if ("DomainMode" == getSelectVal('VR-adrr-selects')) {
        return  false;
    }
    return  true;
}

function submitVREable(val) {
    var Form = new webSubmitForm();
    if(val == true) {
        Form.addParameter('x.Enable',1);
    } else {
        Form.addParameter('x.Enable',0);
    }
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.Services.X_HW_VR'
                            + '&RequestFile=html/bbsp/cloudVR/cloudVR.asp');
    Form.submit();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div class="PageTitle_title"><script>document.write(cloudVR_language['v01']);</script></div>
<div class="PageTitle_content"><script>document.write(cloudVR_language['bbsp_cloudVR_title']);</script></div> 
<div class="title_spread"></div>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tabal_bg" > 
  <form id="ConfigForm1" action=""> 
    <div id='FilterInfo'>    
        <table cellspacing="0" cellpadding="0" width="100%">
            <tr>
                <td class="table_title width_20p"><script>document.write(cloudVR_language['bbsp_cloudVR_enable']);</script></td> 
                <td class="table_right">
                <input type=checkbox value="true" id="VR_enable_checkbox" onClick="submitVREable(this.checked);"/>
                <span class="gray" ><script>document.write(cloudVR_language['bbsp_enable_tip']);</script></span>
                </td> 
            </tr>
        </table>
        <div class="func_spread"></div>
        <hr style="color:#C9C9C9"></hr>
        <script language="JavaScript" type="text/javascript">
            writeTabCfgHeader('VR business flow',"100%");
        </script> 

        <table id="VRInfo" width="100%" cellspacing="1" class="tabal_bg"> 
            <tr> 
                <td class="head_title"><input id="VRAddress_checkbox" type="checkbox" onclick="clickCheckboxAll();"  value="false" ></td> 
                <td id="address-td" class="head_title"><script>document.write(cloudVR_language['bbsp_table_tr']);</script></td>
            </tr> 
            <script language="JavaScript" type="text/javascript">
                if (VRServerAddress.length - 1 == 0)
                {
                    document.write('<tr id="record_no" class="tabal_01" onclick="OnSelectMacRecord(this.id);">');
                    document.write('<td id=\"VRAddress1_checkbox\" align="center">--</td>');
                    document.write('<td id=\"address1-td\" align="center">--</td>'); 
                    document.write('</tr>');
                }
                else
                {
                    for (i = 0; i < VRServerAddress.length - 1; i++)
                    {
                        var j = i+1;
                        if (VRServerAddress[i].VRAddress != '')
                        {
                            document.write('<tr id="record_' + i + '" class="tabal_01"  onclick="OnSelectMacRecord(this.id)">');
                            
                            document.write('<td align="center"><input id=\"VRAddress' + j +'_checkbox\"'  + 'type=\'checkbox\''+ 'value=\'false\'' + 'onclick=\"clickCheckbox('+j+');\" \'>' );
                            document.write('<input id=\"VRAddress' + j +'_checkboxCopy\"'  + 'type=\'checkbox\' name=\'rml\''
                                                + ' value=\'' + VRServerAddress[i].domain + '\' style=\"display:none\" >'+ '</td>' );
                            document.write('<td align="center" id=\"address'+ j + '_td\">' +  VRServerAddress[i].VRAddress  + '&nbsp;</td>');
                                
                            document.write('</tr>');
                        }
                    }
                }
            </script> 
        </table> 
        <td>

        </td>
        <div id="ConfigForm"> 
            <table  cellpadding="0" cellspacing="0" width="100%" > 
                <tr> 
                    <td id="vr_edit_tr" style="display:none"> 
                        <table cellpadding="0" cellspacing="1" width="100%"> 
                            <tr> 
                              <td class="table_title"><script>document.write(cloudVR_language['bbsp_cloudVR_td1']);</script></td> 
                              <td  class="table_right "> 
                                <select name='VR-adrr-select'  id="VR-adrr-selects" size='1' onChange="onChangeAdrrType();"> 
                                    <option value="DomainMode" selected><script>document.write(cloudVR_language['bbsp_select_option1']);</script></option>
                                    <option value="IpMode"><script>document.write(cloudVR_language['bbsp_select_option2']);</script></option>
                                </select>
                              </td> 
                            </tr>
                            <tr id="StaticRouteIpTr"> 
                              <td class="table_title"><script>document.write(cloudVR_language['bbsp_cloudVR_td2']);</script></td> 
                              <td  class="table_right "> 
                                <input type='text' id='DestIPAddress-text' name='DestIPAddress-text'/>
                                <font class='color_red'>*</font>
                                <span class="gray" >(X.X.X.X)</span>
                              </td> 
                            </tr>
                            <tr id="StaticRouteIpMaskTr"> 
                              <td class="table_title"><script>document.write(cloudVR_language['bbsp_cloudVR_td3']);</script></td> 
                              <td  class="table_right "> 
                                <input type='text' id='DestSubnetMask-text' name='DestSubnetMask-text' value="255.255.255.255"/>
                                <font class='color_red'>*</font>
                                <span class="gray" >(X.X.X.X)</span>
                              </td> 
                            </tr>
                            <tr id="StaticRouteDomainTr" style="display:none;"> 
                              <td class="table_title"><script>document.write(cloudVR_language['bbsp_cloudVR_td4']);</script></td> 
                              <td  class="table_right "> 
                                <input type='text' id='domainName-text' name='domainName-text'/> 
                                <font class='color_red'>*</font>
                              </td> 
                            </tr>
                        </table> 
                    </td> 
                </tr> 
            </table> 
            <div class="button_spread"></div>
            <table width="100%" class="table_button"> 
                <tr align="right"> 
                    <td> 
                        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                        <button id='VRAdd_button'  type="button" class="submit" onClick="clickAdd('VR business flow');"><script>document.write(cloudVR_language['bbsp_add_btn']);</script></button>
                        <button id='btnApply_ex' name="btnApply_ex"  type="button" class="submit" onClick="Submit();"><script>document.write(cloudVR_language['bbsp_apply_btn']);</script></button>
                        <button id='VRDelete_button' name="VRDelete_button"  type="button" class="submit" onClick="OnDeleteBtClick();"><script>document.write(cloudVR_language['bbsp_del_btn']);</script></button>
                    </td>
                </tr> 
                <tr> 
                    <td  style="display:none"> <input type='text'> </td> 
                </tr>          
            </table> 
        </div> 
        <script language="JavaScript" type="text/javascript">
            writeTabTail();
        </script> 
    </div> 
  </form> 
</table> 
</body>
</html>
