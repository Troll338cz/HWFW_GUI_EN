<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<title>Wan Access Configuration</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/wanaccesslist.asp"></script>

<script>

var PortAclFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PORT_ACL);%>';
var securityAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_SECURITY_ACCESS);%>';

var CurSrcIpList;
function stAclInfo(domain,FTPLanEnable,TELNETLanEnable)
{
    this.domain = domain;   
    this.FTPLanEnable = FTPLanEnable;    
    this.TELNETLanEnable = TELNETLanEnable;    
}
var aclInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecAclInfos, InternetGatewayDevice.X_HW_Security.AclServices,FTPLanEnable|TELNETLanEnable,stAclInfo);%>;  

var FltsecLevelx = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>';

var sshaccess ='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_CLISSHControl.Enable);%>';
function GetSrcIpList(srcip)
{
    var iplist = srcip.split(",");
    var tmplist = new Array();
    var index = 0;

    for(var i = 0; i < iplist.length; i++)
    {
        if (iplist[i] != "")
            tmplist[index++] = iplist[i];
    }

    return tmplist;
}

function DeleteIpList(id)
{
    var index = id.split('_')[1];
    CurSrcIpList.splice(index, 1);

    var Htmlcode     = CreateSrcIPListCode(CurSrcIpList);
    $("#srciplist").empty();
    $("#srciplist").append(Htmlcode);

}

function AddIpList()
{
   CurSrcIpList.push("");

   var Htmlcode     = CreateSrcIPListCode(CurSrcIpList);
   $("#srciplist").empty();
   $("#srciplist").append(Htmlcode);
}

function radioClick(id)
{

    var index = id.split('_')[1];

    CurSrcIpList[index] = getValue(id);

}

function CreateSrcIPListCode(iplist)
{
    var HtmlCode = "";
    var i = 0;

	HtmlCode += '<table>';
    if (iplist.length > 0)
    {
        for (i = 0; i < iplist.length; i++)
        {
            HtmlCode += '<tr>';
            HtmlCode += '<td><input id=\"ip_' + i + '\" type=\"text\"  value=\"' + htmlencode(iplist[i]) + '\" onblur = \"radioClick(this.id);\" name=\"ip_' + i + '\" class=\"width_186px\" maxlength=\"255\">';
            HtmlCode += '<span class=\"gray\">' + wan_acl_language['bbsp_td_srcip_note'] + '</span>';
            HtmlCode += '</td>';

            HtmlCode += '<td>';
            HtmlCode += '<button id=\"btnDeleteIp_' + i + '\" type=\"button\" onclick=\"DeleteIpList(this.id);\" class=\"NewDelbuttoncss1\" >';
            HtmlCode += wan_acl_language['bbsp_delete'];
            HtmlCode += '</button>';
            HtmlCode += '</td>';
            HtmlCode += '</tr>';
        }
    }

    HtmlCode += '<tr>';
    HtmlCode += '<td>';
    HtmlCode += '<button id=\"btnAddIp\"  type=\"button\" onclick=\"AddIpList();\" class=\"NewDelbuttoncss1\" >';
    HtmlCode +=  wan_acl_language['bbsp_add'];
    HtmlCode += '</button>';
    HtmlCode += '</td>';
    HtmlCode += '</tr>';
	HtmlCode += '</table>';
    return HtmlCode;
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
        b.innerHTML = wan_acl_language[b.getAttribute("BindText")];
    }
}

function BindPageData(WanAclInfo)
{
    setCheck('AisTelnetEnable', 0);
    setCheck('AisFTPEnable', 0);
    setCheck('AisHttpEnable', 0);
    setCheck('AisSSHEnable', 0);
    if (securityAccessFlag != '1') {
        if (WanAclInfo.Protocol.toUpperCase().match('TELNET') || (aclInfo[0].TELNETLanEnable == "1")) {
            setCheck('AisTelnetEnable', 1);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('FTP') || (aclInfo[0].FTPLanEnable == "1")) {
            setCheck('AisFTPEnable', 1);
        }

        if (WanAclInfo.Protocol.toUpperCase().match('HTTP')) {
            setCheck('AisHttpEnable', 1);
        }

        if (sshaccess == "1") {
            setCheck('AisSSHEnable', 1);
        }
        $("#srciplist").empty();

        CurSrcIpList = GetSrcIpList(WanAclInfo.SrcIPPrefix);
        $("#srciplist").append(CreateSrcIPListCode(CurSrcIpList));
    } else {
        if (aclInfo[0].TELNETLanEnable == "1") {
            setCheck('AisTelnetEnable', 1);
        }

        if (aclInfo[0].FTPLanEnable == "1") {
            setCheck('AisFTPEnable', 1);
        }

        if (sshaccess == "1") {
            setCheck('AisSSHEnable', 1);
        }
    }
}


