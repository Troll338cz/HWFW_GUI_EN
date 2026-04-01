<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>option82</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../resource/<%HW_WEB_Resource(diffcss.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javaScript" type="text/javascript">

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
		b.innerHTML = option82_language[b.getAttribute("BindText")];
	}

	var all = document.getElementsByTagName("span");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = option82_language[b.getAttribute("BindText")];
	}
}

function Option82(_Domain, _Enable, _Value)
{
    this.Domain  = _Domain;
    this.Enable  = _Enable;
    this.Value   = _Value;
}

function TrimArryInfo(WanIPInfoList)
{
    var list = new Array();

    for (var i = 0; i < WanIPInfoList.length-1; i++)
    {
        list[i] = WanIPInfoList[i];
    }
	
    return list;
}

var Option82List = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForISP.{i}, EnableUserId|UserId, Option82);%>;
var itemList = TrimArryInfo(Option82List);

function GetCurrentItemInfo()
{
    return new Option82("", getCheckVal("Option82Switch"), getValue("Option82Value"));  
}

function SetCurrentItemInfo(Item)
{
	setCheck("Option82Switch", Item.Enable);
    setText("Option82Value",   Item.Value);
}

function SetCurrentItemVisible(visible)
{
	if(visible == true)
	{
		setDisable("Option82Switch", 0);
		setDisable("Option82Value",  0);
		setDisable("Apply",  0);
		setDisable("Cancel",  0);
	}
	else
	{
		setDisable("Option82Switch", 1);
		setDisable("Option82Value",  1);
		setDisable("Apply",  1);
		setDisable("Cancel",  1);
	}
}

function UpdateUI()
{
	if(itemList.length == 0)
		return ;

	SetCurrentItemInfo(itemList[0]);
	SetCurrentItemVisible(true);
}
	
function CheckParaValid(checkItem)
{
	try
	{
		if ( 0 == checkItem.Value.length)
	    {
	         return true;
	    }

		if ( checkItem.Value.length > 12)
	    {
	         AlertEx(option82_language['bbsp_msg_invalid']);
			 return false;
	    }

		if(false == isInteger(checkItem.Value))
	    {
	        AlertEx(option82_language['bbsp_msg_invalid']);
			return false;
	    }
	}
	catch(e)
	{
		AlertEx("para invalid, msg=" + e.description);
		return false;
	}

	return true;
}

function OnModifySubmit()
{
    var ItemInfo = GetCurrentItemInfo();
	var url = '';
	var prefix = new Array('x', 'y', 'z', 'h', 'i', 'j', 'k', 'l');
		
    if(false == CheckParaValid(ItemInfo))
		return false;	
	
    var Form = new webSubmitForm();
	for(var i = 0; i< itemList.length; i++)
	{
		Form.usingPrefix(prefix[i]);
		Form.addParameter('EnableUserId', ItemInfo.Enable);
		Form.addParameter('UserId', ItemInfo.Value);
		Form.endPrefix();
		
		url += prefix[i] + "=" + itemList[i].Domain + '&';
	}
	url = 'set.cgi?' + url + 'RequestFile=html/bbsp/ispssid/ispssid.asp';
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction(url);
    Form.submit();

	return true;
}

function OnApply()
{
    return OnModifySubmit();
}

function OnCancel()
{
	UpdateUI();
	
	return true;
}

window.onload = function()
{   
	loadlanguage();
	UpdateUI();
}
</script>
</head>
<body class="mainbody">  
<table border="0" cellpadding="0" cellspacing="0" id="tabTest" width="100%"> 
  <tr> 
    <td class="prompt"><table> 
        <tr> 
          <td  class="title_common" BindText='bbsp_title'>  </td> 
        </tr> 
      </table></td> 
  </tr> 
  <tr> 
    <td class="height5p"></td> 
  </tr> 
</table> 

<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
  <tr> 
    <td class="table_title per_20_25" BindText='bbsp_row1'></td> 
    <td  class="table_right">
    	<input type="checkbox" value="0" id="Option82Switch"  disabled="enable"/></td> 
  </tr> 
  <tr> 
    <td class="table_title per_15_25" BindText='bbsp_row2'></td> 
    <td class="table_right" > 
		<input type="input" id="Option82Value" style="width: 300px" disabled="enable"/>
		<span class="gray" BindText='bbsp_row2_prompt'></span>
	</td> 
  </tr> 
</table> 
<table width="100%"  cellspacing="1" class="table_button"> 
  <tr> 
    <td class="width_per15"></td> 
    <td class="table_submit pad_left5p">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<button id='Apply'  type='button' onclick="javascript:return OnApply();"  class="ApplyButtoncss buttonwidth_100px" disabled="enable"><script>document.write(option82_language['bbsp_app']);</script></button>
      	<button id='Cancel' type='button' onclick="javascript:return OnCancel();" class="CancleButtonCss buttonwidth_100px" disabled="enable"><script>document.write(option82_language['bbsp_cancel']);</script></button> 
	</td> 
  </tr> 
</table> 
</body>
</html>

