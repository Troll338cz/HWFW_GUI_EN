<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_servicelist.js);%>"></script>
<style type="text/css">
.nofloat{
	float:none;
}

.contentItem{
	*text-align:left;
}

.contenbox{
	*width:300px;
	*text-align:left;
	*padding-left:10px;
}

.txt_Username{
	*padding-left:10px;
}

.textboxbg{
	*margin:auto 0px;
}

#btnpre{
	margin-left:-90px;
}
#guideskip{
	text-decoration:none;
	color:#666666;
	white-space:nowrap;
	*display:block;			
	*margin-top:-26px;		
	*margin-left:230px;		
	*text-decoration:none;	
}
a span{
	font-size:16px;
	margin-left:10px;
}
table{
	border:0px;
	cellspacing:0;
	cellpadding:0;
}
.acctablehead{
	font-size:16px;
	color:#666666;
	font-weight:bold;
}

.textbox {
	font-size: 16px;
	width: 279px;
    margin-left: 3px;
    background: none;
    border: 1px solid #ccc;
    padding: 0 2px;
}

.accountbox {
	width: 155px;
	margin:0 3px 0 13px;
}

.showpwd {
	margin: 10px 10px;
}

.ttnetDiv{
    margin-left: 354px;
    text-align: left;
}
</style>
</head>
<script language="javascript">
var inter_index = -1;
var IsSupportWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var tedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
var cfgMode ='<%HW_WEB_GetCfgMode();%>';
var PwdChangeFlag = false;
var pppoeUserNameAllFlag = false;
var oldPassword = '';
var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';
var isForceModifyPwd = window.parent.isForceModifyPwd;

function SupportTtnet()
{
    return (cfgMode.toUpperCase() == "DTTNET2WIFI" || cfgMode.toUpperCase() == "TTNET2");
}

function WANIP(domain,ipGetMode,serviceList,modeType,Tr069Flag)
{
	this.domain = domain;
	
	if (modeType.toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
		this.modeType = "BRIDGED";
	}
	else
	{
		this.modeType = "ROUTED";
	}
	
	this.ipGetMode = "DHCP";
	this.serviceList = serviceList;	
	this.Tr069Flag = Tr069Flag;
}

function WANPPP(domain,serviceList,modeType,Username,Password,IdleDisconnectTime,Tr069Flag,LastConnectionError)
{
	this.domain	= domain;
	
	if (modeType.toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
		this.modeType = "BRIDGED";
	}
	else
	{
		this.modeType = "ROUTED";
	}
   	
	this.ipGetMode = "PPPOE";
 	this.Username = Username;
  	this.Password = Password;

	this.Password = Password;
	 
  	this.IdleDisconnectTime = IdleDisconnectTime;    
  	this.serviceList = serviceList;
	this.Tr069Flag = Tr069Flag;
}
	
var WanIp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},AddressingType|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANIP);%>;
var WanPpp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},X_HW_SERVICELIST|ConnectionType|Username|Password|IdleDisconnectTime|X_HW_TR069FLAG,WANPPP);%>;

var Wan = new Array();
var g_CurrentDomain = '';

for (i=0, j=0; WanIp.length > 1 && j < WanIp.length - 1; i++,j++)
{
  if("1" == WanIp[j].Tr069Flag)
	{
		  i--;
    	continue;
	}
	Wan[i]	= WanIp[j];
}

for (j=0; WanPpp.length > 1 && j<WanPpp.length - 1; i++,j++)
{
	if("1" == WanPpp[j].Tr069Flag)
	{
		  i--;
    	continue;
	}
	Wan[i]	= WanPpp[j];
}

