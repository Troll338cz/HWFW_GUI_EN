<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_ptvdf.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_check.asp);%>"></script>
<script language="JavaScript" type="text/javascript"></script>
<script>
var portolArr= [];
var applyDomian;
var isEditflag = true;
var DefaultRule = null;
var lineNum = 1;
var applyDataArray = [];
var initAddNum = 0;
var MaxSrcIpNum = '<%HW_WEB_GetSPEC(BBSP_SPEC_SEC_SIPWHITENUM.UINT32);%>';
var wanInfo = GetWanList();

function GetLanguage(name) {
    return acessControlUser[name];
}
function WanAccessItemClass(domain, Enable, Protocol, WanName, SrcIPPrefix) {
    this.domain = domain;
    this.Enable = Enable;
    this.Protocol = Protocol;
    this.WanName =  WanName;
    this.SrcIPPrefix =  SrcIPPrefix;
}
var WanAccessListTemp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.WanAccess.{i},Enable|Protocol|WanName|SrcIPPrefix,WanAccessItemClass);%>;

function getServiceListByDomain(name) {
    var servicelist = ""
    for (var i = 0; i < wanInfo.length; i++) {
        if (domainToggle(wanInfo[i].domain) == name) {
            servicelist = wanInfo[i].ServiceList.toUpperCase();
        }
    }
    return servicelist;
}

for (var i = 0; i < WanAccessListTemp.length - 1; i++) {
    if ((getServiceListByDomain(WanAccessListTemp[i].WanName).indexOf("INTERNET") >= 0) &&
        (WanAccessListTemp[i].SrcIPPrefix == "") && (WanAccessListTemp[i].Protocol == "ICMP")) {
        DefaultRule = WanAccessListTemp.splice(i, 1)[0];
    }
}

function SetInitIcmpWanEnable () {
    if ((DefaultRule != null) && (GetFirstInternetWan() != null)) {
        if (DefaultRule.Enable == 0) {
            document.getElementById("icmpControlService").checked = false;
        } else {
            document.getElementById("icmpControlService").checked = true;
        }
    } else {
        document.getElementById("icmpControlService").checked = false;
    }
 } 

function SubmitIcmpWanStatus() {
    var ICMPEnable = document.getElementById("icmpControlService").checked;
    var SubmitData = "";
    var SubmitUrl = "";
    if (ICMPEnable == false) {
        SubmitData += "x.Enable=0";
    } else {
        SubmitData += "x.Enable=1";
    }
    SubmitData += "&x.X_HW_Token=" + getValueById('onttoken');

    if (DefaultRule != null) {
        SubmitUrl += 'set.cgi?x=' + DefaultRule.domain + '&RequestFile=html/bbsp/wanacl/acl_ptvdf.asp';
        submitDataVDF(SubmitData, SubmitUrl);
        return;
    }
    
    if (ICMPEnable == false) {
        return;
    }

    var wanNewName = GetFirstInternetWan().domain;
    SubmitData = "x.Enable=1";
    SubmitData += "&x.WanName=" + domainToggle(wanNewName);
    SubmitData += "&x.Protocol=ICMP";
    SubmitData += "&x.X_HW_Token=" + getValueById('onttoken');
    SubmitUrl += 'add.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices.WanAccess&RequestFile=html/bbsp/wanacl/acl_ptvdf.asp';
    submitDataVDF(SubmitData, SubmitUrl);
    return;
}

