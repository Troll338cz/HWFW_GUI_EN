<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" type="text/javascript">
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
function stCardCfgInfo(domain,EnablePin,DataCardVendor,DataCardSwVesion,DataCardHdVesion,Mode,WorkMode,PinStates,PinRemainTimes,PukRemainTimes)
{
	this.domain = domain;
	this.EnablePin = EnablePin;
	this.DataCardVendor = DataCardVendor;
	this.DataCardSwVesion = DataCardSwVesion;
	this.DataCardHdVesion = DataCardHdVesion;
	this.Mode = Mode;
	this.WorkMode = WorkMode;
	this.PinStates = PinStates;
	this.PinRemainTimes = PinRemainTimes;
	this.PukRemainTimes = PukRemainTimes;
}

function stSignalStrength(domain,SignalStrength)
{
	this.domain = domain;
	this.SignalStrength = SignalStrength;
}


var stCardCfgInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage, EnablePin|DataCardVendor|DataCardSwVesion|DataCardHdVesion|Mode|WorkMode|PinStates|PinRemainTimes|PukRemainTimes, stCardCfgInfo);%>;
CardCfgInfo = stCardCfgInfos[0];
var stSignalStrength = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Radio_WAN_Stats, SignalStrength, stSignalStrength);%>;
SignalInfo = stSignalStrength[0];

function LteGetNetModeAbbility(netMode2G, netMode3G, netMode4G, netMode5G, netModeAuto) {
    this.netMode2G = netMode2G;
    this.netMode3G = netMode3G;
    this.netMode4G = netMode4G;
    this.netMode5G = netMode5G;
    this.netModeAuto = netModeAuto;
}

var lteNetModeAbbilityResult = <%WEB_GetNetModeAbbility();%>;

