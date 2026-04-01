<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function stWhiteList(domain,status,url)
{
    this.domain = domain;
    this.status = status;
    this.URL = url;
}

var stWhitLists = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.GASY.White_list,status|URL,stWhiteList);%>;
var wlist = stWhitLists[0];
//wlist = {domain:"InternetGatewayDevice.DeviceInfo.GASY.White_list", status:"none", URL:"11-22-33-44-55-66"}

function isValidMac(mac)
{
    var regex = /^([0-9a-fA-F]{2}[:-]){5}([0-9a-fA-F]{2})$/;
    return regex.test(mac);
}

function RessembleMacList(mlist)
{
    var macArr, macArrTmp=[];
    if (mlist == "")
    {
        return "";
    }
    macArr = mlist.split(',');
    for (var i=0; i<macArr.length; i++)
    {
        if (macArr[i].trim() != "")
        {
            macArrTmp.push(macArr[i].trim());
        }
    }
    return macArrTmp.join();
}

function CheckMacList(mlist)
{
    if (mlist == "")
    {
        return true;
    }
    var macArr = mlist.split(',');
    for (var i=0; i<macArr.length; i++)
    {
        if (false == isValidMac(macArr[i]))
        {
            AlertEx("MAC地址非法：" + macArr[i]);
            return false;
        }
    }
    return true;
}

function LoadFrame()
{
    try {
        setElementInnerHtmlById('wlStatus', wlist.status);
        setText('wlMacList', wlist.URL);
    } catch(e){
        if (window.console && console.log) {
            console.log(e);
        }
    }
}

function FormatMacList()
{
    return RessembleMacList(getValue('wlMacList')).replace(/:/g, "-");
}

function CheckForm(type)
{
    var macList = FormatMacList();
    if (CheckMacList(macList) == false)
    {
        return false;
    }
    return true;
}

function AddSubmitParam(SubmitForm,type)
{
    SubmitForm.addParameter('x.URL', FormatMacList());

    SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.GASY.White_list'
                        + '&RequestFile=html/ssmp/monitor/e8cgasy.asp');

    setDisable('Apply_button',1);
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">

<div class="title_with_desc">探针插件MAC白名单设置</div>
<div class="title_01"  style="padding-left:10px;" width="100%"></div>
<div class="title_spread"></div>

<div class="func_spread"></div> 
<form id="ConfigForm" action="">
<div id="whiteList" name="whiteList" class="" style="z-index:2" >
    <table class="tabal_bg"  cellpadding="0" cellspacing="0" width="100%">
		<tr align="left">
		  <td class="table_title" width="30%" align="left">上报状态:</td> 
		  <td class="table_right" colspan="8" align="left"><span id='wlStatus'></span></td> 
		</tr>
		<tr>
		  <td class="table_title" align="left" valign="top">白名单MAC列表：</td> 
		  <td class="table_right" colspan="80"> <textarea style="resize: none;" name='wlMacList' id="wlMacList" cols="60" rows=5 maxlength="3200"></textarea>
			<span class="gray"></span></td>
		</tr> 
    </table>
  </div>
<div class="button_spread"></div>
<div class="table_submit" align="right">
		  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		  <input name="Apply_button" id="Apply_button" type="button" class="submit" value="保存/应用" onClick="Submit();"
</div>
</form>
</body>
</html>