function AddItemFunction (obj, event) {
    var CurrentItem = [];
    var srcIPDiv = document.getElementById("editTrustedNetwork_table");
    var srcIPArr = srcIPDiv.getElementsByTagName("input");
    for (let i = 0; i < srcIPArr.length; i++) {
        if (srcIPArr[i].id.indexOf("sourceAddress") > -1) {
            CurrentItem.push(srcIPArr[i].id)
        }
    }
    if (CurrentItem.length >= MaxSrcIpNum) {
            alertVDF(GetLanguage("acess016"));
            return false;
        }
    var htmlinfo = "";
    htmlinfo += '<div class="row">'
    htmlinfo += '<div class="left"><span class="language-string"></span></div>'
    htmlinfo += '<div class="right padding20">'
    htmlinfo += '<input style="width:300px" type="text" id = "sourceAddress' + CurrentItem.length + ' " value="">'
    htmlinfo += '<div class="table-col padding20" style="float:right;margin-left:15px">'
    htmlinfo += '<input class="button button-delete" type="button" onclick="DeletePortolFunction(this,event);">'
    htmlinfo += '</div>'
    htmlinfo += '</div>'
    htmlinfo += '</div>'
    $("#addItem").before(htmlinfo);

    $('#editTrustedNetwork_table').children().children()[3].lastChild.lastChild.style.display = 'block';
}
function domainTowanname(domainStr) {
    if((domainStr != null) && (domainStr != undefined)) {
        var domainArr = domainStr.split('.');
        var type = (domainStr.indexOf(".ip") == -1) ? 'WANPPPConnection' : 'WANIPConnection' ;
        return 'InternetGatewayDevice.WANDevice' + '.' + domainArr[0].match(/\d+/ig)  + '.' + 'WANConnectionDevice' + '.' + domainArr[1] + '.' + type + '.' +  domainArr[2].match(/\d+/ig);
    }
}
function domainToggle(domain) {
    if((domain != null) && (domain != undefined)) {
        var domaina = domain.split('.');
        var type = (domain.indexOf("WANIPConnection") == -1) ? '.ppp' : '.ip' ;
        return 'wan' + domaina[2]  + '.' + domaina[4] + type + domaina[6] ;
    }
}
function EditFunction(obj, event) {
    var objDiv = obj.parentNode.parentNode;
    applyDomian = objDiv.id;
    var childArr = [];
    var srcIPDiv = document.getElementById("editTrustedNetwork_table");
    var srcIPArr = srcIPDiv.getElementsByTagName("input");
        for (let i = 0; i < srcIPArr.length; i++) {
            if (srcIPArr[i].id.indexOf("sourceAddress") > -1) {
                childArr.push(srcIPArr[i].id)
            }
        }
        if (childArr.length > 1) {
            for (let i = 1; i < childArr.length; i++) {
                document.getElementById(childArr[i]).parentNode.parentNode.parentNode.removeChild(document.getElementById(childArr[i]).parentNode.parentNode)
            }
        }
    if ((objDiv.id != "") && (objDiv.id != "trustedNetworkTable_add")) {
        isEditflag = true;
        displayPopupTable("editTrustedNetwork")
        document.getElementById("editTrustedNetwork_title").innerHTML = GetLanguage('acess010');
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == objDiv.id) {
                setPortolCheckVal("accessControlService",applyDataArray[i][2]) 
                setSelectValue("selectWanName", applyDataArray[i][6])
                setPortolSelectVal("selectPortol_show", applyDataArray[i][3])
                $("#sourceAddress0").val((applyDataArray[i][4])[0])
                var htmlinfo = "";
                for (var m = 1;m < (applyDataArray[i][4]).length; m++) {
                    htmlinfo += '<div class="row">'
                    htmlinfo += '<div class="left"><span class="language-string"></span></div>'
                    htmlinfo += '<div class="right padding20">'
                    htmlinfo += '<input style="width:300px" type="text" id = "sourceAddress' + m + ' " value="' + (applyDataArray[i][4])[m] + '">'
                    htmlinfo += '<div class="table-col padding20" style="float:right;margin-left:15px">'
                    htmlinfo += '<input class="button button-delete" type="button" onclick="DeletePortolFunction(this,event);">'
                    htmlinfo += '</div>'
                    htmlinfo += '</div>'
                    htmlinfo += '</div>'
                }
                $("#addItem").before(htmlinfo);
            }
        }
        $('#editTrustedNetwork_table').children().children()[3].lastChild.lastChild.style.display = 'block';

    } else {
        if (WanAccessListTemp.length > 8) {
            alertVDF(GetLanguage("acess016"));
            return false;
        }
        displayPopupTable("editTrustedNetwork")
        isEditflag = false;
        document.getElementById("editTrustedNetwork_title").innerHTML = GetLanguage("acess011");
        $("#accessControlService")[0].checked = false;
        $("#sourceAddress0").val("")
        $("#selectPortol_show").html("");
        for (var i = 0; i < 7; i++ ) {
            $("#selectPortol" + i).css("pointer-events","auto");
        }
        setSelectValue("selectWanName", "Internet") ;
    }
}
function ShowPortolFunction (obj, event) {
    var spanItemArr = [];
    var selectShowDiv = document.getElementById("selectPortol_show");
    var spanArr = selectShowDiv.getElementsByTagName("span");
    var selectHideDiv = document.getElementById("selectPortol_hide");
    var liArr = selectHideDiv.getElementsByTagName("li");
    for (let i = 0; i < spanArr.length; i++) {
        spanItemArr.push(spanArr[i].innerText);
    }
    for (let i = 0; i < liArr.length; i++) {
        if (spanItemArr.indexOf(liArr[i].innerHTML) > -1) {
            liArr[i].style = "pointer-events: none;opacity: 0.4;"
        } else {
            liArr[i].style = "pointer-events: auto;"
        }
    }
}

function DeleteFunction(obj, event) {
    var deleteInstId = obj.parentElement.parentElement.id;
    if (deleteInstId.split("_")[0] != "add") {
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == deleteInstId) {
                applyDataArray[i][0] = "delete"
            }
        }
    } else {
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == deleteInstId) {
                applyDataArray[i] = "";
            }
        } 
    }
    event.target.parentNode.parentNode.parentNode.removeChild(event.target.parentNode.parentNode);
}
function num2binstr(num, outputstrlen) {
    var outputstr = num.toString(2);
    var len = outputstr.length;
    for (var i = 0; i < outputstrlen - len; i++) {
        outputstr = '0' + outputstr;
    }
    return outputstr;
}