function CheckForm()
{
	var Username = document.getElementById('AccountValue').value;
	var Password = document.getElementById('PwdValue').value;
	if(IsTedata == 1)
	{
		if (Username.length > 15)
		{
			AlertEx(Languages['UserNameTedata1']);         
            return false;
		}
		else if (!isNum(Username))
		{
			AlertEx(Languages['UserNameTedata2']);
            return false; 
		} 
	}
	else
	{
		if ((Username != '') && (isValidAscii(Username) != ''))        
		{  
			AlertEx(guideinternet_language['bbsp_userh'] + Languages['Hasvalidch'] + isValidAscii(Username) + '".');          
			return false;       
		}
	}
	if ((Password != '') && (isValidAscii(Password) != ''))      
	{  
		AlertEx(guideinternet_language['bbsp_pwdh'] + Languages['Hasvalidch'] + isValidAscii(Password) + '".');          
		return false;       
	}
    if (cfgMode.toUpperCase() == "DETHMAXIS") {
        var ConfirmPassword = document.getElementById('ConfirmPwdValue').value;
        if (ConfirmPassword != Password) {
            AlertEx(guideinternet_language['bbsp_confirmpwd_error']);
            return false;
        }
    }
	return true;
}

function ShowNoneWan()
{
	setText('AccountValue', "");
	setText('PwdValue', "");
	
	setDisable('AccountValue', 1);
	setDisable('PwdValue', 1);	
    if (cfgMode.toUpperCase() == "DETHMAXIS") {
        setText('ConfirmPwdValue', "");
        setDisable('ConfirmPwdValue', 1);
    }
	return;
}

function ParseUsernameForTtnet(userName)
{
    var viewusrnm = '';
    var temp;
    var viewUserName = userName;

    var postFix = "@ttnet";

    if (userName.indexOf(postFix) >= 0) {
        if (userName.substring(userName.length - postFix.length) == postFix) {
            viewUserName =  userName.substring(0, userName.length - postFix.length);
            pppoeUserNameAllFlag = false;
        } else {
            pppoeUserNameAllFlag = true;
        }
    } else {
        pppoeUserNameAllFlag = true;
    }
    return viewUserName;
}

function filterChooseWan()
{
	var i = 0;
	var DisablePppInput = 1;
	
	for (i = 0; i < Wan.length; i++)
	{
		if ((ProductType == '2') || (tedataGuide == 1))
		{
			if ((Wan[i].serviceList.toString().toUpperCase().indexOf("INTERNET") < 0)
				|| (Wan[i].ipGetMode.toUpperCase() != "PPPOE"))
			{
				continue;
			}
		}
		else
		{
			if ((Wan[i].serviceList.toString().toUpperCase().indexOf("INTERNET") < 0)
			 || (Wan[i].serviceList.toString().toUpperCase().indexOf("TR069") >= 0)
			 || (Wan[i].serviceList.toString().toUpperCase().indexOf("VOIP") >= 0)
	         || (Wan[i].ipGetMode.toUpperCase() != "PPPOE"))
			{
				continue;
			}
		}
		if ((Wan[i].modeType != "ROUTED") && (Wan[i].modeType != "BRIDGED"))
		{
			continue;
		}
		
		g_CurrentDomain = Wan[i].domain;  
		inter_index = i;
		if (IsTedata == 1)
		{
			var temUsername = ParseUsernameFortedata(Wan[i].Username);
			setText('AccountValue', temUsername);
			setText('PwdValue', "********");
		}
		else
		{
            if (SupportTtnet()) {
                setText("AccountValue", ParseUsernameForTtnet(Wan[i].Username));
                ChangePPPUsernameToAll();
            } else {
                setText('AccountValue',Wan[i].Username);
            }
            setText('PwdValue', Wan[i].Password);
            oldPassword = Wan[i].Password;

            if (cfgMode.toUpperCase() == "DETHMAXIS") {
                setText('ConfirmPwdValue', Wan[i].Password);
                setDisable('ConfirmPwdValue', 0);
            }
		}
				
		setDisable('AccountValue', 0);
		setDisable('PwdValue', 0);	
		DisablePppInput = 0;	
		if ((ProductType == '2') || (tedataGuide == 1))
		{
			break;
		}
		else
		{
			if (Wan[i].serviceList == "INTERNET")
			{
				break;
			}
		}
	}
	
	return DisablePppInput;
}

function ChangePPPUsernameToAll() {
    if (pppoeUserNameAllFlag == true) {
        setDisplay("UserNameRequire", 0);
        setDisplay("TTNETTipsDef", 0);
        setDisplay("TTNETTipsAll", 1);
        $("#AccountValue").css("margin-left", "-90px");
    } else {
        setDisplay("UserNameRequire", 1);
        setDisplay("TTNETTipsDef", 1);
        setDisplay("TTNETTipsAll", 0);
        $("#AccountValue").css("margin-left", "-30px");
    }
}

