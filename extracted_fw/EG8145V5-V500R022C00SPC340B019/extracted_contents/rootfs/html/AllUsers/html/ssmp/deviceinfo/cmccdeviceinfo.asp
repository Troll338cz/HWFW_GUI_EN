<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="Javascript" src="net_access_label/netaccesssign.js"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='net_access_label/HYCuSong.css' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
var CfgMode ='<%HW_WEB_GetCfgMode();%>'.toUpperCase();
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var jiuzhouFlag = '<%WEB_GetJiuZhouFlag();%>';
function stDeviceInfo(domain,SerialNumber,HardwareVersion,SoftwareVersion,ModelName,VendorID,ReleaseTime,Mac,Description,ManufactureInfo,ManufacturerOUI)
{
	this.domain 			= domain;
	this.SerialNumber 		= SerialNumber;
	this.HardwareVersion 	= HardwareVersion;		
	this.SoftwareVersion 	= SoftwareVersion;
	this.ModelName 		    = ModelName;
	this.VendorID			= VendorID;
	this.ReleaseTime 		= ReleaseTime;
	this.Mac				= Mac;
    this.Description        = Description;
	this.ManufactureInfo	= ManufactureInfo;
	this.ManufacturerOUI	= ManufacturerOUI;

}	

function ONTInfo(domain,Status)
{
	this.domain 		= domain;
	this.Status			= Status;
}

function isFirst8VisibleChar(sn)
{    
    if (
         ((sn.charAt(0) >= '2')&&(sn.charAt(0) <= '7'))
         &&((sn.charAt(2) >= '2')&&(sn.charAt(2) <= '7'))
         &&((sn.charAt(4) >= '2')&&(sn.charAt(4) <= '7'))
         &&((sn.charAt(6) >= '2')&&(sn.charAt(6) <= '7'))
       )
    {
        if ( 
             ((sn.charAt(0) == '7')&&(sn.charAt(1) == 'F'))
             ||((sn.charAt(2) == '7')&&(sn.charAt(3) == 'F'))
             ||((sn.charAt(4) == '7')&&(sn.charAt(5) == 'F'))
             ||((sn.charAt(6) == '7')&&(sn.charAt(7) == 'F'))
           )
        {            
            return false;
        }       
        return true;
    }
    return false;
}

function getMinus(a)
{
	if ( a > '9' )
	{
		if ( (a >= 'A') && (a <= 'F') )  
		{
			return 55;
		}
		else
		{
			return 87;  
		}		  
    }
    else
    {
        return 48;
    }
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

var ontMatchOLTStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.ONT.MatchStatus);%>';
var ontInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT,State,ONTInfo);%>;
var ontEPONInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT,State,ONTInfo);%>;
var ontInfoID = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT.Ontid);%>';
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var deviceInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|HardwareVersion|SoftwareVersion|ModelName|X_HW_VendorId|X_HW_ReleaseTime|X_HW_LanMac|Description|ManufactureInfo|ManufacturerOUI, stDeviceInfo);%>; 
var ontInfo = ontInfos[0];
var ontEPONInfo = ontEPONInfos[0];
var deviceInfo = deviceInfos[0];
var IsLAN = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';

var customizeDes = '<%HW_WEB_GetCustomizeDesc();%>';
var SN = deviceInfo.SerialNumber;	
var sn = deviceInfo.SerialNumber; 
var GPON_SN = deviceInfo.SerialNumber;
var minus = 0;			
var temp1 = 0;
var temp2 = 0;

var ParentalFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PARENTAL_CONTROL);%>'; 
var HangYan = '<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_HANGZHOUMARK);%>';
var IsCIOT = '<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_CIOTMARK);%>';
var systemdsttime = '<%HW_WEB_GetSystemTime();%>'; 
var opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>'; 
 
function IsOpticalNomal()
{
	return opticInfo != "--";
}

function ParseSystemTime(SystemTime)
{
	if(SystemTime == "")
	{
	  SystemTime = "1970-01-01 01:01";
	}
	
	document.getElementById('td14_2').innerHTML = htmlencode(SystemTime);
}