function LoadFrame()
{
    loadlanguage();
	
	if (PortAclFlag == 1)
	{	
		setDisplay("appendacltitle", 1);
	}
	
    if(GetWanAccessList()[0] == undefined)
    {
        BindPageData(new WanAccessItemClass("","","","",""));
    }
    else
    {
        BindPageData(GetWanAccessList()[0]);
    }
	
	if(FltsecLevelx != 'Custom')
	{
		setDisable('AisTelnetEnable',1);
		setDisable('AisSSHEnable',1);
		setDisable('AisHttpEnable',1);
		setDisable('AisFTPEnable',1);
		setDisable('btnDeleteIp_0',1);
		setDisable('btnDeleteIp_1',1);
		setDisable('ip_0',1);
		setDisable('ip_1',1);
		setDisable('btnAddIp',1);
		setDisable('ButtonApply',1);
		setDisable('ButtonCancel',1);
	}
    return true;
}

function FormCheck()
{
    if(GetWanAccessList()[0] == undefined)
    {
        var WanAclInfo = new WanAccessItemClass("","","","","");
    }
    else
    {
        var WanAclInfo = GetWanAccessList()[0];
    }
	
    if(((WanAclInfo.Protocol.toUpperCase().match('TELNET') || aclInfo[0].TELNETLanEnable == "1")&&(0 == getCheckVal('AisTelnetEnable')))
        || ((WanAclInfo.Protocol.toUpperCase().match('FTP') || aclInfo[0].FTPLanEnable == "1")&&(0 == getCheckVal('AisFTPEnable')))
        || ((sshaccess == "1")&&(0 == getCheckVal('AisSSHEnable'))))
    {
        if(false == ConfirmEx(acl_language['bbsp_service_prompt']))
        {
            setCheck('AisSSHEnable',sshaccess);
            
            if(WanAclInfo.Protocol.toUpperCase().match('TELNET') || aclInfo[0].TELNETLanEnable == "1")
            {
                setCheck('AisTelnetEnable', 1);
            }
            else
            {
                setCheck('AisTelnetEnable', 0);  
            }
    
            if(WanAclInfo.Protocol.toUpperCase().match('FTP') || aclInfo[0].FTPLanEnable == "1")
            {
                setCheck('AisFTPEnable', 1);
            }
            else
            {
                setCheck('AisFTPEnable', 1);
            }
            
            if(WanAclInfo.Protocol.toUpperCase().match('HTTP'))
            {
                setCheck('AisHttpEnable', 1);
            }
            else
            {
                setCheck('AisHttpEnable',0);
            }

            return false;
        }
    }
	
    else if((WanAclInfo.Protocol.toUpperCase().match('HTTP')) && (0 == getCheckVal('AisHttpEnable')))
    {
        if(false == ConfirmEx(acl_language['bbsp_confirm_wan']))
        {
            setCheck('AisHttpEnable', 1);
            return false;
        }
    }

    return true;
}