function LoadFrame()
{
	ShowNoneWan();
	
	if (0 == Wan.length)
	{
		return;
	}
    if (SupportTtnet()) {
        setDisplay("TTNETTipsDef", 0);
        setDisplay("TTNETTipsAll", 0);
        setDisplay("UserNameRequire", 0);
        document.getElementById("UserNameRequire").innerHTML = "@ttnet";
        document.getElementById('UserNameTipsAll').innerHTML = guideinternet_language['ttnet_tips2'];
        $("#AccountValue").css("margin-left", "-30px");
    }
	filterChooseWan();
	
	if ((ProductType == '2') || (tedataGuide == 1))
	{
		window.parent.adjustParentHeight();	
	}
	
	if (isDnzvdf == 1) {
		$("#guidewlanconfig").css("margin-right", "60px");
	}
	return;
}

function TtnetUsernameInputClick() {
    pppoeUserNameAllFlag = true
    setDisplay("TTNETTipsDef", 0);
    setDisplay("TTNETTipsAll", 1);
    setDisplay("UserNameRequire", 0);
    $("#AccountValue").css("margin-left", "-90px");
}

function SubmitPre()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
		}
	});
	window.parent.location="../../../index.asp";
}

function WanPageTurn() {
	var tokenValue = getValue("onttoken");
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data: "pageTurn=" + "1" + "&x.X_HW_Token=" + tokenValue,
		url : "SetPageTurnStatus.cgi?1=1&RequestFile=guideinternet.asp",
		success : function() {
			window.parent.location="../../../index.asp";
		}
	});
}

function directionweb(val)
{
    if (cfgMode.toUpperCase() == "DETHMAXIS") {
        val.id = "guidevoiceconfig";
        val.name = "/html/voip/voipinterface/guidevoice.asp";
        window.parent.onchangestep(val);
        return;
    }
	if ('1' == IsSupportWifi)
	{
		if ((ProductType == '2') || (tedataGuide == 1))
		{
			val.id = "guidewlanconfig";
		}
		else
		{
			val.id = "guidewificfg";
		}
		val.name = "/html/amp/wlanbasic/guidewificfg.asp";

		if ((ProductType == '2') && isForceModifyPwd) {
			val.id = "guidecfgdone";
			val.name = "/html/ssmp/cfgguide/userguidecfgdone.asp";
		}
		window.parent.onchangestep(val); 
	}
	else
	{
		val.id = "guidesyscfg";
		val.name = "/html/ssmp/accoutcfg/guideaccountcfg.asp";
		window.parent.onchangestep(val);
	}
}

function GetWanDomains()
{
	var domains=new Array();
	
	for (var i=1; i<=Wan.length; i++)
	{
		if ((Wan[i-1].serviceList.toString().toUpperCase().indexOf("INTERNET") < 0) || (Wan[i-1].ipGetMode.toUpperCase() != "PPPOE"))
		{
			continue;
		}
		domains.push("x" + i + "=" + Wan[i-1].domain);
	}
	return domains;
}