function IPv4Address2binstr(address) {
    var addrmum = IpAddress2DecNum(address);
    var addrbinstr = num2binstr(addrmum, 32);
    return addrbinstr;
}
function isIPv4AddrMaskValid(address, masklen) {
    if((isAbcIpAddress(address) == false) || (isDeIpAddress(address) == true) || (isLoopIpAddress(address) == true) ) {
        return false;
    }
    if (false == CheckNumber(masklen, 1, 32)) {
        return false;
    }
    var addrbinstr = IPv4Address2binstr(address);
    var masklenum = parseInt(masklen, 10);
    for (var i = masklenum; i < addrbinstr.length; i++) {
        if ('0' != addrbinstr.charAt(i)) {
            return false;
        }
        return true;
    }
}
function IPv6Address2binstr(address) {
    var ipv6addr_bin = "";
    var ipv6addr = standIpv6Address(address);
    for (var i = 0; i < ipv6addr.length; i++) {
        var tmp = parseInt(ipv6addr[i], 16);
        ipv6addr_bin += num2binstr(tmp, 16);
    }
    return ipv6addr_bin;
}
function isIPv6AddrMaskValid(address, masklen) {
    if (CheckIpv6Parameter(address) == false) {
        return false;
    }
    var ipv6addr_bin = IPv6Address2binstr(address);
    var masklenum = parseInt(masklen, 10);
    for (var j = masklenum; j < ipv6addr_bin.length; j++) {
        if ('0' != ipv6addr_bin.charAt(j)) {
            return false;
        }
    }

    if (false == CheckNumber(masklen, 1, 128)) {
        return false;
    }
    return true;
}
function isDuplicatedAddress(pos, address, masken) {
    var srcIPPortolArr = [];
    var srcIPDiv = document.getElementById("editTrustedNetwork_table");
    var srcIPArr = srcIPDiv.getElementsByTagName("input");
    for (var i = 0; i<srcIPArr.length; i++) {
        if (srcIPArr[i].id != "" && srcIPArr[i].id != "undefined" && srcIPArr[i].value != "" && (srcIPArr[i].id).indexOf("sourceAddress")>-1) {
           srcIPPortolArr.push(srcIPArr[i].value)
       }
    }
    for (var i = 0; i < pos; i++) {
        var addrtmp = srcIPPortolArr[i].split("/")[0];
        var masklentmp = srcIPPortolArr[i].split("/")[1];
        if (address.indexOf(".") > 0) {
            if (addrtmp.indexOf(".") < 0) {
                continue;
            }
            var addrbinstr_tmp = IPv4Address2binstr(addrtmp);
            var addrbinstr_cur = IPv4Address2binstr(address);
            if ((addrbinstr_tmp == addrbinstr_cur) && (masklentmp == masken)) {
                return true;
            }
        } else {
            if (addrtmp.indexOf(":") < 0) {
                continue;
            }
            var ipv6addr_bin_tmp = IPv6Address2binstr(addrtmp);
            var ipv6addr_bin_cur = IPv6Address2binstr(address);
            if ((ipv6addr_bin_tmp == ipv6addr_bin_cur) && (masklentmp == masken)) {
                return true;
            }
        } 
    }
    return false;
}
function applyTrustedNetwork() {
    var spanPortolArr = [];
    var srcIPPortolArr = [];
    var srcIPDiv = document.getElementById("editTrustedNetwork_table");
    var srcIPArr = srcIPDiv.getElementsByTagName("input");
    var invalidArr = [];
    var addrValue = [];
    for (var i = 0; i<srcIPArr.length; i++) {
        if (srcIPArr[i].value == "" && (srcIPArr[i].id).indexOf("sourceAddress") > -1) {
            invalidArr.push(srcIPArr[i]);
        }

        if ((srcIPArr[i].id).indexOf("sourceAddress")>-1) {
            addrValue.push(srcIPArr[i]);
        }
    }

    if (invalidArr.length == 1) {
        if (addrValue.length > 1) {
            alertVDF(GetLanguage("acess012"));
            return false;
        }
    } else if (invalidArr.length > 1){
        alertVDF(GetLanguage("acess012"));
        return false;
    }

    for (var i = 0; i<srcIPArr.length; i++) {
        if (srcIPArr[i].id != "" && srcIPArr[i].id != "undefined" && srcIPArr[i].value != "" && (srcIPArr[i].id).indexOf("sourceAddress")>-1) {
           srcIPPortolArr.push(srcIPArr[i].value)
       }
    }
    var selectWanInfo = "";
    for (var m = 0; m < wanInfo.length; m++) {
        if (domainToggle(wanInfo[m].domain) == getSelectValue("selectWanName")) {
            selectWanInfo = wanInfo[m];
        }
    }
    for (var i = 0; i < srcIPPortolArr.length; i++) {
        if (srcIPPortolArr[i] == "") {
            continue;
        }

        if (srcIPPortolArr[i].indexOf("/") < 0) {
            alertVDF(srcIPPortolArr[i] + GetLanguage("acess012"));
            return false;
        }
        var addresses = srcIPPortolArr[i].split("/");
        if (addresses.length != 2) {
            alertVDF(GetLanguage("acess012"));
        }
        var address = srcIPPortolArr[i].split("/")[0];
        var masklen = srcIPPortolArr[i].split("/")[1];
        if ((address == "") || (masklen == "")) {
            alertVDF(GetLanguage("acess012"));
            return false;
        }

        var valid = false;
        if (address.indexOf(".") > 0) {
            if ((selectWanInfo != null) && (selectWanInfo.X_HW_IPv4Enable != "1")) {
                alertVDF(GetLanguage("acess013"));
                return false;
            }
            valid =  isIPv4AddrMaskValid(address, masklen);
        } else if (address.indexOf(":") > 0) {
            if ((selectWanInfo != null) && (selectWanInfo.X_HW_IPv6Enable != "1")) {
                alertVDF(GetLanguage("acess013"));
                return false;
            }
            valid =  isIPv6AddrMaskValid(address, masklen);
        }

        if (false == valid) {
            alertVDF(GetLanguage("acess012"));
            return false;
        }

        if ( true == isDuplicatedAddress(i, address, masklen)) {
            alertVDF(GetLanguage("acess014"));
            return false;
        }
    }

    var spanPortolArr = [];
    var srcIPPortolArr = [];
    var srcIPInfo = "";
    var applyWanName;
    var applyWanDomain;
    var onceSaveData = [];
    var srcIPDiv = document.getElementById("editTrustedNetwork_table");
    var srcIPArr = srcIPDiv.getElementsByTagName("input");
    for (var i = 0; i<srcIPArr.length; i++) {
        if (srcIPArr[i].id != "" && srcIPArr[i].id != "undefined" && srcIPArr[i].value != "" && (srcIPArr[i].id).indexOf("sourceAddress")>-1) {
           srcIPPortolArr.push(srcIPArr[i].value)
       }
    }
    if (srcIPPortolArr.length == 0) {
        srcIPPortolArr = [""];
    }
    var selectShowDiv = document.getElementById("selectPortol_show");
    var spanArr = selectShowDiv.getElementsByTagName("span");
    if (selectShowDiv.innerHTML != "") {
        for (var i = 0; i < spanArr.length; i++) {
            spanPortolArr.push(spanArr[i].innerText);
        }
    } else {
        spanPortolArr =[];
    }
    if (spanPortolArr.length < 1) {
        alertVDF(GetLanguage("acess018"));
        return false;
    }
    if (isEditflag) {
        var htmlinfo = "";
        for (var m = 0; m < wanInfo.length; m++) {
            if (getSelectValue("selectWanName") == domainToggle(wanInfo[m].domain)) {
                applyWanName = wanInfo[m].Description;
                htmlinfo += '<div class="table-col padding20" title=" ' + escapeHTML(applyWanName) + ' ">' + escapeHTML(restrictingLength(applyWanName,10)) + '</div>'
            }
        }

        if (spanPortolArr.length == 0) {
            htmlinfo += '<div class="table-col padding20" title=""></div>'
        } else {
            htmlinfo += '<div class="table-col padding20" title=" '+ spanPortolArr.join(",") + ' ">' + restrictingLength(spanPortolArr.join(","), 20) + '</div>'
        }
        if (srcIPPortolArr && srcIPPortolArr.length > 0) {
            for (var i = 0; i < srcIPPortolArr.length; i++) {
                srcIPInfo+= srcIPPortolArr[i] + '</br>';
            }
        } else {
            srcIPInfo = "";
        }

        htmlinfo += '<div class="table-col padding20" title=" ' + srcIPInfo + ' ">' + restrictingLength(srcIPInfo, 20) + '</div>'
        var accessEnableStatus;

        if ($("#accessControlService")[0].checked == true) {
            htmlinfo += '<div class="table-col padding20" title="Active">' + GetLanguage("acess009") +'</div>'
            accessEnableStatus = "1";
        } else {
            htmlinfo += '<div class="table-col padding20" title="Deactive">' + GetLanguage("acess017") +'</div>'
            accessEnableStatus = "0";
        }
        htmlinfo += '<div class="table-col padding20">'
        htmlinfo += '<input class="button button-edit" type="button" onclick="EditFunction(this,event)">'
        htmlinfo += '</div>'
        htmlinfo += '<div class="table-col padding20">'
        htmlinfo += '<input class="button button-delete" type="button" onclick="DeleteFunction(this,event)">'
        htmlinfo += '</div>'
        onceSaveData.push("edit",applyDomian,accessEnableStatus,spanPortolArr,srcIPPortolArr,applyWanName,getSelectValue("selectWanName"))
        if (checkICMPRule(onceSaveData)) {
            alertVDF(GetLanguage("acess020"));
            return;
        }
        if (checkExitRule(onceSaveData)) {
            alertVDF(GetLanguage("acess019"));
            return;
        }
        document.getElementById(applyDomian).innerHTML = htmlinfo;
        for (var i = 0; i < applyDataArray.length; i++) {
            if (applyDataArray[i][1] == applyDomian) {
                applyDataArray[i] = onceSaveData;
            }
        }
    } else {
        initAddNum ++;
        htmlinfo = "";
        htmlinfo += '<div class="table-row" id="add_' + initAddNum + '">'
        for (var m = 0; m < wanInfo.length; m++) {
            if (getSelectValue("selectWanName") == domainToggle(wanInfo[m].domain)) {
                applyWanName = wanInfo[m].Description;
                htmlinfo += '<div class="table-col padding20" title=" ' + escapeHTML(applyWanName) + ' ">' + escapeHTML(restrictingLength(applyWanName,10)) + '</div>'
            }
        }
        if (spanPortolArr.length == 0) {
            htmlinfo += '<div class="table-col padding20" title=""></div>'
        } else {
            htmlinfo += '<div class="table-col padding20" title=" '+ spanPortolArr.join(",") + ' ">' + restrictingLength(spanPortolArr.join(","), 20) + '</div>'
        }
        var srcIPInfo = "";
        if (srcIPPortolArr && srcIPPortolArr.length > 0) {
            for (var i = 0; i < srcIPPortolArr.length; i++) {
                srcIPInfo+= srcIPPortolArr[i] + '</br>';
            }
        } else {
            srcIPInfo = "";
        }

        htmlinfo += '<div class="table-col padding20" title=" ' + srcIPInfo + ' ">' + restrictingLength(srcIPInfo, 20) + '</div>'
        var accessEnableStatus;

        if ($("#accessControlService")[0].checked == true) {
            htmlinfo += '<div class="table-col padding20" title="Active">' + GetLanguage("acess009") +'</div>'
            accessEnableStatus = "1";
        } else {
            htmlinfo += '<div class="table-col padding20" title="Deactive">' + GetLanguage("acess017") +'</div>'
            accessEnableStatus = "0";
        }
        htmlinfo += '<div class="table-col padding20">'
        htmlinfo += '<input class="button button-edit" type="button" onclick="EditFunction(this,event)">'
        htmlinfo += '</div>'
        htmlinfo += '<div class="table-col padding20">'
        htmlinfo += '<input class="button button-delete" type="button" onclick="DeleteFunction(this,event)">'
        htmlinfo += '</div>'
        htmlinfo += '</div>'
        onceSaveData.push("add","add_"+initAddNum ,accessEnableStatus,spanPortolArr,srcIPPortolArr,applyWanName,getSelectValue("selectWanName"))
        if (checkICMPRule(onceSaveData)) {
            alertVDF(GetLanguage("acess020"));
            return;
        }
        if (checkExitRule(onceSaveData)) {
            alertVDF(GetLanguage("acess019"));
            return;
        }
        $("#trustedNetworkTable_add").before(htmlinfo);
        applyDataArray.push(onceSaveData);
    }
    cancelPopupTable("editTrustedNetwork");
}
function changeDropdownPortolInfo(obj) {
    var htmlinfo = "";
    portolArr = [];
    var dropdownShowId = obj.id.substr(0, obj.id.length - 1)+ "_show";
    var selectShowDiv = document.getElementById(dropdownShowId);
    var spanArr = selectShowDiv.getElementsByTagName("span");
    if (selectShowDiv.innerHTML != "") {
       for (var i = 0; i < spanArr.length; i++) {
            portolArr.push(spanArr[i].innerText);
       }
    } else {
        portolArr.push(obj.innerHTML);
    }
    document.getElementById(dropdownShowId).innerHTML = "";
    if (portolArr && (portolArr.length > 0) && (portolArr.indexOf(obj.innerHTML) < 0)) {
        portolArr.push(obj.innerHTML);
        obj.style = "pointer-events: none;opacity: 0.4;"
    } 
    for (var i = 0; i < portolArr.length; i++) {
        htmlinfo += '<span class="portol-choice" style="font-size:10px">' + portolArr[i] + '<b class="closeIcon" onclick="closeChoicePortol(this,event);"></b>' + '</span>'
    }
    document.getElementById(dropdownShowId).innerHTML = htmlinfo;
}
function closeChoicePortol(obj, event) {
    var objId =  obj.parentNode.parentNode.id;
    var dropdownHideId = objId.split("_")[0] + "_hide";
    var selectDiv = document.getElementById(dropdownHideId);
    var liArr = selectDiv.getElementsByTagName("li");
    for (var i = 0; i < liArr.length; i++) {
        if (liArr[i].innerHTML == obj.parentNode.innerText) {
            liArr[i].style = "pointer-events: auto;"
        }
    }
    var index = portolArr.indexOf(event.target.parentNode.innerText);
    if (index > -1){
        portolArr.splice(index,1);
    }
    event.target.parentNode.parentNode.removeChild(event.target.parentNode)
}
function setPortolSelectVal(portolID, portolArrInfo) {
    document.getElementById(portolID).innerHTML = "";
    var htmlinfo = "";
    for (var i = 0; i < portolArrInfo.length; i++) {
        htmlinfo += '<span class="portol-choice" style="font-size:10px">' + portolArrInfo[i] + '<b class="closeIcon" onclick="closeChoicePortol(this,event);"></b>' + '</span>'
    }
    document.getElementById(portolID).innerHTML = htmlinfo;
}
function setPortolCheckVal (portolID, checkStatus) {
    if (checkStatus == "0") {
        document.getElementById(portolID).checked = false;
    } else {
        document.getElementById(portolID).checked = true;
    }
}

