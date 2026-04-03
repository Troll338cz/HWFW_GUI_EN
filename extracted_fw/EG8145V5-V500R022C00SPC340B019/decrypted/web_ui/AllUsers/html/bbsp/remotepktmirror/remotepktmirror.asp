<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>Remote package mirror</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, remotepktcap_language);%>"></script>
<script language="javascript" src="/html/amp/common/wlan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/topoinfo.asp"></script>
<style>
.TextBox
{
	width:150px;  
}
#direction,#interface{
	width:81px;
}
</style>
<script language="JavaScript" type="text/javascript">
var MirrorStart = '<%HW_WEB_GetPackageActionFlag();%>';
var supportTelmex = "<%HW_WEB_GetFeatureSupport(BBSP_FT_TELMEX);%>";
var UpgradeFlag = 0;
var STBPort = '<%HW_WEB_GetSTBPort();%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var IponlyFlg ='<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
var TianYiFlag = '<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>';
var UpportDetectFlag = '<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var CoreDumpFlag = '<%HW_WEB_Coredump_Enable();%>';
var CoreDumpdisplayFlag = '<%HW_WEB_Coredump_download_flag();%>'
var E8CRONGHEFlag = '<%HW_WEB_GetFeatureSupport(FT_SHMP_RONGHE);%>';
var DoubleFreqFlag = <%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>;
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var reqFile = "html/bbsp/remotepktmirror/remotepktmirror.asp";
var curPageName = "remotepktmirror.asp";
var ProductType = '<%HW_WEB_GetProductType();%>';
var remoteMirrorEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.RemoteMirrorEnable);%>';

if (CfgMode.toUpperCase() == "TURKCELL2") {
    reqFile = "remote/mirror.html";
    curPageName = "mirror.html";
}

function isPortInAttrName()
{
    if((1 == TianYiFlag) && ('E8C' == CurrentBin.toUpperCase()))
	{
		return true;
	}
	return false;
}
function GeInfo(Domain,Status)
{   
    this.Domain = Domain;
    this.Status = Status;
}

var GeInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Link,GeInfo);%>;
function stWlanWifi(domain,name,ssid)
{
    this.domain = domain;
    this.name = name;
    this.ssid = ssid;

}
function stClassificationArr(domain,ClassInterface,X_HW_Mirror,X_HW_Dircetion)
{
    this.domain = domain;
    this.ClassInterface = ClassInterface;
    this.X_HW_Mirror = X_HW_Mirror;
	this.X_HW_Dircetion = X_HW_Dircetion;

}


var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|SSID,stWlanWifi);%>;

var ClassificationArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.QueueManagement.Classification.{i},ClassInterface|X_HW_Mirror|X_HW_Dircetion,stClassificationArr);%>;


