<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<title></title>
<style>
.h3-content {
  margin-left: 40px;
  width: 90%;
  padding-bottom: 20px;
  display: table;
}
</style>
<script language="JavaScript" type="text/javascript">

var isGuidePage = false;

if(window.parent.wifiPara != null)
{
	isGuidePage = true;
}

if(isGuidePage && window.parent.wifiPara.wifiFlag)
{
	window.parent.wifiPara.wifiFlag = 0;
	window.parent.onchangestep(window.parent.wifiPara);
}

var gponpassword;
var hexgponpassword;
var sysUserType = '0';
var sptUserType = '1';
var curUserType = '<%HW_WEB_GetUserType();%>';
var setOpticCopper = 0;

function stDevInfo(domain, serialnumber, devtype,hexpassword,upPortId)
{
	this.domain = domain;
	this.serialnumber = serialnumber;    
	this.devtype = devtype;
	this.hexpassword = hexpassword;
	hexgponpassword = hexpassword;
	gponpassword = ChangeHextoAscii(hexpassword);
	this.upPortId = upPortId;
}

var stDevInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|X_HW_UpPortMode|X_HW_PonHexPassword|X_HW_UpPortID, stDevInfo);%>;

var stDevinfo = stDevInfos[0];

var stOnlineStatusInfo = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;
var isOntOnline = stOnlineStatusInfo;

var PWDINIT = '<%HW_WEB_GetSPEC(SPEC_WEB_AMP_PWDINIT.STRING);%>';

var LoidEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AmpInfo.DefaultLoidAuth);%>';

var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';
var StarhubncFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_STARHUBNC);%>';
var NCFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_NC);%>';
var AtTelecomFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELECOM);%>';
var FobidSnFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_FORBID_SN);%>';
	
function setDisplay(id, flag) {
    document.getElementById(id).style.display = (flag == 1) ? "" : "none";
}
function ShowOrHideText(checkBoxId, passwordId,textId, value)
{
	if (1 == getCheckVal(checkBoxId))
	{
		setDisplay(passwordId, 1);
		setDisplay(textId, 0);
	}
	else
	{
		setDisplay(passwordId, 0);
		setDisplay(textId, 1);
	}
}

function CheckStr(strField, strCheckStr, uiMinLen, uiMaxLen)
{
	var ret = true;
	var strTmp = "";
	var alertTmp;
	
	if (('' == strCheckStr || strCheckStr == null) && (uiMinLen > 0))
	{
		strTmp = "";
		strTmp = strField + cfg_ontauth_language['amp_auth_chklen1'] + uiMinLen + cfg_ontauth_language['amp_auth_chklen2'] + uiMaxLen + cfg_ontauth_language['amp_auth_chklen3'];
		AlertEx(strTmp);
		return false;
	}

    if(false == isSafeStringExc(strCheckStr,''))
    {
        strTmp = "";
        strTmp = strField + cfg_ontauth_language['amp_auth_chk6'] + strCheckStr + cfg_ontauth_language['amp_auth_chk7'] + cfg_ontauth_language['amp_auth_chk5'];
        AlertEx(strTmp);
        return false;	
    }
	
    if ((uiMaxLen < strCheckStr.length) || (uiMinLen > strCheckStr.length))
    {
        strTmp = "";
        strTmp = strField + cfg_ontauth_language['amp_auth_chklen1'] + uiMinLen + cfg_ontauth_language['amp_auth_chklen2'] + uiMaxLen + cfg_ontauth_language['amp_auth_chklen3'];
        AlertEx(strTmp);
        return false;
    }   
	
    if('<%HW_WEB_GetCurrentLanguage();%>'.toUpperCase() == 'CHINESE')
    {
        if(strCheckStr.length != 0)
    	{
        	if ((strCheckStr.charAt(0) == ' ' ) || (strCheckStr.charAt(strCheckStr.length -1) == ' '))
        	{
        	    alertTmp = cfg_ontauth_language['amp_auth_blank_alert1'] + strField + cfg_ontauth_language['amp_auth_blank_alert2'];

            	if(false == confirm(alertTmp))
            	{
            		return false;
            	}
        	}
    	}
    }	

    return ret;
}