function GetLanguageDesc(Name)
{
    return XGManageDes[Name];
}
function LoadFrame()
{ 	
	if(null==CardCfgInfo)
	{
		document.getElementById('ProductVersion').innerHTML = '--';
		document.getElementById('SoftWareVersion').innerHTML = '--';
		document.getElementById('HardWareVersion').innerHTML = '--';
		document.getElementById('currentnet').innerHTML = '--';
		document.getElementById('cfgnet').innerHTML = '--';
		document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211a");
		if ('BELTELECOMSMART' == CfgMode.toUpperCase())
		{
			document.getElementById('signalstrength').innerHTML = '--';
		}
		return;
	}
	
	 if(CardCfgInfo.PinStates == 5)
	 {
		document.getElementById('ProductVersion').innerHTML = '--';
		document.getElementById('SoftWareVersion').innerHTML = '--';
		document.getElementById('HardWareVersion').innerHTML = '--';
		document.getElementById('currentnet').innerHTML = '--';
		document.getElementById('cfgnet').innerHTML = '--';
		document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211a");
		if ('BELTELECOMSMART' == CfgMode.toUpperCase())
		{
			document.getElementById('signalstrength').innerHTML = '--';
		}
		return;
	 }
 	
	document.getElementById('ProductVersion').innerHTML = htmlencode(CardCfgInfo.DataCardVendor);
	document.getElementById('SoftWareVersion').innerHTML = htmlencode(CardCfgInfo.DataCardSwVesion);
	document.getElementById('HardWareVersion').innerHTML = htmlencode(CardCfgInfo.DataCardHdVesion);
	
	if(CardCfgInfo.PinStates == 6)
	{
		document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s2123");
		document.getElementById('currentnet').innerHTML = '--';
		document.getElementById('cfgnet').innerHTML = '--';
		if ('BELTELECOMSMART' == CfgMode.toUpperCase())
		{
			document.getElementById('signalstrength').innerHTML = '--';
		}
		return;
	}
	 
	if(CardCfgInfo.PinStates == 7)
	 {
		document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s0905");
		document.getElementById('currentnet').innerHTML = '--';
		document.getElementById('cfgnet').innerHTML = '--';
		if ('BELTELECOMSMART' == CfgMode.toUpperCase())
		{
			document.getElementById('signalstrength').innerHTML = '--';
		}
		return;
	 }

	if(CardCfgInfo.PinStates == 4)
	{
		document.getElementById('currentnet').innerHTML = '--';
		document.getElementById('cfgnet').innerHTML = '--';
		document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211a");
		setDisplay('enablepinnav', 0);
		setDisplay('disablepinnav', 0);
		setDisplay('modifypinnav', 0);
		setDisplay('deletepinnav', 0);
		setDisplay('pincodearea', 0);
		setDisplay('retryarea', 0);
		setDisplay('simsubmitnav', 0);
		if ('BELTELECOMSMART' == CfgMode.toUpperCase())
		{
			document.getElementById('signalstrength').innerHTML = '--';
		}
	}
	else
	{	
		
		SelectNetMode();
		setDisplay('cfgnetnav', 1);
		setDisplay('simnetsubmitnav', 1);
		
		if(CardCfgInfo.WorkMode==2)
		{
			document.getElementById('currentnet').innerHTML = GetLanguageDesc("s2108");
		}
		else if(CardCfgInfo.WorkMode==3)
		{
			document.getElementById('currentnet').innerHTML = GetLanguageDesc("s2109");
		}
		else if(CardCfgInfo.WorkMode==4)
		{
			document.getElementById('currentnet').innerHTML = GetLanguageDesc("s210a");
		}
		else
		{
			document.getElementById('currentnet').innerHTML = '--';
		}
		if ('BELTELECOMSMART' == CfgMode.toUpperCase())
		{
			document.getElementById('signalstrength').innerHTML = htmlencode(SignalInfo.SignalStrength);
		}
	
		if(CardCfgInfo.PukRemainTimes==0)
		{	
			document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211b");
			setDisplay('enablepinnav', 0);
			setDisplay('disablepinnav', 0);
			setDisplay('modifypinnav', 0);
			setDisplay('deletepinnav', 0);
			setDisplay('pincodearea', 0);
			setDisplay('retryarea', 0);
			setDisplay('simsubmitnav', 0);
		}
		else
		{
			if(CardCfgInfo.PinRemainTimes==0)
			{
				document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211c");
				setDisplay('enablepinnav', 0);
				setDisplay('disablepinnav', 0);
				setDisplay('modifypinnav', 0);
				setDisplay('deletepinnav', 0);
				setDisplay('pincodearea', 1);
				setDisplay('pukcodearea', 1);
				setDisplay('retryarea', 1);
				setDisplay('simsubmitnav', 1);
				document.getElementById('remaintimes').innerHTML = htmlencode(CardCfgInfo.PukRemainTimes);
			}
			else
			{
					if(CardCfgInfo.PinStates == 0)
					{
						document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211d");
						setDisplay('enablepinnav', 0);
						setDisplay('disablepinnav', 0);
						setDisplay('modifypinnav', 0);	
						setDisplay('deletepinnav', 0);
						setDisplay('pincodearea', 1);
						setDisplay('pukcodearea', 0);
						setDisplay('retryarea', 1);
						setDisplay('simsubmitnav', 1);
						document.getElementById('remaintimes').innerHTML = htmlencode(CardCfgInfo.PinRemainTimes);
					}
					else
					{
						if(CardCfgInfo.EnablePin==1)
						{
							document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211e");
							document.getElementById('disablepin').checked = true;
							setDisplay('enablepinnav', 0);
							setDisplay('disablepinnav', 1);
							setDisplay('modifypinnav', 1);
							setDisplay('deletepinnav', 1);
							setDisplay('pincodearea', 1);
							setDisplay('retryarea', 1);
							setDisplay('simsubmitnav', 1);
							document.getElementById('remaintimes').innerHTML = htmlencode(CardCfgInfo.PinRemainTimes);
						}
						else
						{
							document.getElementById('pinstatusarea').innerHTML = GetLanguageDesc("s211f");
							document.getElementById('enablepin').checked = true;
							setDisplay('enablepinnav', 1);
							setDisplay('pincodearea', 1);
							setDisplay('retryarea', 1);
							setDisplay('simsubmitnav', 1);
							document.getElementById('remaintimes').innerHTML = htmlencode(CardCfgInfo.PinRemainTimes);
						}
					}
			}
		}
	}

    if (lteNetModeAbbilityResult[0].netMode2G == 0) {
        setDisplay('2GMode', 0);
    }
    if (lteNetModeAbbilityResult[0].netMode3G == 0) {
        setDisplay('3GMode', 0);
    }
    if (lteNetModeAbbilityResult[0].netMode4G == 0) {
        setDisplay('4GMode', 0);
    }
    if (lteNetModeAbbilityResult[0].netModeAuto == 0) {
        setDisplay('AUTOMode', 0);
    }
}

function isDecDigit(digit) 
{
   var decVals = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
   var len = decVals.length;
   var i = 0;
   var ret = false;

   for ( i = 0; i < len; i++ )
      if ( digit == decVals[i] ) break;

   if ( i < len )
      ret = true;
   return ret;
}

function isValidNumber(number)
{
	var numberLen = number.length;
	for(var i = 0 ; i < numberLen ; i++)
	{
		if(!isDecDigit(number.charAt(i)))
		{
			return false;
		}
	}
	return true;
}