function OnStartMirror()
{
    var SourceIPAddr = getValue("SIPAddress");
    var DestIPAddr = getValue("DIPAddress");
    var DirectionValue = getSelectVal("direction");
    var InterfaceValue = getSelectVal("interface");
	
	if ((SourceIPAddr.length == 0) || (isValidIpAddress(SourceIPAddr) == false))
	{
		AlertEx(remotepktcap_language['bbsp_srcinvalid']);
        return false;
	}
	
    if ((DestIPAddr.length == 0) || (isValidIpAddress(DestIPAddr) == false))
    {
        AlertEx(remotepktcap_language['bbsp_dstinvalid']);
        return false;
    }
    
	setDisable("ButtonStartChunkedCapt",1);
    setDisable("ButtonStart", "1");
	setDisable("direction", "1");
	setDisable("interface", "1");
    var Form = new webSubmitForm();
	
	Form.addParameter('x.sip', SourceIPAddr);
	Form.addParameter('x.dip', DestIPAddr);
	switch(DirectionValue)
	{
		case 'ALL':
			Form.addParameter('y.X_HW_Dircetion', 'inbound');
			Form.addParameter('z.X_HW_Dircetion', 'outbound');
			if(InterfaceValue == 'ALL')
			{
				Form.addParameter('y.ClassInterface', '');
				Form.addParameter('y.X_HW_Mirror', 1);
				Form.addParameter('z.ClassInterface', '');
				Form.addParameter('z.X_HW_Mirror', 1);

			}
			else
			{
				Form.addParameter('y.ClassInterface', InterfaceValue);
				Form.addParameter('y.X_HW_Mirror', 1);
				Form.addParameter('z.ClassInterface', InterfaceValue);
				Form.addParameter('z.X_HW_Mirror', 1);
				
			}
			break;
		case 'outbound':
			Form.addParameter('y.X_HW_Dircetion', 'outbound');
			if(InterfaceValue == 'ALL')
			{
				Form.addParameter('y.ClassInterface', '');
				Form.addParameter('y.X_HW_Mirror', 1);
			}
			else
			{
				Form.addParameter('y.ClassInterface',InterfaceValue);
				Form.addParameter('y.X_HW_Mirror', 1);
			}
			break;
		case 'inbound':
			Form.addParameter('y.X_HW_Dircetion', 'inbound');
			if(InterfaceValue == 'ALL')
			{
				Form.addParameter('y.ClassInterface', '');
				Form.addParameter('y.X_HW_Mirror', 1);
			}
			else
			{
				Form.addParameter('y.ClassInterface', InterfaceValue);
				Form.addParameter('y.X_HW_Mirror', 1);
				
			}		
			break;
		default:
			break;
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	if(DirectionValue == 'ALL')
	{
		Form.setAction('startmirpkgaction.cgi?'+'x=InternetGatewayDevice.X_HW_DEBUG.BBSP.QosMirror'
						+'&y=InternetGatewayDevice.QueueManagement.Classification'
						+'&z=InternetGatewayDevice.QueueManagement.Classification'
						+'&RequestFile=' + reqFile);   
    }
	else
	{
		Form.setAction('startmirpkgaction.cgi?'+'x=InternetGatewayDevice.X_HW_DEBUG.BBSP.QosMirror'
									  +'&y=InternetGatewayDevice.QueueManagement.Classification'
									  +'&RequestFile=' + reqFile);   
	}
	Form.submit(); 
	setDisable("cancelValue",0);
}

function OnStopMirror()
{
    if (MirrorStart != '1')
    {
        return;
    }

    var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('stopmirpkgaction.cgi?RequestFile=' + reqFile);   
    Form.submit(); 
	
	setDisable("ButtonStartChunkedCapt",0);
}
var TableClass = new stTableClass("table_title width_per25", "table_right", "", "Select");

function LoadFrame()
{
	LoadChunkedCapt();
    if (MirrorStart == '1')
    {
		setDisable("ButtonStartChunkedCapt",1);
        setDisable("ButtonStart", "1");
		setDisable("direction", "1");
		setDisable("interface", "1");
		
		setNoEncodeInnerHtmlValue("currentstatus", ("<B><FONT class='color_red'>" + remotepktcap_language['bbsp_caping'] + "</FONT><B>"));
    }
	else
	{
		setDisable("cancelValue",1);
		setNoEncodeInnerHtmlValue("currentstatus", ("<B><FONT class='color_red'>" + remotepktcap_language['bbsp_stop'] + "</FONT><B>"));
	}

    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			 continue;
		}
		setObjNoEncodeInnerHtmlValue(b, remotepktcap_language[b.getAttribute("BindText")]);
    }
	var MirrorIndex = 0;
	for (var i = 0; i <ClassificationArr.length -1  ; i++) 
	{
		
		if("1" == ClassificationArr[i].X_HW_Mirror &&  "" != ClassificationArr[i].ClassInterface)
		{
			setSelect("interface", ClassificationArr[i].ClassInterface); 
		}
		if("1" == ClassificationArr[i].X_HW_Mirror)
		{
			MirrorIndex ++;
			setSelect("direction", ClassificationArr[i].X_HW_Dircetion);
		}
		
		if(2 == MirrorIndex ||  0 == MirrorStart)
		{
			setSelect("direction", "ALL");
		}
	}
	if (1 == CoreDumpdisplayFlag)
    {
        getElementById("downloadlog").style.display = "";
        if (CoreDumpFlag == 1)
        {
            setDisable("saveconfigbutton", 0);
            setDisable("btnsaveandreboot", 0);
        }
        else
        {
            setDisable("saveconfigbutton", 1);
            setDisable("btnsaveandreboot", 1);
        }


	}

    if (CfgMode.toUpperCase() == "TTNET2" || CfgMode.toUpperCase() == "DINFOTEK2") {
        $("#ifresh").attr("src","/refresh.asp");
        if (remoteMirrorEnable == 0) {
            setDisable("SIPAddress", 1);
            setDisable("DIPAddress", 1);
            setDisable("direction", 1);
            setDisable("interface", 1);
            setDisable("ButtonStart", 1);
            setDisable("Catchmode", 1);
            setDisable("Maxminute", 1);
            setDisable("ButtonStartChunkedCapt", 1);
        }
    }
}
function InitDirection()
{

   	var DirectionList = getElementById('direction');
	DirectionList.options.add(new Option(remotepktcap_language['bbsp_all'], 'ALL'));
	DirectionList.options.add(new Option(remotepktcap_language['bbsp_egress'], 'outbound'));
	DirectionList.options.add(new Option(remotepktcap_language['bbsp_ingress'], 'inbound'));
}