if (HangYan == '1')
{
	GPON_SN = conv16to12Sn(deviceInfo.SerialNumber);
	SN = deviceInfo.ManufacturerOUI + conv16to12Sn(deviceInfo.SerialNumber);
}
else if (IsCIOT == '1')
{
	GPON_SN = conv16to12Sn(deviceInfo.SerialNumber);
	SN = deviceInfo.ManufacturerOUI + '-' + conv16to12Sn(deviceInfo.SerialNumber);
}
else if (jiuzhouFlag == '1') {
	SN = deviceInfo.SerialNumber;
} else 
{
	if (isFirst8VisibleChar(sn) == true)  
	{
		SN = deviceInfo.SerialNumber + ' ' + '(' + conv16to12Sn(deviceInfo.SerialNumber) + ')';          
	}
	
}

function LoadFrame()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length; i++)
	{
		var b = all[i];
		var c = b.getAttribute("BindText");
		if(c == null)
		{
			continue;
		}
		b.innerHTML = DevInfoDes[c];
	}
	
	if (1 == IsLAN)
	{ 
		document.getElementById('tr7').style.display="none";
		document.getElementById('OntId').style.display="none";
	}
	
	if (ParentalFlag==1)
	{
		document.getElementById('currenttime').style.display="";
	}
	else
	{
		document.getElementById('currenttime').style.display="none";
	}
	
	if(ontPonMode.toUpperCase() == 'EPON')
	{
		document.getElementById('OntId').style.display="none";
	}
	if ((HangYan == '1') || (IsCIOT == '1'))
	{
		setDisplay("tr9", 1);
	}
	else
	{
		setDisplay("tr9", 0);
	}
	
	ParseSystemTime(systemdsttime);
}

function GetLanguageDesc(Name)
{
    return DevInfoDes[Name];
}