function ModifyPinEvent()
{	
	if(document.getElementById('modifypin').checked == true)
	{	
		setDisplay('pincodearea', 0);
		setDisplay('oldpincodearea', 1);
		setDisplay('newpincodearea', 1);
		setDisplay('confirmnewpin', 1);
		setText('oldpinword','');
		setText('newpinword','');
		setText('confirmpinword','');
	}
	else
	{
		setDisplay('pincodearea', 1);
		setDisplay('oldpincodearea', 0);
		setDisplay('newpincodearea', 0);
		setDisplay('confirmnewpin', 0);
		setText('pinword','');
	}
	
}

function checkpincode(value)
{
    if((value == '') || !isValidNumber(value)) {
		AlertEx(GetLanguageDesc("s21201"));
		return false;
	}
	

	return true;
	
}

function checkpukcode(value)
{
	if(value.length!=8 || !isValidNumber(value))
	{
		AlertEx(GetLanguageDesc("s2121"));
		return false;
	}
	
	return true;
}

function SubmitnetInfo()
{
	var radioValue = getRadioVal('NetMode');
	var Form = new webSubmitForm();
	setDisable('btnApplyData', 1);
	Form.addParameter('x.OptType', 6);
	Form.addParameter('x.Mode', radioValue);
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.submit();
}

function SelectNetMode()
{	
	if (CardCfgInfo.Mode == 2)
	{
		document.getElementById('2GMode').checked = true;
	}
	else if (CardCfgInfo.Mode == 3)
	{
		document.getElementById('3GMode').checked = true;
	}
	else if (CardCfgInfo.Mode == 4)
	{
		document.getElementById('4GMode').checked = true;
	}
	else
	{
		document.getElementById('AUTOMode').checked = true;
	}
}

function CancelnetConfig()
{
	SelectNetMode();
}

function SubmitpinInfo()
{	
	var OptPinValue = getRadioVal('PinMode');
	var oldpinwordvalue = getValue('oldpinword');
	var pinwordvalue = getValue('pinword');
	var pukwordvalue = getValue('pukword');
	
	if(OptPinValue=="enable")
	{
		if(!checkpincode(getValue('pinword')))
		{	
			setText('pinword','');
			return;
		}
		var Form = new webSubmitForm();
		Form.addParameter('x.OptType', 2);
		Form.addParameter('x.EnablePin', 1);
		Form.addParameter('x.PIN', getValue('pinword'));
		Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
		Form.submit();
	}
	else if(OptPinValue=="disable")
	{
		if(!checkpincode(getValue('pinword')))
		{	
			setText('pinword','');
			return;
		}
		
		var Form = new webSubmitForm();
		Form.addParameter('x.OptType', 2);
		Form.addParameter('x.EnablePin', 0);
		Form.addParameter('x.PIN', getValue('pinword'));
		Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
		Form.submit();
	}
	else if(OptPinValue=="modify")
	{
		if(!checkpincode(getValue('oldpinword')))
		{	
			setText('oldpinword','');
			setText('newpinword','');
			setText('confirmpinword','');
			return;
		}
		if(!checkpincode(getValue('newpinword')))
		{	
			setText('newpinword','');
			setText('oldpinword','');
			setText('confirmpinword','');
			return;
		}
		if(!checkpincode(getValue('confirmpinword')))
		{	
			setText('newpinword','');
			setText('oldpinword','');
			setText('confirmpinword','');
			return;
		}
		if(getValue('confirmpinword') != getValue('newpinword'))
		{	
			setText('newpinword','');
			setText('oldpinword','');
			setText('confirmpinword','');
			AlertEx(GetLanguageDesc("s2122"));
			return;
		}
		var Form = new webSubmitForm();
		Form.addParameter('x.OptType', 3);
		Form.addParameter('x.OldPIN', getValue('oldpinword'));
		Form.addParameter('x.PIN', getValue('confirmpinword'));
		Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
		Form.submit();
	}
	else if(OptPinValue=="delete")
	{
		if(!checkpincode(getValue('pinword')))
		{	
			setText('pinword','');
			return;
		}
		var Form = new webSubmitForm();
		Form.addParameter('x.OptType', 5);
		Form.addParameter('x.PIN', getValue('pinword'));
		Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
		Form.submit();
	}
	else
	{
		if(CardCfgInfo.PinRemainTimes==0&&CardCfgInfo.PukRemainTimes!=0)
		{	
			if(!checkpukcode(getValue('pukword')))
			{	
				setText('pinword','');
				setText('pukword','');
				return;
			}
			if(!checkpincode(getValue('pinword')))
			{	
				setText('pukword','');
				setText('pinword','');
				return;
			}
			var Form = new webSubmitForm();
			Form.addParameter('x.OptType', 4);
			Form.addParameter('x.PukCode', getValue('pukword'));
			Form.addParameter('x.PIN', getValue('pinword'));
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
			Form.submit();
		}
		else
		{
			if(!checkpincode(getValue('pinword')))
			{	
				setText('pinword','');
				return;
			}
			var Form = new webSubmitForm();
			Form.addParameter('x.OptType', 1);
			Form.addParameter('x.PIN', getValue('pinword'));
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage&RequestFile=html/ssmp/3GManage/3GManage.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
			Form.submit();
		}
		
	}
	
	setDisable('btnApplyLed', 1);
	return;
}