function LanName2LanDomain(LanName)
{
    if(LanName.length == 0)
    {
        return '';
    }
     
    var EthID = LanName.charAt(LanName.length - 1);
    return  "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + EthID;
}

var WifiSSIDInfoList = new Array();
function stWifiSSIDInfo(SSIDName,SSIDDomain)
{
    this.SSIDName = SSIDName;
	this.SSIDDomain = SSIDDomain;
}

function InitInterface()
{
	var InterfaceList = getElementById('interface');
	var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
	var SSIDInst;
	var LANInst;
    
	InterfaceList.options.add(new Option(remotepktcap_language['bbsp_all'], 'ALL'));

	for(var i=0; i< WlanWifiArr.length -1 ; i++)
	{
		SSIDInst= GetSSIDNameByDomain(WlanWifiArr[i].domain);
		WifiSSIDInfoList.push(new stWifiSSIDInfo(SSIDInst, GetSSIDDomainByName(SSIDInst)));
	}
	
	if(WifiSSIDInfoList.length > 1)
	{
		WifiSSIDInfoList.sort(function(a,b){
		return a.SSIDName.localeCompare(b.SSIDName);
		});
	}
	
	for(var i=0; i< WifiSSIDInfoList.length ; i++)
	{
		var wlanInst = WifiSSIDInfoList[i].SSIDDomain.substring(SSIDPath.length, WifiSSIDInfoList[i].SSIDDomain.length);
		if ((1 != DoubleFreqFlag) && (parseInt(wlanInst, 10) >= SsidPerBand))
		{
			continue;
		}
		if (WifiSSIDInfoList[i].SSIDName == '') {
			continue;
		}
		
		InterfaceList.options.add(new Option(WifiSSIDInfoList[i].SSIDName, WifiSSIDInfoList[i].SSIDDomain));
	}
	
	for(var i=0,j=1; i < GeInfos.length -1 ; i++,j++)
	{
		if(GeInfos[i].Status == "1")
		{
			if(isPortInAttrName())
			{
				LANInst= getTianYilandesc(j);
			}
			else
			{
				LANInst= 'LAN' + j;
			}
			
			if ((2 == j) && (4 == GeInfos.length - 1) && ('E8C' == CurrentBin.toUpperCase()) && (0 == STBPort) && CfgMode.toUpperCase() != 'GZGD')
			{
				LANInst = "iTV";
			}
			
			if ((5 == j) && ('1' == IponlyFlg))
			{
				LANInst = "EXT1";
			}
			
			if(j == STBPort)
			{
				LANInst = remotepktcap_language['bbsp_stb'];
				if (E8CRONGHEFlag == 1)
				{
					continue;
				}
			}
			
			if (UpportDetectFlag != 1 && UpUserPortID != j)
			{
			
				InterfaceList.options.add(new Option(LANInst, LanName2LanDomain('LAN' + j)));
			}
		}
	}
}
</script>

<script language="JavaScript" type="text/javascript">

var Wireless = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var Voice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';

var timerenew = "";
var conflict = "";
var iscatching = "";
var onstate = "";
var maxminute = "";
var catchtime = "";
var randstr = '<%HW_WEB_GetWebCaptRandStr();%>';
var lasttype = 0;

var explorer = navigator.userAgent;
var browse = "";

if(explorer.indexOf("MSIE") >= 0)
{
	browse = "ie";
}
else if(explorer.indexOf("Firefox") >= 0)
{
	browse = "Firefox";
}
else if(explorer.indexOf("Chrome") >= 0)
{
	browse = "Chrome";
}