function stAclInfo(domain, HttpLanEnable, HttpWanEnable, FtpLanEnable, FtpWanEnable, TelnetLanEnable, TelnetWanEnable, HTTPWifiEnable, TELNETWifiEnable, SSHLanEnable, SSHWanEnable, HTTPSWanEnable) {
    this.domain = domain;
    this.HttpWifiEnable = HTTPWifiEnable;
    this.TelnetWifiEnable = TELNETWifiEnable;
    this.HttpLanEnable = HttpLanEnable;
    this.HttpWanEnable = HttpWanEnable;
    this.FtpLanEnable = FtpLanEnable;
    this.FtpWanEnable = FtpWanEnable;
    this.TelnetLanEnable = TelnetLanEnable;
    this.TelnetWanEnable = TelnetWanEnable;
    this.SSHLanEnable = SSHLanEnable;
    this.SSHWanEnable = SSHWanEnable;
    this.HTTPSWanEnable = HTTPSWanEnable;
}
var aclinfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecAclInfos, InternetGatewayDevice.X_HW_Security.AclServices,HTTPLanEnable|HTTPWanEnable|FTPLanEnable|FTPWanEnable|TELNETLanEnable|TELNETWanEnable|HTTPWifiEnable|TELNETWifiEnable|SSHLanEnable|SSHWanEnable|HTTPSWanEnable,stAclInfo);%>;  
var accessDataInfo = [["SSH","",""],["HTTP","",""],["FTP","",""]]
if (aclinfos[0].SSHLanEnable == "0") {
    accessDataInfo[0][2] = GetLanguage('acess004');
} else {
    accessDataInfo[0][2] = GetLanguage('acess003');
}
if (aclinfos[0].SSHWanEnable == "0") {
    accessDataInfo[0][1] = "Trusted Only";
} else {
    accessDataInfo[0][1] = GetLanguage('acess003');
}
if (aclinfos[0].HttpLanEnable == "0") {
    accessDataInfo[1][2] = GetLanguage('acess004');
} else {
    accessDataInfo[1][2] = GetLanguage('acess003');
}
if (aclinfos[0].HttpWanEnable == "0") {
    accessDataInfo[1][1] = "Trusted Only";
} else {
    accessDataInfo[1][1] = GetLanguage('acess003');
}