var netAccessSign = "<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.SMP.NASN.Id);%>".split(",");
var permissionIdentifier = netAccessSign[0];
var deviceModel = netAccessSign[1];
var digitalEncoding = netAccessSign[2];
var pathImageStr = '';
var deviceModelStr = '';
var digitalEncodingStr = '';
if (CfgMode.includes("CMCC") && permissionIdentifier != 0) {
    var pathImage = getPathImage(permissionIdentifier);
    pathImageStr = '<img src=net_access_label/' + pathImage + '.png>';
    deviceModelStr = '<p class=' + getDeviceModel(deviceModel.length) + '>' + deviceModel + '</p>';
    digitalEncodingStr = '<p class="digital-encoding">' + digitalEncoding + '</p>';
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("deviceinfo", GetDescFormArrayById(DevInfoDes, "s0200"), GetDescFormArrayById(DevInfoDes, "s0201"), false);
</script>

<table width="100%" height="5"><tr><td></td></tr></table> 

<div id="deviceinfo" class="configborder">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="Tabledeviceinfo">
<tr> 
<td class="table_title" width="20%" id="td1_1" BindText="s0202"></td> 
<td class="table_right" width="80%" id="td1_2">
<script language="javascript">
document.write(htmlencode(deviceInfo.ModelName));
</script> </td> 
</tr>

<tr id="tr2"> 
<td  class="table_title" id="td2_1" BindText="s0203"></td> 
<td class="table_right align_left" id="td2_2" dir="ltr">
<script language="javascript">
	if (jiuzhouFlag == "1") {
		var descripthtml = deviceInfo.Description.replace("EchoLife", "");
		descripthtml = descripthtml.replace("OptiXstar", "");
		descripthtml = descripthtml.replace(/^\s+|\s+$/g, '')
		document.write(htmlencode(descripthtml));
	} else {
		document.write(htmlencode(deviceInfo.Description));
	}
</script> </td> 
</tr> 

<tr id="tr3"> 
<td class="table_title" id="td3_1"> 
<script language="javascript">
document.write("设备标识号：&nbsp;"); 
</script> </td> 
<td class="table_right align_left" id="td3_2" dir="ltr"> <script language="javascript">
document.write(htmlencode(SN));
</script> </td> 
</tr> 

<tr id="tr9" style="display:none;"> 
	<td class="table_title" id="td9_1"> 
		<script language="javascript">
			document.write("GPON SN：&nbsp;"); 
		</script>
	</td>
    <td class="table_right align_left" id="td9_2" dir="ltr">
		<script language="javascript">
			document.write(htmlencode(GPON_SN));
		</script>
	</td> 
</tr>
<tr id="tr4"> 
<td  class="table_title" id="td4_1" BindText="s0204"></td> 
<td class="table_right" id="td4_2"> <script language="javascript">
document.write(htmlencode(deviceInfo.HardwareVersion));
</script> </td> 
</tr> 

<tr  id="tr5"> 
<td class="table_title" id="td5_1" BindText="s0205"></td> 
<td class="table_right" id="td5_2"> <script language="javascript">
document.write(htmlencode(deviceInfo.SoftwareVersion));
</script> </td> 
</tr> 

<tr  id="tr6"> 
<td class="table_title" id="td6_1" BindText="s0217"></td> 
<td class="table_right" id="td6_2"> <script language="javascript">
document.write(htmlencode(deviceInfo.ManufactureInfo));
</script> </td> 
</tr> 

<tr  id="tr7"> 
<script>

	if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
	{
		document.write('<td class="table_title" id="td7_1" BindText="s0206_xd"></td>');
	}
	else
	{
		document.write('<td class="table_title" id="td7_1" BindText="s0206"></td>'); 
	}

</script>
<td class="table_right" id="td7_2"> <script type="text/javascript" language="javascript">
if (1 == ontMatchOLTStatus && IsOpticalNomal())
{
	if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
	{
		document.write(DevInfoDes['s1321_xd']);
	}
	else
	{
		document.write(DevInfoDes['s1321']); 
	}
}
else
{
	if (ontPonMode.toUpperCase() == 'GPON')
	{   
		if (ontInfo.Status == 'o1' || ontInfo.Status == 'O1')
		{
		document.write(htmlencode(ontInfo.Status) + DevInfoDes['s1322']); 
		}
		else if (ontInfo.Status == 'o2' || ontInfo.Status == 'O2')
		{
		document.write(htmlencode(ontInfo.Status) + DevInfoDes['s1323']); 
		}
		else if (ontInfo.Status == 'o3' || ontInfo.Status == 'O3')
		{
		document.write(htmlencode(ontInfo.Status)+DevInfoDes['s1324']); 
		}
		else if (ontInfo.Status == 'o4' || ontInfo.Status == 'O4')
		{
		document.write(htmlencode(ontInfo.Status)+DevInfoDes['s1325']); 
		}
		else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
		{
		document.write(htmlencode(ontInfo.Status)+DevInfoDes['s1326']); 
		}
		else if (ontInfo.Status == 'o6' || ontInfo.Status == 'O6')
		{
		document.write(htmlencode(ontInfo.Status)+DevInfoDes['s1327']); 
		}
		else if (ontInfo.Status == 'o7' || ontInfo.Status == 'O7')
		{
		document.write(htmlencode(ontInfo.Status)+DevInfoDes['s1328']); 
		}
	}
	else if (ontPonMode.toUpperCase() == 'EPON')
	{
		if (ontEPONInfo != null)
		{
			document.write(htmlencode(ontEPONInfo.Status));
		}
		else
		{
			document.write('');
		}
	}
	else
	{
		document.write('');
	}
}
</script> 
</td> 
</tr>

<tr id="currenttime">
<td class="table_title" id="td14_1" BindText="s0226"></td>
<td class="table_right" id="td14_2"></td>
</tr>

<tr  id="OntId"> 
<script>
	if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
	{
		document.write('<td  class="table_title_xd" id="tr8_1" BindText="s0207"></td>');
	}
	else
	{
		document.write('<td  class="table_title" id="tr8_1" BindText="s0207"></td>'); 
	}
</script>
<td class="table_right" id="td8_2">
<script language="javascript">
if (ontInfoID != null)
{
	document.write(htmlencode(ontInfoID));
}
else
{
	document.write('');
}
</script> 
</td> 
</tr> 

<script type="text/javascript" language="javascript">
	document.write('<tr id="ShowCustomizeDes">');
	document.write('<td class="table_title" id="td13_1" BindText="s0225"></td>');
	document.write('<td class="table_right" id="td13_2">');
	if (customizeDes != null)
	{
		document.write(htmlencode(customizeDes));
	}
	else
	{
		document.write('');
	}

    document.write('</td></tr>');

</script>

<tr>
	<td style="position:absolute; right:20px">
		<div style="position:absolute; right:0px; bottom:0px">
			<script>
				document.write(pathImageStr);
			</script>
			<div>
				<script>
					document.write(deviceModelStr);
				</script>
			</div>
			<div>
				<script>
					document.write(digitalEncodingStr);
				</script>
			</div>
		</div>
	</td>
</tr> 
</table> 
</div>
<table width="100%" height="30"><tr><td></td></tr></table> 
</body>
</html>