function conflictcheck()
{
	if(1 != iscatching)
	{	
		AlertEx(remotepktcap_language["ssmp_conflict"]);
		window.location.replace(curPageName);
	}
}


function youcanstop()
{
	setDisable("cancelValueChunkedCapt",0);
}

function BeingBusy()
{
	setDisable("ButtonStart",1)
	setDisable("Maxminute",1);
	setDisable("Catchmode",1);
	setDisable("ButtonStartChunkedCapt",1);
	window.setTimeout("youcanstop()", 2000);
	timerenew = setInterval("Getchunkedcapt()",5000);
}

function AjaxSend(mode, para)
{
	var Result;
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : para + "x.X_HW_Token=" + getValue('onttoken'),
		url : mode+"chunkedcapt.cgi?RequestFile=" + reqFile,
		success : function(data) {			
		Result = hexDecode(data);
	}});
	return Result;
}

function OnStartChunkedCapt()
{
	var proctype = document.getElementById('Catchmode').value;
	var userinput = document.getElementById('Maxminute');
	var maxminute = userinput.value;
	
	if (maxminute == '' || isPlusInteger(maxminute) == false)
	{
		AlertEx(remotepktcap_language["ssmp_error"]);
		userinput.focus();
		return;
	}
	
	var info = parseInt(maxminute,10);
	if (info < 5 || info > 43200)
	{
		AlertEx(remotepktcap_language["ssmp_error"]);
		userinput.focus();
		return;
	}
	
	
	var Form = new webSubmitForm();
	url = 'startchunkedcapt.cgi?RequestFile=' + reqFile;
	Form.addParameter('randstr', randstr);
	Form.addParameter('proctype', proctype);
	Form.addParameter('maxminute', maxminute);
	Form.addParameter('privatepara', '');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction(url);
	Form.submit();
	
	Getchunkedcapt();

	BeingBusy();
	
	if ("ie" == browse)
	{
		conflict = setTimeout("conflictcheck()",10000);
	}
	else if ("Firefox" == browse)
	{
		conflict = setTimeout("conflictcheck()",10000);
	}
	else if ("Chrome" == browse)
	{
		conflict = setTimeout("conflictcheck()",10000);
	}
	else
	{
		conflict = setTimeout("conflictcheck()",10000);
	}
}

function Getchunkedcapt()
{
	var Result = AjaxSend("get", "");
	var catcharray = Result.split(',');
	iscatching = catcharray[0].split(":")[1];
	if(1 == iscatching)
	{
		maxminute = catcharray[1].split(":")[1];
		catchtime = catcharray[2].split(":")[1];
		var catchnum = catcharray[3].split(":")[1];
		lasttype = catcharray[4].split(":")[1];
				
		showState(catchnum)
	}		
	else 
	{
		onstate = "";
		if(catchtime != "")
		{
			window.location.replace(curPageName);
		}	
	}
	$("#catchstatus").text(onstate);
}