function conv12to16HexSn(SerialNum)
{
	var charVid = "";
	var hexVid = "";
	var vssd = "";
	var i;
	
	charVid = SerialNum.substr(0,4);
	vssd = SerialNum.substr(4,8);

	for(i=0; i<4; i++)
	{
		hexVid += charVid.charCodeAt(i).toString(16);
	}	
	
	return hexVid+vssd;
}

function conv16to12Sn(SerialNum)
{
	var charVid = "";
	var hexVid = "";
	var vssd = "";
	var i;

	hexVid = SerialNum.substr(0,8);
	vssd = SerialNum.substr(8,8);
	
	for(i=0; i<8; i+=2)
	{
		charVid += String.fromCharCode("0x"+hexVid.substr(i, 2));
	}

	return charVid+vssd;
}

function refreshPasswordMode()
{
    if (0 == getSelectVal('Passwordmode'))
    {
        setDisplay("TrHexPassword",0);		
        getElById("PwdGponValue").value = ChangeHextoAscii(stDevinfo.hexpassword);
        getElById("tPwdGponValue").value = ChangeHextoAscii(stDevinfo.hexpassword);
        top.Passwordmode=0;
    }
    else if (1 == getSelectVal('Passwordmode'))
    {
        setDisplay("TrHexPassword",1);
        setText('HexPwdValue', stDevinfo.hexpassword);
        setText('tHexPwdValue', stDevinfo.hexpassword);
        top.Passwordmode=1;
    }

    
    top.changeMethod = 2;
}

function onClickMethod()
{   
    if ((1 == getRadioVal("rMethod")))
    {
        setDisplay("TrHexPassword",0);

        setDisable('SNValue',0);
        top.changeMethod = 1;
    }

    if (2 == getRadioVal("rMethod"))
    {
        hexgponpassword = stDevinfo.hexpassword;
        gponpassword = ChangeHextoAscii(stDevinfo.hexpassword);
        refreshPasswordMode();
        if (1 == TelMexFlag)
        {
            setText("SNValue1", conv16to12Sn(stDevinfo.serialnumber.substr(0,8)));
            setText('SNValue2', stDevinfo.serialnumber.substr(8,8));
        }
        else
        {
            setText('SNValue', stDevinfo.serialnumber);	
        }
    }
}



function OnChangeMode1()
{
	if(0 == getSelectVal('Passwordmode'))
	{
		setDisplay("TrHexPassword",0);		
		getElById("PwdGponValue").value = gponpassword;
		getElById("tPwdGponValue").value = gponpassword;
		top.Passwordmode=0;
	}
	else if(1 == getSelectVal('Passwordmode'))
	{
		setDisplay("TrHexPassword",1);
		setText('HexPwdValue', hexgponpassword);
		setText('tHexPwdValue', hexgponpassword);
		top.Passwordmode=1;
	}
}

function ChangeHextoAscii(hexpasswd)
{
	var str;
	var len = 0;
	
	len = hexpasswd.length;

	if (0 != len%2)
	{
		hexpasswd += "0";
	}
	
	str = hexpasswd.replace(/[a-f\d]{2}/ig, function(m){
	return String.fromCharCode(parseInt(m, 16));});

	return str;
}

function ChangeAsciitoHex(passwd)
{
	var hexstr = "";
	var temp = "";
	var code = 0;
	for (var i = 0; i < passwd.length; i++)
	{
		code = parseInt(passwd.charCodeAt(i));
		if (code < 16)
		{
		    hexstr += "0";
			hexstr += code.toString(16);
		} 
		else
		{
		    hexstr += code.toString(16);
		}
	}
	
	return hexstr;	
}