function CancelConfig()
{
	setText('oldpinword','');
	setText('pinword','');
	setText('pukcodearea','');
	setText('newpinword','');
	setText('confirmnewpin','');
	document.getElementById('disablepin').checked = true;
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<div> 
  
<script language="JavaScript" type="text/javascript">
if (IsTedata == 1) {
    HWCreatePageHeadInfo("XGManageInfo", GetDescFormArrayById(XGManageDes, "s0101_egypt"), GetDescFormArrayById(XGManageDes, "s0100_egypt"), false);
} else {
    HWCreatePageHeadInfo("XGManageInfo", GetDescFormArrayById(XGManageDes, "s0101"), GetDescFormArrayById(XGManageDes, "s0100"), false);
}
</script>
<div class="title_spread"></div>
<div class="func_title" BindText="s2101"></div>
    <table class="tabal_noborder_bg" width="100%" height="5" border="0" cellpadding="0" cellspacing="1" > 
    <tr class="table_title" > 
		<td width="220px">
          
			<script language="javascript">
				document.write(GetLanguageDesc(IsTedata == 1 ? "s2103_egypt" : "s2103"));
			</script>
		</td>
	  <td id="ProductVersion"></td> 
    </tr> 
	<tr class="table_title" > 
		<td width="220px" >
			<script language="javascript">
				document.write(GetLanguageDesc(IsTedata == 1 ? "s2104_egypt" : "s2104"));
			</script>
		</td>
	  <td id="SoftWareVersion"></td> 
    </tr>
	<tr class="table_title" > 
		<td width="220px">
			<script language="javascript">
				document.write(GetLanguageDesc(IsTedata == 1 ? "s2105_egypt" : "s2105"));
			</script>
		</td>
	  <td id="HardWareVersion"></td> 
    </tr>
	<tr class="table_title" > 
      <td width="200px" BindText="s2106"></td> 
	  <td id="currentnet"></td> 
    </tr>
	<tr class="table_title"> 
      <td width="200px" BindText="s2107"></td> 
	  <td id="cfgnet">
	  <div id="cfgnetnav" style="display:none">
	  <input type='radio' name='NetMode' id='2GMode' value="2">
      <script language="javascript">
        if (lteNetModeAbbilityResult[0].netMode2G == 1) {
            document.write( GetLanguageDesc("s2108"));
        }
      </script>
	  <input type='radio' name='NetMode' id='3GMode' value="3">
      <script language="javascript">
        if (lteNetModeAbbilityResult[0].netMode3G == 1) {
            document.write( GetLanguageDesc("s2109"));
        }
      </script>
	  <input type='radio' name='NetMode' id='4GMode' value="4">
      <script language="javascript">
        if (lteNetModeAbbilityResult[0].netMode4G == 1) {
            document.write( GetLanguageDesc("s210a"));
        }
      </script>
	  <input type='radio' name='NetMode' id='AUTOMode' value="1">
      <script language="javascript">
        if (lteNetModeAbbilityResult[0].netModeAuto == 1) {
            document.write( GetLanguageDesc("s210b"));
        }
      </script> 
	  </div>
	  </td> 
    </tr>
	<script type="text/javascript">
	if ('BELTELECOMSMART' == CfgMode.toUpperCase())
	{
		document.write('<tr class="table_title" > <td width="200px" BindText="s2124"></td> <td id="signalstrength"></td> </tr>');
	}
	</script>
  </table>   
<table class="table_button" width="100%" cellpadding="0" cellspacing="1"  id="simnetsubmitnav" style="display:none"> 
    <tr> 
	<td class="table_submit" style="width:200px;"></td> 
    <td class="table_submit"> 
      	<input  class = "ApplyButtoncss buttonwidth_100px" name="btnApplyData" id="btnApplyData" type='button' BindText="s0e08" onClick="SubmitnetInfo();"> 
		<input  class = "CancleButtonCss buttonwidth_100px" name="cancelValueData" id="cancelValueData" type='button' BindText="s0e09" onClick="CancelnetConfig();"> 
      </td> 
    </tr> 
</table> 

</div>  
<div class="func_spread"></div>
<div class="func_title" BindText="s210c"></div>

<div> 
  <table class="tabal_noborder_bg" width="100%" cellpadding="0" cellspacing="1"> 
    <tr class="table_title" >  
      <td width="200px" BindText="s210e"> 
	  </td> 
	  <td >
	  <table  border="0">
        <tr >
          <td scope="row" align="left" id="pinstatusarea"></td>
        </tr>
		<tr id="enablepinnav" style="display:none">
          <td scope="row" align="left"><input type='radio' name='PinMode' id='enablepin' value="enable"  onclick="ModifyPinEvent();">
			<script language="javascript">
			document.write( GetLanguageDesc("s210f"));
			</script> 
		</td>
        </tr>
        <tr  id="disablepinnav" style="display:none">
          <td scope="row" align="left"><input type='radio' name='PinMode' id='disablepin' value="disable"  onclick="ModifyPinEvent();">
		  <script language="javascript">
			document.write( GetLanguageDesc("s2111"));
			</script> 
		  </td>
        </tr>
        <tr id="modifypinnav" style="display:none">
          <td scope="row" align="left"><input type='radio' name='PinMode' id='modifypin' value="modify"  onclick="ModifyPinEvent();">
		  <script language="javascript">
			document.write( GetLanguageDesc("s2112"));
			</script> 
			</td>
        </tr>
		<tr id="deletepinnav" style="display:none">
          <td scope="row" align="left"><input type='radio' name='PinMode' id='deletepin' value="delete" onclick="ModifyPinEvent();">
		  <script language="javascript">
			document.write( GetLanguageDesc("s2113"));
			</script> 
			</td>
        </tr>
      </table>
	  </td> 
    </tr>  
	
	<tr class="table_title"  id="pukcodearea" style="display:none"> 
      <td width="200px" BindText="s2114"> 
	  </td> 
	  <td>   
	  <input type="password" autocomplete="off" name="pukword" id="pukword" maxlength="8">
	  </td> 
    </tr> 
	
	 <tr class="table_title"  id="pincodearea" style="display:none"> 
      <td width="200px" BindText="s2115"> 
	  </td> 
	  <td>   
	  <input type="password" autocomplete="off" name="pinword" id="pinword" maxlength="8">
	  </td> 
    </tr> 
	
	<tr class="table_title"  id="oldpincodearea" style="display:none"> 
      <td width="200px" BindText="s2116"> 
	  </td> 
	  <td>   
	  <input type="password" autocomplete="off" name="oldpinword" id="oldpinword" maxlength="8">
	  </td> 
    </tr> 
	<tr class="table_title"  id="newpincodearea" style="display:none"> 
      <td width="200px" BindText="s2117"> 
	  </td> 
	  <td>   
	  <input type="password" autocomplete="off" name="newpinword" id="newpinword" maxlength="8">
	  </td> 
    </tr>
	<tr class="table_title"  id="confirmnewpin" style="display:none"> 
      <td width="200px" BindText="s2118">   
	  </td> 
	  <td>   
	  <input type="password" autocomplete="off" name="confirmpinword" id="confirmpinword" maxlength="8">
	  </td> 
    </tr>
	
	 <tr class="table_title" id="retryarea" style="display:none">  
      <td width="200px" BindText="s2119" style="color:red">  
	  </td> 
	  <td id="remaintimes" style="color:red">  
	  </td> 
    </tr> 
  </table> 
  
<table class="table_button" width="100%" cellpadding="0" cellspacing="1"  id="simsubmitnav" style="display:none"> 
    <tr> 
	<td class="table_submit" style="width:200px;"></td> 
    <td class="table_submit">
      	<input  class = "ApplyButtoncss buttonwidth_100px" name="btnApplyLed" id="btnApplyLed" type='button'   BindText="s0e08" onClick="SubmitpinInfo();"> 
		<input  class = "CancleButtonCss buttonwidth_100px" name="cancelValueLed" id="cancelValueLed" type='button'   BindText="s0e09" onClick="CancelConfig();"> 
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    </td> 
    </tr> 
</table> 
</div> 
<br>
<br>
<br>
</body>

<script>
ParseBindTextByTagName(XGManageDes, "td",    1);
ParseBindTextByTagName(XGManageDes, "div",   1);
ParseBindTextByTagName(XGManageDes, "input", 2);
</script>

</html>