function showState(catchnum)
{
	var country = remotepktcap_language["ssmp_country"]
	var spanish = 'spanish'
	var arabic  = 'arabic'
	var Russian ='Russian'
	
	var part1 = GetDescFormArrayById(remotepktcap_language, "ssmp_state1")
	var part2 
	var part3
	var temp
	
	if(country == arabic)
	{
		part2 = GetDescFormArrayById(remotepktcap_language, "ssmp_state2")	
		if(catchtime < 3)
		{
			switch(parseInt(catchtime))
			{
				case 0: part2 += catchtime
						part2 += GetDescFormArrayById(remotepktcap_language, "ssmp_state2_zero_few_left")
						break
				case 1: part2 += GetDescFormArrayById(remotepktcap_language, "ssmp_state2_one")
						break
				case 2: part2 += GetDescFormArrayById(remotepktcap_language, "ssmp_state2_two")		
						break
				default: 
						break
			}
		}
		else 
		{
			temp = (parseInt(catchtime))%100
			if (temp >= 3 && temp <= 10)
			{
				part2 += catchtime
				part2 += GetDescFormArrayById(remotepktcap_language, "ssmp_state2_zero_few_left")
			}
			else
			{
				part2 += catchtime
				part2 += GetDescFormArrayById(remotepktcap_language, "ssmp_state2_many_other_left")
			}
		}
		
		part3 = GetDescFormArrayById(remotepktcap_language, "ssmp_state3")	
		if(catchnum == 1)
		{				
			part3 += GetDescFormArrayById(remotepktcap_language, "ssmp_state3_one")
		}
		else 
		{		
			part3 += GetDescFormArrayById(remotepktcap_language, "ssmp_state3s_right")
			part3 += catchnum
			part3 += GetDescFormArrayById(remotepktcap_language, "ssmp_state3s_left")
		}
			
		onstate = part3 + part2 + part1	
		return
	}
	
	if(country == Russian)
	{
		temp = (parseInt(catchtime))%10
		if (temp == 1)
		{
			part2 = GetDescFormArrayById(remotepktcap_language, "ssmp_state2_one")
		}
		else if (temp >= 2 && temp <= 4)
		{
			part2 = GetDescFormArrayById(remotepktcap_language, "ssmp_state2_other")
		}
		else 
		{
			part2 = GetDescFormArrayById(remotepktcap_language, "ssmp_state2_many")
		}
		
		temp = (parseInt(catchnum))%10
		if (temp == 1)
		{
			part3 = GetDescFormArrayById(remotepktcap_language, "ssmp_state3_one")
		}
		else
		{
			part3 = GetDescFormArrayById(remotepktcap_language, "ssmp_state3_many_other")
		}
		
		onstate = part1 + catchtime + part2 + catchnum + part3
		return
	}
	
	part2 = (catchtime == 1) ? remotepktcap_language["ssmp_state2"] : remotepktcap_language["ssmp_state2s"]
		
	part3 = (catchnum == 1) ? remotepktcap_language["ssmp_state3"] : remotepktcap_language["ssmp_state3s"]
		
	if(country == spanish)
	{
		onstate = part1 + catchnum + part3 + catchtime + part2
	}
	else
	{
		onstate = part1 + catchtime + part2 + catchnum + part3	
	}		
}

function OnStopChunkedCapt()
{
	clearTimeout(conflict);
	clearInterval(timerenew);
	var Result = AjaxSend("stop", "");
	Getchunkedcapt();
	if(1 != iscatching)
	{
		window.location.replace(curPageName);
	}
}

function LoadChunkedCapt()
{	
	if(Voice == 0)
	{
		removeOption('Catchmode', 'Voice')
	}
	
	if(Wireless == 0)
	{
		removeOption('Catchmode', 'Wireless')
	}

	Getchunkedcapt();
	if(1 == iscatching)
	{
		var type = parseInt(lasttype)
		if (0 != type)
		{
			if (1 == type)
			{
				setSelect('Catchmode', 'Wireless')
			}
			else
			{
				setSelect('Catchmode', 'Voice')
			}
		}
		
		setText('Maxminute', parseInt(maxminute))

		BeingBusy()
	}
	else
	{
		setDisable("cancelValueChunkedCapt",1);
	}
}