function CheckHexPassWord()
{
	var ret = true;
	var len = 0;
	var i;
	var temp1 = 0;
	var temp2 = 0;
	with (getElById('ConfigForm'))
	{		
		var hexpassword = getValue('HexPwdValue');
		
		len = hexpassword.length;
		
		if (20 < hexpassword.length)
		{
			AlertEx(cfg_ontauth_language['amp_hexpaswd_chk1']);
			return false;
		}
	
		if (0 != len%2)
		{
			AlertEx(cfg_ontauth_language['amp_hexpaswd_chk1']);
			return false;
		}

  
		if (isHexaNumber(hexpassword) == false)
		{
			AlertEx(cfg_ontauth_language['amp_hexpaswd_chk2']);
			return false;
		}

	}
	return ret;
}

function IsLogicIDSupport()
{
    if (('<%HW_WEB_GetCurrentLanguage();%>' == "chinese") || (LoidEnable == 1))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function AddSubmitParam()
{
	var upPortId = getElementById("Uplinkmode_show").innerHTML
	var asciiPasswd = getElById("tPwdGponValue").value;
	var sendUpMode;
	var sendUpPort;
	var sendPasswd;
	var parainfo="";
	var Form = new webSubmitForm();
	
	if (upPortId == cfg_ontauth_language['amp_auth_fiber_mode']) {
		sendUpMode='1';
		sendUpPort='1056769';
	} else {
		sendUpMode='3';
		sendUpPort='4';
	}
	sendPasswd = ChangeAsciitoHex(asciiPasswd);
	
	Form.addParameter('x.X_HW_UpPortMode',sendUpMode);
	Form.addParameter('x.X_HW_UpPortID',sendUpPort);
	Form.addParameter('x.X_HW_PonHexPassword',sendPasswd);
	Form.addParameter('x.X_HW_ForceSet',1);
	Form.addParameter('x.X_HW_Token', getValue('hwonttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo' 
					+ '&RequestFile=html/amp/ontauth/newvdfpassword.asp');
	Form.submit();
}

function isHexaNumber(number)
{
    for (var index = 0; index < number.length; index++)
    {
        if (isHexaDigit(number.charAt(index)) == false)
        {
            return false;
        }
    }
    return true;
}

function init()
{   
	var method;
	
	setRadio("rMethod",2);
	hexgponpassword = stDevinfo.hexpassword;
	gponpassword = ChangeHextoAscii(stDevinfo.hexpassword);
	if ((1 == NCFlag) || (1 == StarhubncFlag))
	{
		top.Passwordmode = 0; 
	}

	if (stDevinfo != null)
	{	
		password = ChangeHextoAscii(stDevinfo.hexpassword);

        getElById("PwdGponValue").value = password;
        getElById("tPwdGponValue").value = password;
        setText('HexPwdValue', stDevinfo.hexpassword);    
        setText('tHexPwdValue', stDevinfo.hexpassword);           
        if (1 == TelMexFlag)
        {
            setText("SNValue1", conv16to12Sn(stDevinfo.serialnumber.substr(0,8)));
	        setText('SNValue2', stDevinfo.serialnumber.substr(8,8));
        }
        else
        {
            setText('SNValue', stDevinfo.serialnumber);	
        }      
    }
    
    method = top.changeMethod;
    if(top.changeMethod != 1 && top.changeMethod != 2)
    {
		if(!IsLogicIDSupport())
		{
			method = 2;
		}
		else
		{
			method = 1;
		}
	}

	top.changeMethod = method;
	setDisplay("TrHexPassword",0);

	if ((1 == NCFlag) || (1 == StarhubncFlag))
	{
		setDisable("Passwordmode",1); 
		setDisable("hidePwdGponValue",1); 
		setDisable("hideHexPwdValue",1); 
	}

	if (1 == FobidSnFlag)
	{
		setDisable('SNValue', 1);
	}
}

function LoadUplinkMode()
{
	if (stDevinfo.devtype == "3") {
		setSelect("Uplinkmode",1);
		setOpticCopper = 4;
	} else {
		setSelect("Uplinkmode",0);
		setOpticCopper = 2;
	}
}

function CancelConfig()
{

	$.ajax({
       type : "GET",
       async : true,
       cache : false,
       url : "newvdfpassword.asp",
       success : function(data) {
			LoadFrame();
        }
    });

}


function parseBindText()
{
	$("[BindText]").each(function(id, elem){
		try{
			if("INPUT" == elem.tagName)
			{
				$(this).val(cfg_ontauth_language[$(this).attr("BindText")]);
			}
			else
			{
				$(this).html(cfg_ontauth_language[$(this).attr("BindText")]);
			}
		}catch(e){}
  	});
}

function LoadFrame()
{
	init();
	setRadio("rMethod",2);
	parseBindText();
	
	if (!IsLogicIDSupport())
	{
		setRadio("rMethod",2);
		refreshPasswordMode();
	}
	
	if (1 == StarhubncFlag)
	{
		setDisable("SNValue", 1);
	}

    if ((1 == AtTelecomFlag) && (curUserType == sptUserType))
    {
        setDisable("Passwordmode", 1);
        setDisable("hidePwdGponValue", 1);
        setDisable("hideHexPwdValue", 1);

        setDisable('PwdGponValue', 1);
        setDisable('tPwdGponValue', 1);
        setDisable('HexPwdValue', 1);
        setDisable('tHexPwdValue', 1);
        setDisable('HwkeyValue', 1);
        setDisable('btnApply_ex2', 1);
        setDisable('cancelValue2', 1);
    }
	
}
function priCreatLineBySelect(selectInfo, clickfunction, defaultArr, firstFalg) {
    clickfunction = ProcessFunctionName(clickfunction);
    var selectInfoArray = selectInfo.split(",");
    var rowclass = firstFalg == true ? "row" : "row bottomline";
    var htmlinfo;
    htmlinfo = '<div class="right">';
    htmlinfo += '<div class="iframeDropLog no-padding padding_letf10"><div class="IframeDropdown no-padding dropdowndiv">';
    htmlinfo += '<div class="iframedropdownShow no-padding" id="' + selectInfoArray[0] + '_show" onclick="showDropdownSelect(this, event);">' + selectInfoArray[defaultArr] + '</div>';
    htmlinfo += '<ul class="iframedropdownHide noneDisplay" name="dropDownList" id="' + selectInfoArray[0] + '_hide">';
    for (var i = 1; i < selectInfoArray.length; i++) {
        htmlinfo += '<li id="' + selectInfoArray[0] + (i+1)/2 + '" value="' + selectInfoArray[i++] + '" onclick="changeDropdownInfo(this);' + clickfunction + '">' + selectInfoArray[i] + '</li>';
    }
    htmlinfo += '</ul>';
    htmlinfo += '</div>';
    htmlinfo += '</div>';
    htmlinfo += '</div>';
    document.write(htmlinfo);
}
</script>

</head>
<body  class="mainbody" onLoad="LoadFrame();">
<script>LoadUplinkMode();</script>

<h1>
    <script>document.write(cfg_ontauth_language['amp_auth_title_main']);</script>
</h1>

<h2>&nbsp;</h2>

<div class="h3-content">
    <div class="row">
        <div class="left deviceStatus padding20">
            <span><script>document.write(cfg_ontauth_language['amp_auth_title_ont']);</script></span>	
        </div>
        <div class="right">
            <span>&nbsp;</span>
        </div>
    </div>
</div>
        <div class="h3-content">
            <div class="row">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(cfg_ontauth_language['amp_auth_upport']);</script></span>	
                </div>
                <script>
                    var nameValue = 'Uplinkmode, value1,'+ cfg_ontauth_language['amp_auth_fiber_mode']+',value2,'+cfg_ontauth_language['amp_auth_ge_mode']+'';
                    priCreatLineBySelect(nameValue, null, setOpticCopper, true);
                </script>
            </div>
            <div class="row">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(cfg_ontauth_language['amp_auth_passwd_mode']);</script></span>	
                </div>
                <div class="right deviceStatus padding20">
                        <span><script>document.write(cfg_ontauth_language['amp_auth_char_mode']);</script></span>	
                </div>

            </div>
            
            <div class="row" id="TrPasswordGpon">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(cfg_ontauth_language['amp_auth_passwd_name']);</script></span>	
                </div>
                <div class="right deviceStatus padding20" id="TrTdStrPasswd">
                <input name="PwdGponValue" type="password" autocomplete="off" id="PwdGponValue" maxlength="10" onchange="gponpassword=getValue('PwdGponValue'); getElById('tPwdGponValue').value = gponpassword;hexgponpassword = ChangeAsciitoHex(gponpassword); getElById('tHexPwdValue').value = hexgponpassword; getElById('HexPwdValue').value = hexgponpassword;"/> 
                <input name="tPwdGponValue" type="text" id="tPwdGponValue" maxlength="10" style="display:none" onchange="gponpassword=getValue('tPwdGponValue');getElById('PwdGponValue').value = gponpassword;hexgponpassword = ChangeAsciitoHex(gponpassword);getElById('tHexPwdValue').value = hexgponpassword;getElById('HexPwdValue').value = hexgponpassword;"/> 
                  <input checked type="checkbox" id="hidePwdGponValue" name="hidePwdGponValue" value="on" style="position: static" onClick="ShowOrHideText('hidePwdGponValue', 'PwdGponValue', 'tPwdGponValue', gponpassword);" style="margin-right:-2px"/>
                  <script>
                      document.write(cfg_ontauth_language['amp_password_hide']);
                  </script>
                </div>
            </div>
            <div class="row" id="TrHexPassword">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(cfg_ontauth_language['amp_auth_passwd_name']);</script></span>	
                </div>
                <div class="right deviceStatus padding20" id="TrTdHexPasswd">
                    <input name="HexPwdValue" type="password" autocomplete="off" id="HexPwdValue" maxlength="20" onchange="hexgponpassword=getValue('HexPwdValue');getElById('tHexPwdValue').value = hexgponpassword;gponpassword = ChangeHextoAscii(hexgponpassword);getElById('PwdGponValue').value = gponpassword;getElById('tPwdGponValue').value = gponpassword;"/> 
                    <input name="tHexPwdValue" type="text" id="tHexPwdValue" maxlength="20"  style="display:none" onchange="hexgponpassword=getValue('tHexPwdValue');getElById('HexPwdValue').value = hexgponpassword;gponpassword = ChangeHextoAscii(hexgponpassword);getElById('PwdGponValue').value = gponpassword;getElById('tPwdGponValue').value = gponpassword;"/> 
                    <input checked type="checkbox" id="hideHexPwdValue" name="hideHexPwdValue" value="on" onClick="ShowOrHideText('hideHexPwdValue', 'HexPwdValue', 'tHexPwdValue', hexgponpassword);" style="margin-right:-2px"/>
                    <script>
                        document.write(cfg_ontauth_language['amp_password_hide']);
                    </script>
                </div>
            </div>

            <div class="row" id="TrShowSn">
                <div class="left deviceStatus padding20">
                    <span><script>document.write(cfg_ontauth_language['amp_auth_SN_name']);</script></span>	
                </div>
                <div class="right deviceStatus padding20">
                    <script>
                        document.write(stDevinfo.serialnumber);
                    </script>
                </div>
            </div>
        
        </div>	
        
        <div id="content">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <script>
                CreatApplyButton("AddSubmitParam()");
            </script>
        </div>
        
</body>
</html>