function GetPPPoeDomains()
{
	var domains=new Array();
	for (var i=1; i<=Wan.length; i++)
	{
		if ((Wan[i-1].serviceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (Wan[i-1].ipGetMode.toUpperCase() == "PPPOE"))
		{
			domains.push("x" + i + "=" + Wan[i-1].domain);
			break;
		}
	}
	return domains;
}

function GetWanParas()
{
	var paras = new Array();

    var account = "";
    
    if ((pppoeUserNameAllFlag == false) && (SupportTtnet())) {
        account = getValue('AccountValue') + "@ttnet";
    } else {
        account = getValue('AccountValue');
    }

	var pwd = getValue('PwdValue');
	
	for (var i=1; i<=Wan.length; i++)
	{
		if ((Wan[i-1].serviceList.toString().toUpperCase().indexOf("INTERNET") < 0) || (Wan[i-1].ipGetMode.toUpperCase() != "PPPOE"))
		{
			continue;
		}

        paras.push(new stSpecParaArray("x" + i + ".Username",account, 0));
        if (oldPassword != pwd) {
            paras.push(new stSpecParaArray("x" + i + ".Password",pwd, 0));
        }
    }

    return paras;
}

function GetPPPoeParas()
{
	var paras = new Array();
	var account = getValue('AccountValue') + '@tedata.net.eg';
	var pwd = getValue('PwdValue');
	if (PwdChangeFlag == false)
	{
		pwd = Wan[inter_index].Password;
	}
	else if(getElById("showPwd").checked == true)
	{
		pwd = getValue('ShowPwdValue');
	}

	for (var i=1; i<=Wan.length; i++)
	{
		if ((Wan[i-1].serviceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (Wan[i-1].ipGetMode.toUpperCase() == "PPPOE"))
		{
			paras.push(new stSpecParaArray("x" + i + ".Username",account, 0));
			paras.push(new stSpecParaArray("x" + i + ".Password",pwd, 0));
			break;
		}
	}
	return paras;
}

function SubmitNext(val)
{
	if (IsTedata == 1)
	{
		var domains = GetPPPoeDomains();
		var paras = GetPPPoeParas();
	}
	else if (ProductType == '2')
	{
		var domains = GetWanDomains();
		var paras = GetWanParas();
	}
	else
	{
		var domains = "";
		var paras = "";
	}
	
	if (false == CheckForm())
	{
		return false;
	}
	

	if (-1 != inter_index)
	{
		var guideConfigParaList = new Array(new stSpecParaArray("x.Username",getValue('AccountValue'), 0),
									  new stSpecParaArray("x.Password",getValue('PwdValue'), 0));
											  
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		
		if (ProductType == '2' || IsTedata == 1)
		{
			Parameter.SpecParaPair = paras;
			var ConfigUrl = "setajax.cgi?" + domains.join("&") + '&RequestFile=/html/bbsp/guideinternet/guideinternet.asp';		
		}
		else
		{
			Parameter.SpecParaPair = guideConfigParaList;
	
			var ConfigUrl = "setajax.cgi?x=" + Wan[inter_index].domain + '&RequestFile=/html/bbsp/guideinternet/guideinternet.asp';							  
		}
		
		var tokenvalue = getValue('onttoken');
		HWSetAction("ajax", ConfigUrl, Parameter, tokenvalue);
	}
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
		}
	});
	directionweb(val);
}

function onskip(val)
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
		}
	});
	directionweb(val);
}

function ShowPasswd()
{
	var wanPwd = "";
	var showWanPwd = "";
	if (getElById("showPwd").checked == true)
	{
		wanPwd = getValue("PwdValue");
		getElById("ShowPwdValue").value = wanPwd;
		setDisplay("PwdValue", 0);
		setDisplay("ShowPwdValue", 1);
	}
	else
	{
		showWanPwd = getValue("ShowPwdValue");
		getElById("PwdValue").value = showWanPwd;
		setDisplay("PwdValue", 1);
		setDisplay("ShowPwdValue", 0);
	}
}

function PwdChange()
{
	PwdChangeFlag = true;
}

function OnFocus()
{
	if (PwdChangeFlag == false)
	{
		setText("PwdValue", "");
		setText("ShowPwdValue", "");
	}
}

function OnBlur()
{
	if (PwdChangeFlag == false)
	{
		setText('PwdValue', "********");
		setText("ShowPwdValue", "********");
	}
}

function guide_pre(obj)
{
    obj.name = "/html/ssmp/vlanprofileswitch/vlanprofileswitch.asp?cfgguide=1";
    obj.id = "guidewancfg";

	if ((ProductType == '2') && isForceModifyPwd) {
		obj.name = "../../html/amp/wlanbasic/guidewificfg.asp";
		obj.id = "guidewificfg";
	}
    window.parent.onchangestep(obj);
}