if (aclinfos[0].FtpLanEnable == "0") {
    accessDataInfo[2][2] = GetLanguage('acess004');
} else {
    accessDataInfo[2][2] = GetLanguage('acess003');
}
if (aclinfos[0].FtpWanEnable == "0") {
    accessDataInfo[2][1] = "Trusted Only";
} else {
    accessDataInfo[2][1] = GetLanguage('acess003');
}
function CreateAccessTableInfo (accessDataInfo) {
    for (var i = 0; i < accessDataInfo.length; i++) {
        var htmlinfo = '<tr  class="line-height70">';
        htmlinfo += '<td style="width: 20%;">' + accessDataInfo[i][0] +'</td>';
        htmlinfo += '<td style="width: 42%;">';
        var selectWanInfoArray= ["","Trusted Only","Trusted Only",GetLanguage('acess003'),GetLanguage('acess003')];
        selectWanInfoArray[0] = accessDataInfo[i][0].toLowerCase()+ "WanRule";
        htmlinfo += '<div class="right padding20 no-left">';
        htmlinfo += '<div class="iframeDropLog padding_letf10" id="' + selectWanInfoArray[0] + '"><div class="IframeDropdown dropdowndiv" style = "position: unset;margin-left:0">';
        htmlinfo += '<div class="iframedropdownShow" id="' + selectWanInfoArray[0] + '_show" value="' + accessDataInfo[i][1] + '" onclick="showDropdownSelect(this, event);">' + accessDataInfo[i][1]+ '</div>';
        htmlinfo += '<ul class="iframedropdownHide noneDisplay" name="dropDownList" id="' + selectWanInfoArray[0] + '_hide">';
        for (var m = 1; m < selectWanInfoArray.length; m++) {
            htmlinfo += '<li id="' + selectWanInfoArray[0] + "_" + (m+1)/2 + '" nvalue="' + selectWanInfoArray[m++] + '" onclick="changeDropdownInfo(this);" title="' + selectWanInfoArray[m] + '">' + selectWanInfoArray[m] + '</li>';
        }
        htmlinfo += '</ul>';
        htmlinfo += '</div>';
        htmlinfo += '</div>';
        htmlinfo += '</div>';
        htmlinfo += '</td>';
        htmlinfo += '<td style="width: 35%;">';
        var selectLanInfoArray = ["",GetLanguage('acess003'),GetLanguage('acess003'),GetLanguage('acess004'),GetLanguage('acess004')];
        selectLanInfoArray[0] = accessDataInfo[i][0].toLowerCase() + "LanRule";
        htmlinfo += '<div class="right padding20 no-left">';
        htmlinfo += '<div class="iframeDropLog padding_letf10" id="' + selectLanInfoArray[0] + '"><div class="IframeDropdown dropdowndiv" style = "position: unset;margin-left:0">';
        htmlinfo += '<div class="iframedropdownShow" id="' + selectLanInfoArray[0] + '_show" value="' +  accessDataInfo[i][2] + '" onclick="showDropdownSelect(this, event);">' + accessDataInfo[i][2]+ '</div>';
        htmlinfo += '<ul class="iframedropdownHide noneDisplay" name="dropDownList" id="' + selectLanInfoArray[0] + '_hide">';
        for (var m = 1; m < selectLanInfoArray.length; m++) {
            htmlinfo += '<li id="' + selectLanInfoArray[0] + "_" + (m+1)/2 + '" nvalue="' + selectLanInfoArray[m++] + '" onclick="changeDropdownInfo(this);" title="' + selectLanInfoArray[m] + '">' + selectLanInfoArray[m] + '</li>';
        }
        htmlinfo += '</ul>';
        htmlinfo += '</div>';
        htmlinfo += '</div>';
        htmlinfo += '</div>';
        htmlinfo += '</td>';
        $("#serviceControl").append(htmlinfo);
    }
}
function AccessControlToggle() {
    var SubmitData = "";
    if (getSelectValue("httpLanRule") == GetLanguage('acess003')) {
        SubmitData +='x.HTTPLanEnable=1';
    } else {
        SubmitData +='x.HTTPLanEnable=0';
    }
    if (getSelectValue("sshLanRule") == GetLanguage('acess003')) {
        SubmitData +='&x.SSHLanEnable=1';
    } else {
        SubmitData +='&x.SSHLanEnable=0';
    }

    if (getSelectValue("sshWanRule") == GetLanguage('acess003')) {
        SubmitData +='&x.SSHWanEnable=1';
    } else {
        SubmitData +='&x.SSHWanEnable=0';
    }
    if (getSelectValue("httpWanRule") == GetLanguage('acess003')) {
        SubmitData +='&x.HTTPWanEnable=1';
    } else {
        SubmitData +='&x.HTTPWanEnable=0';
    }

    if (getSelectValue("ftpWanRule") == GetLanguage('acess003')) {
        SubmitData +='&x.FTPWanEnable=1';
    } else {
        SubmitData +='&x.FTPWanEnable=0';
    }
    if (getSelectValue("ftpLanRule") == GetLanguage('acess003')) {
        SubmitData +='&x.FTPLanEnable=1';
    } else {
        SubmitData +='&x.FTPLanEnable=0';
    }
    $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: SubmitData + "&x.X_HW_Token=" + document.getElementById('onttoken').value,
        url: 'set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices' + '&RequestFile=html/bbsp/wanacl/acl_ptvdf.asp',
        success: function() {}
    });  
}
function SubmitAction () {
    confirmVDF(GetLanguage("acess015"), "submitCheck()");
    return;
}

