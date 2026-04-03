<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>

<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<style>
.SelectDdns{
	width: 260px;
}
.SelectLtr{
	width: 260px;
	direction:ltr;
}
.InputDdns{
	width: 254px;
}
.InputLtr{
	width: 254px;
	direction:ltr;
}
</style>
<script>
function GetCurrentLoginIP()
{
    var CurUrlIp = (window.location.host).toUpperCase();
    CurUrlIp = CurUrlIp.replace(/[\[\]]/g, "");

    return CurUrlIp;
}

function Br0IPv6AddressClass(domain, IPv6Address)
{
    this.domain = domain;
    this.IPv6Address = IPv6Address;
}

var Temp1 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetBr0Ipv6Address,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Address.{i},IPv6Address, Br0IPv6AddressClass);%>;
var Br0IPv6Address = Temp1[0];

function BindPageData()
{
    setText("IPv6Address", Br0IPv6Address.IPv6Address);
    return true;

}

function OnPageLoad()
{
    BindPageData();
    
    setDisable('IPv6Address',1);
    setDisable('ButtonApply',1);
    setDisable('ButtonCancel',1);

    return true;
}
    
function CheckParameter()
{ 
    var result = true;
    var IPAddress = getValue("IPv6Address");
    
    if (IPAddress.length == 0)
    {
        AlertEx(lan_address_language['bbsp_ipv6isreq']);
        return false;
    }

    if (IsIPv6AddressValid(IPAddress) == false)
    {
        AlertEx(lan_address_language['bbsp_ipv6invalid']);
        return false;
    }

    if (IsIPv6MulticastAddress(IPAddress) == true)
    {
        AlertEx(lan_address_language['bbsp_ipv6invalid']);
        return false;  
    } 

    if (IsIPv6ZeroAddress(IPAddress) == true)
    {
        AlertEx(lan_address_language['bbsp_ipv6invalid']);
        return false;
    }

    if (IsIPv6LoopBackAddress(IPAddress) == true)
    {
        AlertEx(lan_address_language['bbsp_ipv6invalid']);
        return false;  
    }

    if ((Br0IPv6Address.IPv6Address.toUpperCase() == GetCurrentLoginIP())
        && (getValue('IPv6Address').toUpperCase() != Br0IPv6Address.IPv6Address.toUpperCase()))
    {
        result = ConfirmEx(lan_address_language['bbsp_confirmnote']);
    }

    if ( result == true )
    {
        setDisable('ButtonApply', 1);
        setDisable('ButtonCancel', 1);
    }
    
    return result; 
}


function OnApplyButtonClick()
{
    if (CheckParameter() == false)
    {
        return false;
    }

    var url = "";
    var Form = new webSubmitForm();

    Form.addParameter('x.IPv6Address', getValue("IPv6Address"));
  
    url = 'x='+Br0IPv6Address.domain;

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    Form.setAction('set.cgi?' + url + '&RequestFile=html/bbsp/lanaddress/lanaddress.asp');
    Form.submit();
 
    setDisable('ButtonApply',1);
    setDisable('ButtonCancel',1);
    return false;
}

function OnCancelButtonClick()
{       
    BindPageData();
    return false;
}


</script>
<title>LAN Address Configuration</title>
</head>
<body  class="mainbody" onload="OnPageLoad();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("lanaddress", GetDescFormArrayById(lan_address_language, "bbsp_cutmune"), GetDescFormArrayById(lan_address_language, "bbsp_lan_addresscut_title"), false);
</script>
<div class="title_spread"></div>

<form id="InterfaceAddrInfoForm" name="InterfaceAddrInfoForm">
<table id="InterfaceAddrInfoFormPanel" border="0" cellpadding="0" cellspacing="1"  width="100%"> 
<li id="IPv6Address" RealType="TextBox" DescRef="bbsp_ipv6mh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.IPv6Address" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
</table>
<script>
	var TableClass = new stTableClass("table_title align_left width_per25", "table_right align_left width_per75");
	var InterfaceAddrInfoFormList = new Array();
	InterfaceAddrInfoFormList = HWGetLiIdListByForm("InterfaceAddrInfoForm",null);
	HWParsePageControlByID("InterfaceAddrInfoForm",TableClass,lan_address_language,null);
</script>
</form>

	
  <table id="ConfigPanelButtons" width="100%"  cellspacing="1" class="table_button"> 
    <tr>
      <td class='width_per25'> </td> 
      <td class="table_submit pad_left5p"> <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      
	  <input class="ApplyButtoncss buttonwidth_100px" name="ButtonApply" id= "ButtonApply" type="button" BindText="bbsp_app" onClick="javascript:return OnApplyButtonClick();"> 
	  <input class="CancleButtonCss buttonwidth_100px" name="ButtonCancel" id="ButtonCancel" type="button" BindText="bbsp_cancel" onClick="javascript:OnCancelButtonClick();"></td> 
    </tr> 
  </table> 
  <div style="height:10px;"></div>

<script>
ParseBindTextByTagName(lan_address_language, "td",    1);
ParseBindTextByTagName(lan_address_language, "input", 2);
</script> 
</body>
</html>