</script>
<body onload="LoadFrame();" style="background-color: #ffffff; overflow-x:hidden; overflow-y:hidden;" scroll="no">  
<div align="center">
	<script>
		if ((ProductType == '2') || (tedataGuide == 1))
		{
			document.write('<table width="100%">');
		}
		else
		{
			document.write('<table width="550px" style="margin-left:270px;">');
		}
	</script>
		<tr>
			<td height="35px"></td>
		</tr>
		<script>
			if ((ProductType == '2') || (tedataGuide == 1))
			{
				document.write('<tr align="center">');
			}
			else
			{
				document.write('<tr align="left">');
			}		
			if (1 == filterChooseWan())
			{
				document.write('<td class="acctablehead" BindText="bbsp_nopppwan"></td>');
			}
			else if (IsTedata == 1)
			{
				document.write('<td class="acctablehead" BindText="bbsp_title_dtedata"></td>');
			} else if (cfgMode.toUpperCase() == "DETHMAXIS") {
				document.write('<td class="acctablehead" BindText="bbsp_title_maxis"></td>');
			} else if (cfgMode.toUpperCase() == "DNZVDF2WIFI") {
				document.write('<td class="acctablehead" BindText="bbsp_title_dnzvdf"></td>');
            } else
			{
				document.write('<td class="acctablehead" BindText="bbsp_title"></td>');
			}
		</script>

		</tr>
	</table>