function checkExitRule(curData) {
    for (var i = 0; i < applyDataArray.length; i++) {
        if ((curData[0] == "edit") && (curData[1] == applyDataArray[i][1])) {
            return false;
        }

        if (applyDataArray[i][3].length != curData[3].length) {
            continue;
        }

        if (applyDataArray[i][3].length > 0) {
            if ((applyDataArray[i][3]).join(",") != curData[3].join(",")) {
                continue;
            }
        }

        if (applyDataArray[i][4].length != curData[4].length) {
            continue;
        }

        if (applyDataArray[i][4].length > 0) {
            if ((applyDataArray[i][4]).join(",") != curData[4].join(",")) {
                continue;
            }
        }
        
        if (applyDataArray[i][6] != curData[6]) {
            continue;
        }
        return true;
    }
    return false;
}

function checkICMPRule(curData) {
    if (curData[6] != domainToggle(GetFirstInternetWan().domain)) {
        return false;
    }

    if (curData[3].length !=1) {
        return false;
    }

    if (curData[4].length != 1) {
        return false;
    }

    if (curData[3][0] != "ICMP") {
        return false;
    }

    if (curData[4][0] != "") {
        return false;
    }

    return true;
}

function submitCheck() {
    AccessControlToggle();

    for (var i = 0; i < applyDataArray.length; i++) {
        var SubmitData = "";
        SubmitData = 'x.Enable=' + applyDataArray[i][2];

        SubmitData += "&x.Protocol=";
        if (applyDataArray[i][3].length > 0) {
            SubmitData += (applyDataArray[i][3]).join(",");
        }

        SubmitData += "&x.SrcIPPrefix=";
        if (applyDataArray[i][4].length >= 0) {
            SubmitData += (applyDataArray[i][4]).join(",");
        }

        SubmitData += "&x.WanName=" + applyDataArray[i][6];
        SubmitData += "&x.X_HW_Token=" + getValueById('onttoken');
        var SubmitUrl = "";

        var configFlag = applyDataArray[i][0];
        if (configFlag == "edit") {
            SubmitUrl = 'setajax.cgi?x=' + applyDataArray[i][1];
        } else if (configFlag == "delete") {
            SubmitData = applyDataArray[i][1] + "=" + "&x.X_HW_Token=" + getValueById('onttoken');
            SubmitUrl = 'del.cgi?x=' + applyDataArray[i][1]; 
        } else if (applyDataArray[i][0] == "add") {
            SubmitUrl = 'add.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices.WanAccess';
        }

        SubmitUrl += '&RequestFile=html/bbsp/wanacl/acl_ptvdf.asp';
        submitDataVDF(SubmitData, SubmitUrl)
    }
    SubmitIcmpWanStatus();
    location.reload();
}