function ButtonDownload()
{	
	XmlHttpSendAspFlieWithoutResponse("../../ssmp/common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('downloadcoredumpfiel.cgi?RequestFile=' + reqFile);
	Form.submit();
}

function ButtonCancel()
{
	XmlHttpSendAspFlieWithoutResponse("../../ssmp/common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('removecoredumpfile.cgi?RequestFile=' + reqFile);
	Form.submit();
}

</script>

</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("remotepkmirror", GetDescFormArrayById(remotepktcap_language, "bbsp_mune"), GetDescFormArrayById(remotepktcap_language, "bbsp_remotepktcap_title1"), false);
</script>
<div class="title_spread"></div>

<form id="ConfigForm" style="display:block">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
<tr><td class="width_100p align_left" BindText='ssmp_mirror'></td> </tr> 
</table>

<table border="0" cellpadding="0" cellspacing="0"  width="100%">
<li   id="currentstatus" RealType="HtmlText" DescRef="bbsp_state"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="CurrentStatus"   InitValue="Empty"/>
<li   id="SIPAddress"    RealType="TextBox"  DescRef="bbsp_sourceip"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.SourceIPAddr"  InitValue="Empty" />                                                                   
<li   id="DIPAddress"    RealType="TextBox"  DescRef="bbsp_desip"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.DestIPAddr"  InitValue="Empty"/>
<li   id="direction"    RealType="DropDownList"  DescRef="bbsp_direction"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="Empty"  InitValue="Empty"/>
<li   id="interface"    RealType="DropDownList"  DescRef="bbsp_interface"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="Empty"  InitValue="Empty"/>                                                                    
</table>
<script>
MirrorConfigFormList = HWGetLiIdListByForm("ConfigForm");
HWParsePageControlByID("ConfigForm", TableClass, remotepktcap_language, null);
InitDirection();
InitInterface();
</script>
<table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
<tr> 
  <td class='width_per25'></td> 
  <td class="table_submit">
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	<button name="ButtonStart" id="ButtonStart" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="OnStartMirror();"><script>document.write(remotepktcap_language['bbsp_startmirror']);</script></button>
	<button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="OnStopMirror();"><script>document.write(remotepktcap_language['bbsp_stopmirror']);</script></button> </td> 
</tr>
</table>

<script>
	if("1" == supportTelmex)
	{
		document.write("\<div id=\"fresh\" style=\"display:none\"\> ");
		document.write(" \<iframe frameborder=\"0\" height=\"100\%\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" src=\"../../../../refresh.asp\" width=\"100%\"\>\</iframe\> \</div\> ");
	}
</script>
</form>  

<form>
		<div class="title_spread"></div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
		<tr><td class="width_100p align_left" BindText='ssmp_chunkedcapt'></td> </tr> 
		</table>
		<table class="tabal_noborder_bg" border="0" cellpadding="0" cellspacing="1" width= "100%">
			<tr>
				<td class= "table_title width_per25" align= ""><script>document.write(remotepktcap_language['ssmp_type']);</script></td>
				<td class= "table_right">
					<select name="Catchmode" size="1" id="Catchmode" onchange="">
					  <option value="Internet" selected><script>document.write(remotepktcap_language['ssmp_band']);</script></option>
					  <option value="Voice" ><script>document.write(remotepktcap_language['ssmp_voice']);</script></option>
                      <option value="Wireless" ><script>document.write(remotepktcap_language['ssmp_wifi']);</script></option>
					</select>
				</td>
			</tr>

			<tr>
				  <td class= "table_title"><script>document.write(remotepktcap_language['ssmp_time']);</script></td>
				  <td class= "table_right">
					<input name="Maxminute" id="Maxminute" type="text" value="20"/>
					<script>document.write(remotepktcap_language['ssmp_input']);</script>
				  </td>
			</tr>	  

			<tr>
			  <td class= "table_title"><script>document.write(remotepktcap_language['ssmp_state']);</script></td>
			  <td class= "table_right" type="text" id = "catchstatus"></td>				
			</tr>	
		</table>
		<table class="table_button" width="100%" cellpadding="0" cellspacing="0">
				<tbody><tr>
				  <td width="25%"></td>
		          <td class="table_submit" style="padding-left: 5px">
					<button id="ButtonStartChunkedCapt" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="OnStartChunkedCapt();"><script>document.write(remotepktcap_language['bbsp_startmirror']);</script></button>
				    <button style="display:inline" id="cancelValueChunkedCapt" type="button" class="CancleButtonCss buttonwidth_100px" onClick="OnStopChunkedCapt();"><script>document.write(remotepktcap_language['bbsp_stopmirror']);</script></button>
		          </td>
		             </tr></tbody>
	    </table>
	</form>
	
<form id="downloadlog" style="margin-top:20px;height:70px;display:none;">	
	<div class="func_title"><script>document.write(remotepktcap_language['bbsp_coredumpstate']);</script></div>
	<table width="100%" style="margin-top:10px;" cellpadding="0" cellspacing="0">
		<tr>
			<td><button  class="ApplyButtoncss buttonwidth_150px_250px" name="saveconfigbutton" id="saveconfigbutton" type='button' onClick='ButtonDownload()' ><script>document.write(remotepktcap_language['bbsp_coredump_downlod']);</script> </button></td>
			<td><button  class="ApplyButtoncss buttonwidth_150px_250px" name="btnsaveandreboot" id="btnsaveandreboot" type='button' onClick='ButtonCancel()' ><script>document.write(remotepktcap_language['bbsp_coredump_remove']);</script>  </button></td>
		</tr>
	</table>
</form>
<div id="fresh">
    <iframe id="ifresh" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no" src=""></iframe>
</div>
<script>
if (rosunionGame == "1") {
	$("#ButtonStartChunkedCapt").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
	$("#ButtonStart").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
}
</script>
</body>
</html>