function OnApplyButtonClick()
{
	if(false == FormCheck())
    {
        return;
    }
    var Form = new webSubmitForm();
    var WanAclItem = new WanAccessItemClass("","","","","");
    var selTelnet = getCheckVal('AisTelnetEnable');
    var selSSH = getCheckVal('AisSSHEnable');
    var selHttp = getCheckVal('AisHttpEnable');
    var selFtp = getCheckVal('AisFTPEnable');
	var protoclStr="SSH";

    if (securityAccessFlag != '1') {
        if (selHttp == 1){
            protoclStr += ",HTTP";
        }
        if (selTelnet == 1){
            protoclStr += ",TELNET";
        }
        if (selFtp == 1){
            protoclStr += ",FTP";
        }

        WanAclItem.Protocol = protoclStr;
        var SrcIP = "";
        for (var i = 0; i < CurSrcIpList.length; i++) {
            CurSrcIpList[i] = getValue("ip_"+ i.toString());

            if (i < CurSrcIpList.length - 1) {
                SrcIP += CurSrcIpList[i] + ',';
            } else {
                SrcIP += CurSrcIpList[i];
            }
        }

        if (SrcIP.charAt(SrcIP.length - 1) == ',') {
            SrcIP = SrcIP.substring(0, SrcIP.length - 1);
        }

        Form.addParameter('x.Protocol',WanAclItem.Protocol);
        Form.addParameter('x.SrcIPPrefix',SrcIP);
    }

    Form.addParameter('z.Enable',selSSH);
	Form.addParameter('k.TELNETLanEnable',selTelnet);
    Form.addParameter('k.FTPLanEnable',selFtp);
	Form.addParameter('k.TELNETWifiEnable','1');
	Form.addParameter('k.HTTPWifiEnable','1');
	Form.addParameter('k.HTTPLanEnable','1');
	Form.addParameter('k.HTTPWanEnable','0');
	Form.addParameter('k.FTPWanEnable','0');
	Form.addParameter('k.TELNETWanEnable','0');
	Form.addParameter('k.SSHWanEnable','0');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    if (securityAccessFlag == '1') {
        url = 'set.cgi?'
        + 'z=InternetGatewayDevice.UserInterface.X_HW_CLISSHControl'
        + '&k=InternetGatewayDevice.X_HW_Security.AclServices'
        + '&RequestFile=html/bbsp/acl/aclais.asp';
    } else {
        url = 'set.cgi?'
        + 'x=InternetGatewayDevice.X_HW_Security.AclServices.WanAccess.1'
        + '&z=InternetGatewayDevice.UserInterface.X_HW_CLISSHControl'
        + '&k=InternetGatewayDevice.X_HW_Security.AclServices'
        + '&RequestFile=html/bbsp/acl/aclais.asp';
    }
    Form.setAction(url);
    Form.submit();
    DisableRepeatSubmit();
    setDisable('ButtonApply',1);
    setDisable('ButtonCancel',1);
    return false;
}

function OnCancelButtonClick()
{
    LoadFrame();
    return false;

}

function TelnetEnable()
{
    var enabletelnet = getCheckVal('AisTelnetEnable');
    if (enabletelnet && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
        setCheck('AisTelnetEnable', 0);
        return;
    }
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt"), false);
</script>
<div class="title_spread"></div>
<form id="lan_table">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <script>
            if (securityAccessFlag == '1') {
                document.write("<li   id=\"AisTelnetEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_telnet\"   RemarkRef=\"bbsp_ais_telnet_security_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" ClickFuncApp=\"onclick=TelnetEnable\" />");
                document.write("<li   id=\"AisSSHEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_ssh\"   RemarkRef=\"bbsp_ais_ssh_security_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" />");
                document.write("<li   id=\"AisFTPEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_ftp\"   RemarkRef=\"bbsp_ais_ftp_security_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" />");
            } else {
                document.write("<li   id=\"AisTelnetEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_telnet\"   RemarkRef=\"bbsp_ais_telnet_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" ClickFuncApp=\"onclick=TelnetEnable\" />");
                document.write("<li   id=\"AisSSHEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_ssh\"   RemarkRef=\"bbsp_ais_ssh_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" />");
                document.write("<li   id=\"AisHttpEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_http\"   RemarkRef=\"bbsp_ais_http_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" />");
                document.write("<li   id=\"AisFTPEnable\"   RealType=\"CheckBox\"  DescRef=\"bbsp_ais_ftp\"   RemarkRef=\"bbsp_ais_ftp_tips\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" />");
                document.write("<li   id=\"srciplist\"   RealType=\"HtmlText\"  DescRef=\"bbsp_ais_souraddr\"   RemarkRef=\"Empty\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"  InitValue=\"\" />");
            }
        </script>
    </table>
    <script>
        var TableClass = new stTableClass("per_10_15", "per_35_52", "ltr");
        var LanServiceFormList = new Array();
        LanServiceFormList = HWGetLiIdListByForm("lan_table",null);
        HWParsePageControlByID("lan_table",TableClass,acl_language,null);
    </script>
    <div class="func_spread"></div>
</form>
<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per15'>
        </td>
        <td class="table_submit pad_left5p">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <input id="ButtonApply"  type="button" BindText = "bbsp_app" onclick="OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" >
            <input id="ButtonCancel" type="button" BindText = "bbsp_cancel" onclick="OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" >
        </td>
    </tr>
</table>
<script>
    ParseBindTextByTagName(acl_language, "td",    1);
    ParseBindTextByTagName(acl_language, "div",   1);
    ParseBindTextByTagName(acl_language, "input", 2);
</script>
</form>
</body>
</html>