function initData() {
    if (WanAccessListTemp && WanAccessListTemp.length > 1) {
        for (var i = 0; i < WanAccessListTemp.length - 1; i++) {
            var initArr = [];
            initArr.push("edit", WanAccessListTemp[i].domain,WanAccessListTemp[i].Enable,(WanAccessListTemp[i].Protocol).split(","),(WanAccessListTemp[i].SrcIPPrefix).split(","),"",WanAccessListTemp[i].WanName)
            for (var m = 0; m < wanInfo.length; m++) {
                if (domainTowanname(WanAccessListTemp[i].WanName) == wanInfo[m].domain) {
                    initArr[5] = wanInfo[m].Description
                }
            }
            applyDataArray.push(initArr)
        }
    }
}

function DeletePortolFunction(obj, event) {
    var siblingss = [];
    var currentNode =  event.target.parentNode.parentNode.parentNode;
    var childrens =  event.target.parentNode.parentNode.parentNode.parentNode.children;
    for (var i = 0, childrenLen = childrens.length; i < childrenLen; i++) {
        if (childrens[i] !== currentNode) {
            siblingss.push(childrens[i]);
        }
    }
    if (siblingss.length > 4) {
        event.target.parentNode.parentNode.parentNode.parentNode.removeChild(event.target.parentNode.parentNode.parentNode);
    }
    if (siblingss.length == 5){
        $('#editTrustedNetwork_table').children().children()[3].lastChild.lastChild.style.display = 'none';
    }
    $('#editTrustedNetwork_table').children().children()[3].firstChild.firstChild.innerText = GetLanguage('acess007');
} 
function loadframe() {
    initData();
    initSelectIndex();
    setDisplayTable("trustedNetworkTable",1) 
    SetInitIcmpWanEnable();  
}