<div id="userinfo">
	<div id="username" class="contentItem nofloat">
			<script>
				if (1 == filterChooseWan())
				{
					document.write('<div class="labelBox"><font color ="grey"></div>');
				}
				else if (IsTedata == 1)
				{
					document.write('<div class="labelBox" style="margin-left:142px;"><span id="user" BindText="bbsp_user_dtedata"></span></div>');
				} else if (cfgMode.toUpperCase() == "DETHMAXIS") {
                    document.write('<div class="labelBox" style="margin-left:100px;"><span id="user" BindText="bbsp_user_maxis"></span></div>');
                } else
				{
					document.write('<div class="labelBox"><span id="user" BindText="bbsp_user"></span></div>');
				}
			</script>
		<div class="contenbox nofloat">
			<script>
				if (IsTedata == 1)
				{
					document.write('<input type="text" disabled="disabled" id="AccountValue" name="AccountValue" style="line-height:34px;height:34px;" class="textbox accountbox" maxlength="64"/>');
					document.write('<span style="color:#666;">@tedata.net.eg</span>');
				}
				else
				{
					document.write('<input type="text" disabled="disabled" id="AccountValue" name="AccountValue" style="line-height:34px;" class="textboxbg" maxlength="64"/>');
                    if (SupportTtnet()) {
                        document.write('<span id="UserNameRequire" style="color:grey;margin-left:7px;"></span>');
                    }
				}
			</script>
		</div>
    </div>
    <script>
        if (SupportTtnet()) {
            document.write('<div id="TTNETTipsDef" class="nofloat ttnetDiv"><span bindText="ttnet_tips1"></span><input id="clickBtn" type="button" value="click here" onClick="TtnetUsernameInputClick()" /></div>');
            document.write('<div id="TTNETTipsAll" class="nofloat ttnetDiv"><span id="UserNameTipsAll" style="color:black;"></span></div>');
        }
    </script>
	<div id="userpwd" class="contentItem nofloat">
		<script>
			if (1 == filterChooseWan())
			{
				document.write('<div class="labelBox"> <font color ="grey"></div>');
			}
			else if (IsTedata == 1)
			{
				document.write('<div class="labelBox" style="margin-left: 155px"> <span id="userpassword" BindText="bbsp_pwd_dtedata"></span></div>');
			} else if (cfgMode.toUpperCase() == "DETHMAXIS") {
                document.write('<div class="labelBox" style="margin-left:100px;"><span id="user" BindText="bbsp_pwd_maxis"></span></div>');
            } else
			{
				document.write('<div class="labelBox"> <span id="userpassword" BindText="bbsp_pwd"></span></div>');
			}
		</script>
		<div class="contenbox nofloat">
			<script>
				if (IsTedata == 1)
				{
					document.write('<input type="password" autocomplete="off" id="PwdValue" name="PwdValue" class="textbox" style="font-size:14px;line-height:34px;height:34px;" maxlength="64" onFocus="OnFocus();" onChange="PwdChange();" onBlur="OnBlur();"/>');
					document.write('<input type="text" autocomplete="off" id="ShowPwdValue" name="ShowPwdValue" class="textbox" style="display:none; font-size:14px; line-height:34px;" maxlength="64" onFocus="OnFocus();" onChange="PwdChange();" onBlur="OnBlur();"/>');
				}
				else
				{
					document.write('<input type="password" autocomplete="off" id="PwdValue" name="PwdValue" class="textboxbg" style="font-size:14px;line-height:34px;" maxlength="64"/>');
				}
			</script>
		</div>
	</div>
		<script>
			if (IsTedata == 1)
			{
				document.write('<div class="nofloat showpwd"><span style="color:#666; font-size: 14px; margin:0 38px 0 -286px;">' + guideinternet_language["bbsp_showpwd"] + '</span><input id="showPwd" type="checkbox" onClick="ShowPasswd()"></div>');
				document.write('<div class="nofloat"><a style="font-size:14px; color:#F00; cursor:pointer; margin-left: -10px;"  onclick="WanPageTurn()">' + guideinternet_language["bbsp_advancesetup"] + '</a></div>');
			} else if (cfgMode.toUpperCase() == "DETHMAXIS") {
                document.write('<div id="userconfirmpwd" class="contentItem nofloat">');
                document.write('<div class="labelBox" style="margin-left:100px;"><span id="user" BindText="bbsp_confirmpwd_maxis"></span></div>');
                document.write('<div class="contenbox nofloat">');
                document.write('<input type="password" autocomplete="off" id="ConfirmPwdValue" name="ConfirmPwdValue" class="textboxbg" style="font-size:14px;line-height:34px;" maxlength="64"/>');
                document.write('</div>');
                document.write('</div>');
            }
		</script>
	<div class="contentItem btnGuideRow nofloat">
		<div class="labelBox"></div>
		<div class="contenbox nofloat">
			<script>
				if (cfgMode.toUpperCase() == "DETHMAXIS") {
                    document.write('<input type="button" id="btnpre" name="/html/ssmp/vlanprofileswitch/vlanprofileswitch.asp?cfgguide=1"     class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);" BindText="bbsp_pre">');
                    document.write('<input type="button" id="guidevoiceconfig" name="/html/voip/voipinterface/guidevoice.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitNext(this);" BindText="bbsp_next">');
                    document.write('<a id="guideskip" name="/html/voip/voipinterface/guidevoice.asp" href="#" onClick="onskip(this);">');
                } else {
                    if (isDnzvdf != 1) {
						if ((ProductType == '2') && isForceModifyPwd) {
							document.write('<input id="guidewificfg" name="../../html/amp/wlanbasic/guidewificfg.asp" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);" BindText="bbsp_pre">');
						} else {
							document.write('<input type="button" id="btnpre" name="/html/amp/wlanbasic/guidewificfg.asp" class="CancleButtonCss buttonwidth_100px" onClick="SubmitPre(this);" BindText="bbsp_exit">');
						}
                    }

                    if ((ProductType == '2') || (tedataGuide == 1)) {
						if (isForceModifyPwd) {
							document.write('<input type="button" id="guidecfgdone" name="/html/ssmp/cfgguide/userguidecfgdone.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitNext(this);" BindText="bbsp_next">');
						} else {
							document.write('<input type="button" id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitNext(this);" BindText="bbsp_next">');
						}
                    } else {
                        document.write('<input type="button" id="guidewificfg" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitNext(this);" BindText="bbsp_next">');
                    }

                    if (isDnzvdf != 1) {
                      document.write('<a id="guideskip" name="/html/amp/wlanbasic/guidewificfg.asp" href="#" onClick="onskip(this);">');
                    }
                }
			</script>
				<span BindText="bbsp_skip"></span>
			</a>
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		</div>
	</div>
</div>
	<script>
		ParseBindTextByTagName(guideinternet_language, "span",  1);
		ParseBindTextByTagName(guideinternet_language, "td",    1);
		ParseBindTextByTagName(guideinternet_language, "input", 2);
	</script>
</div>
</body>
</html>