function checkInternetWan(obj) {
    if ((obj.checked == true) &&(GetFirstInternetWan() == null)) {
        alertVDF(acl_language['bbsp_newwan_first']);
        obj.checked = false;
    }
}
</script>
</head>
<body  id="wanbody" onload="loadframe();">
    <input type="hidden" id="onttoken"   name="onttoken"     value="<%HW_WEB_GetToken();%>">
<div id="content">
<script> 
    CreatHeaderTitle(GetLanguage("acess001"), "");
</script>  
<script> 
    var icmpEnableControl = new Array( new tableArrayInfo("checkboxbutton", GetLanguage("acess002"), "icmpControlService", "checkInternetWan(this);"));
    CreatSetInfoTable("","icmpEnableStatus", icmpEnableControl);
</script>
<div class="tab" style="text-align: left;margin-left: 40px;margin-top: 40px;">
    <table style="border-bottom: 1px solid #e6e6e6;">
        <thead class="line-height45">
            <td style="width: 20%;"></td>
            <td style="width: 42%;">WAN</td>
            <td style="width: 35%;">LAN</td>
        </thead>
        <tbody></tbody>
    </table>
    <table id="serviceControl" style="margin-bottom: 50px;">
        <tbody></tbody>
    </table>
</div>
<script>
    CreateAccessTableInfo(accessDataInfo);
</script>
<script>  
    var tableArrayInfoControl = [[GetLanguage("acess005"), GetLanguage("acess006"), GetLanguage("acess007"), GetLanguage("acess008")]];
    for (var i = 0; i < WanAccessListTemp.length - 1; i++) {
        tableArrayInfoControl[i+1] =[];
        tableArrayInfoControl[i+1][0] = WanAccessListTemp[i].domain;
        for (var m = 0; m < wanInfo.length; m++) {
            if (domainTowanname(WanAccessListTemp[i].WanName) == wanInfo[m].domain) {
                tableArrayInfoControl[i+1][1] = restrictingLength(wanInfo[m].Description,10);
            }
        }
        tableArrayInfoControl[i+1][2] =  WanAccessListTemp[i].Protocol;
        var srcIPPrefixStr =  WanAccessListTemp[i].SrcIPPrefix;
        if (WanAccessListTemp[i].SrcIPPrefix == "") {
            tableArrayInfoControl[i+1][3] = "";
        } else if (WanAccessListTemp[i].SrcIPPrefix.indexOf(",") < 0) {
            tableArrayInfoControl[i+1][3] = srcIPPrefixStr;
        } else {
            tableArrayInfoControl[i+1][3] =""
            var srcIPPrefixStrArr = (WanAccessListTemp[i].SrcIPPrefix).split(",");
            for (var m = 0; m < srcIPPrefixStrArr.length; m++) {
                tableArrayInfoControl[i+1][3] += srcIPPrefixStrArr[m]+'</br>'
            }
        }
        if(WanAccessListTemp[i].Enable == 0){
            tableArrayInfoControl[i+1][4] = GetLanguage("acess017");
        } else {
            tableArrayInfoControl[i+1][4] =  GetLanguage("acess009");
        }
    }
    CreatComplexInfoTable("Trusted Network", "trustedNetworkTable", tableArrayInfoControl, "EditFunction(this,event)", "DeleteFunction(this,event)", "");
</script>

<script>
    var  selectValInfo = []
    selectValInfo.push("selectWanName")
    for (var i = 0; i < wanInfo.length; i++) {
        selectValInfo.push(domainToggle(wanInfo[i].domain), wanInfo[i].Description)
    }
    var  networkTableinfo = new Array( new tableArrayInfo("checkboxbutton", GetLanguage('acess008'), "accessControlService", null),
                                       new tableArrayInfo("select", GetLanguage('acess005'), selectValInfo, ""),
                                       new tableArrayInfo("selectportol", GetLanguage('acess006'), ["selectPortol", "SSH", "HTTP", "FTP","ICMP","ACS"], ""),
                                       new tableArrayInfo("portolinput",GetLanguage('acess007'),"sourceAddress","text"));
    CreatPopupTable(GetLanguage('acess010'),"editTrustedNetwork", networkTableinfo, "applyTrustedNetwork()")
    CreatApplyButton("SubmitAction()");
</script>

</div>
</body>
</html>
