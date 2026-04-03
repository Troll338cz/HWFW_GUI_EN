<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<title>Intelligent Channel</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">

var MaxQosSmartRule = 64;
var OperatorFlag = 0;
var selIndex = -1;
var EthNumMax = 4;
var ReMarkModeNum = 0;
var DisplayControl = <% HW_WEB_GetFeatureSupport(BBSP_FT_MODIFY_PRI_OR_TC);%>;
var TableName = "QosSmartConfigList";
var curUserType = '<%HW_WEB_GetUserType();%>';
var STBPort = '<%HW_WEB_GetSTBPort();%>';
var UpportDetectFlag ='<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var QosSmartPriFlag ='<%HW_WEB_GetFeatureSupport(FT_BBSP_QOSSMART_PRI_SUPPORT);%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var DownBandwidth = 0;
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';

function LanName2LanDomain(LanName)
{
    if(LanName.length == 0)
    {
        return '';
    }
     
    var EthNum = LanName.charAt(LanName.length - 1);
    if(LanName == qos_smart_language['bbsp_qossmartstb'])
	{
		EthNum = STBPort;
	}	
    return  "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + EthNum;
}

function appendPrompt(filedName)
{   
    return qos_smart_language[filedName]+qos_smart_language['bbsp_qosPrompt'];
}


function LanDomain2LanName(Domain)
{
	if(Domain == undefined)
	{
		return '';
	}
    if(Domain.length == 0)
    {
        return '';
    }
    
    var EthNum = Domain.charAt(Domain.length - 1);

	if((EthNum == STBPort) && (STBPort > 0))
	{
		return  qos_smart_language['bbsp_qossmartstb'];
	}	
    
    return  "LAN" + EthNum;
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
		setObjNoEncodeInnerHtmlValue(b, qos_smart_language[b.getAttribute("BindText")]);
	}
}

function SubmitEnableForm()
{ 
    var Form = new webSubmitForm();
    
    var Enable = getElById("QosSmartEnableValue").checked;
    if (Enable == true)
    {
        Form.addParameter('x.X_HW_ClassificationEnable',1); 
    }
    else
    {
        Form.addParameter('x.X_HW_ClassificationEnable',0); 
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.QueueManagement'
                        + '&RequestFile=html/bbsp/qossmart/qossmart.asp');
    Form.submit();     
}

function SubmitBandwidthForm() { 
    var Form = new webSubmitForm();
    
    var bandwidth = getValue("SetBandwidth");
    if (bandwidth < 0) {
        AlertEx(qos_smart_language['bbsp_bandwidthinvalid']);
	    return false;; 
    } else {
        Form.addParameter('x.X_HW_Down_Bandwidth',bandwidth*1024); 
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.QueueManagement'
                        + '&RequestFile=html/bbsp/qossmart/qossmart.asp');
    Form.submit();     
}
function TopoInfo(Domain, EthNum, SSIDNum)
{   
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}

function QosSmartEnableInfo(_Domain, _QosSmartEnableValue)
{
    this.Domain = _Domain;
    
	this.QosSmartEnableValue = _QosSmartEnableValue;
	
}

function QosSmartBandwidthInfo(_Domain, _QosSmartBandwidthValue) {
    this.Domain = _Domain; 
	this.QosSmartBandwidthValue = _QosSmartBandwidthValue;
}

function QosSmartItem(_Domain, _ClassInterface, _DomainName, _DestIP, _DestMask, _SourceIP, _SourceMask, _Protocol, _DestPort, _DestPortRangeMax, _SourcePort, _SourcePortRangeMax, _DSCPMark, _VLANIDCheck, _TRAFFIC, _PRIMARK, _TRAFFICMARK)
{
	this.Domain = _Domain;
    this.ClassInterface = LanDomain2LanName(_ClassInterface);
    this.QosSmartDomain = _DomainName;
    this.DestIP = _DestIP;
    this.DestMask = _DestMask;
    this.SourceIP = _SourceIP;
    this.SourceMask = _SourceMask;
    this.Protocol = _Protocol;
    this.DestPort = _DestPort;
    this.DestPortRangeMax = _DestPortRangeMax;
    this.SourcePort = _SourcePort;
    this.SourcePortRangeMax = _SourcePortRangeMax;    
    this.DSCPMark = _DSCPMark;
    this.VLANIDCheck = _VLANIDCheck;
    this.TRAFFIC = _TRAFFIC;
    this.TRAFFICMARK = _TRAFFICMARK;
    this.PRIMARK = _PRIMARK;
}

var QosSmartList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaQosSmart,InternetGatewayDevice.QueueManagement.X_HW_Classification.{i},ClassInterface|DomainName|DestIP|DestMask|SourceIP|SourceMask|Protocol|DestPort|DestPortRangeMax|SourcePort|SourcePortRangeMax|DSCPMark|VLANIDCheck|TRAFFIC|PRIMARK|TRAFFICMARK, QosSmartItem);%>;
var QosSmartEnable = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.QueueManagement, X_HW_ClassificationEnable, QosSmartEnableInfo);%>
var QosSmartEn = QosSmartEnable[0];
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;
var TopoInfo = TopoInfoList[0];
TopoInfo.EthNum = '<%GetLanPortNum();%>';

if((CfgModeWord.toUpperCase() == "SAFARICOM2") || (CfgModeWord.toUpperCase() == "SAFARICOM")) {
    var QosSmartBandwidth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.QueueManagement, X_HW_Down_Bandwidth, QosSmartBandwidthInfo);%>
    DownBandwidth = QosSmartBandwidth[0].QosSmartBandwidthValue;
}

if (UpportDetectFlag ==1 || 1 == PonUpportConfig)
{
	var qossmrtlistlen = QosSmartList.length;
	var qosmartlisttemp = new Array();
	for (var i=0; i < qossmrtlistlen-1;i++)
	{
		var lannum = QosSmartList[i].ClassInterface.substr(3,1);
		if (UpUserPortID != lannum)
		{
			qosmartlisttemp.push(QosSmartList[i]);
		}
	}
	QosSmartList = qosmartlisttemp;
	QosSmartList.push(null);
}

function getIsHaveHiddenPort()
{ 
   if(UpUserPortID >5) 
   {
	   return 0;
   } 
   else
   {
	   return 1;
   }
}

function GetIPTVWANInfo()
{
	if (supportIPTVPort != 1)
	{
		return 0;
	}

	var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
	if (IPTVUpPortInfo == "")
	{
		return 0;
	}
	
	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
	var tempIPTVUpList = tempIPTVUpValue.split(".");
	return tempIPTVUpList[0].substr(3);
}

function ClassInterfaceInitOption()
{
	var InterfaceList = getElementById('ClassInterface');
	var EthNum = TopoInfo.EthNum;
	if (UpportDetectFlag ==1 || 1 == PonUpportConfig)
	{
		EthNum = parseInt(TopoInfo.EthNum) + getIsHaveHiddenPort();		
	}
	
    var i;
	var LanInst;
	var IPTVPortID = GetIPTVWANInfo();
    
	InterfaceList.options.add(new Option('', ''));
	for(i=1; i<=EthNum;i++)
	{
		LanInst= 'LAN' + i;
		if(i == STBPort)
		{
			LanInst = qos_smart_language['bbsp_qossmartstb'];
		}
		
		if ((UpportDetectFlag == 1 || 1 == PonUpportConfig) && UpUserPortID == i)
		{
			continue;
		}
		
		if (IPTVPortID == i)
		{
			continue;
		}
		
		InterfaceList.options.add(new Option(LanInst, LanName2LanDomain('LAN' + i)));

	}
}

function ReMarkModeNum2ReMarkModeName(QosSmartItem)
{
	if (-1 == QosSmartItem.PRIMARK || '' == QosSmartItem.PRIMARK)
	{
		return qos_smart_language['bbsp_qossmarttcremark'];
	}
	else
	{
		return qos_smart_language['bbsp_qossmartprimark'];
	}
}

function ReMarkModeInitOption()
{
	var ReMarkModeList = getElementById('ReMarkMode');

	ReMarkModeList.options.add(new Option(qos_smart_language['bbsp_qossmarttcremark'], '0'));
	ReMarkModeList.options.add(new Option(qos_smart_language['bbsp_qossmartprimark'], '1'));
}

function LoadSmartEnable()
{    
	var enable = QosSmartEn.QosSmartEnableValue;
		
	if (enable == true)
    {
        getElById("QosSmartEnableValue").checked = true;
    }
	else
	{
	    getElById("QosSmartEnableValue").checked = false;
	}
}

function LoadSmartBandwidth() {
    setText("SetBandwidth", DownBandwidth/1024);
}

function paraCompensate ()
{
	var i = 0;
	var RecordCount = QosSmartList.length - 1;
	for(i = 0; i < RecordCount; i ++)
	{
	    QosSmartList[i].QosSmartDomain = (QosSmartList[i].QosSmartDomain == '-1')?'':QosSmartList[i].QosSmartDomain;
		QosSmartList[i].Protocol = (QosSmartList[i].Protocol == '-1')?'':QosSmartList[i].Protocol;
	    QosSmartList[i].DestPort = (QosSmartList[i].DestPort == '-1')?'':QosSmartList[i].DestPort;
	    QosSmartList[i].DestPortRangeMax = (QosSmartList[i].DestPortRangeMax == '-1')?'':QosSmartList[i].DestPortRangeMax;
	    QosSmartList[i].SourcePort = (QosSmartList[i].SourcePort == '-1')?'':QosSmartList[i].SourcePort;
	    QosSmartList[i].SourcePortRangeMax = (QosSmartList[i].SourcePortRangeMax == '-1')?'':QosSmartList[i].SourcePortRangeMax;    
	    QosSmartList[i].VLANIDCheck = (QosSmartList[i].VLANIDCheck == '-1')?'':QosSmartList[i].VLANIDCheck;
	    QosSmartList[i].TRAFFIC = ('-1' == QosSmartList[i].TRAFFIC) ? '' : QosSmartList[i].TRAFFIC;
	    QosSmartList[i].PRIMARK = ('-1' == QosSmartList[i].PRIMARK) ? '' : QosSmartList[i].PRIMARK;
	    QosSmartList[i].TRAFFICMARK = ('-1' == QosSmartList[i].TRAFFICMARK) ? '' : QosSmartList[i].TRAFFICMARK;
	}
}
	

function LoadFrame() {	
    ClassInterfaceInitOption();
    ReMarkModeInitOption()
    loadlanguage();	
    if (QosSmartPriFlag != 1) {
    Get802dot1pByDSCP();
    setDisable('PRIMark', 1);
    }
    LoadSmartEnable();
    paraCompensate();

    if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) {
        $("input").attr("disabled","true");
        $("button").attr("disabled","true");
        $("select").attr("disabled","true");				
    }

    if((CfgModeWord.toUpperCase() == "SAFARICOM2") || (CfgModeWord.toUpperCase() == "SAFARICOM")) {
        document.getElementById("Bandwidth").style.display = "block";
        LoadSmartBandwidth();
    }

    if (curLanguage.toUpperCase() == 'BRASIL') {
        DestIP.style.width = "250px";
        DestMask.style.width = "250px";
        SourceIP.style.width = "250px";
        SourceMask.style.width = "250px";
        DestPort.style.width = "250px";
        DestPortRangeMax.style.width = "250px";
        SourcePort.style.width = "250px";
        SourcePortRangeMax.style.width = "250px";
    }
}

function ShortFormatStr( originData)
{
     var shortData = '';
     var shortLen  = 16;
    	    
    if(originData.length <= shortLen)
    {
        shortData = originData;    	        
    }
    else
    {
        shortData = originData.substr(0, shortLen) + '...';
    }
    
    return shortData;
}

function PortDisp(StartPort, EndPort)
{
    var defaultStr = '--';
    var novalue = '';
    if (novalue == StartPort && novalue == EndPort)
    {
        return defaultStr;
    }
    if (novalue != StartPort && novalue != EndPort) 
    {
        return StartPort + '-' + EndPort;
    }
    return (StartPort == novalue)? EndPort:StartPort;
}

function InitTableData()
{
	var TableDataInfo = new Array();
	var ShowButtonFlag = true;
    var RecordCount = QosSmartList.length - 1;
    var i = 0;
	var Listlen = 0;
	
	paraCompensate();
    if (RecordCount == 0)
    {
		TableDataInfo[Listlen] = new QosSmartItem();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].ClassInterface = '--';
		TableDataInfo[Listlen].VLANIDCheck = '--';
		TableDataInfo[Listlen].Protocol = '--';
		TableDataInfo[Listlen].DestIPMask = '--';
		TableDataInfo[Listlen].SrcIPMask = '--';
		TableDataInfo[Listlen].DestPortRange = '--';
		TableDataInfo[Listlen].SrcPortRange = '--';
		TableDataInfo[Listlen].DSCPMark = '--';
		TableDataInfo[Listlen].pbitmark = '--';
        if (DisplayControl)
        {
			TableDataInfo[Listlen].TRAFFIC = '--';
			TableDataInfo[Listlen].remarkmode = '--';
			TableDataInfo[Listlen].tcremark = '--';
			TableDataInfo[Listlen].primark = '--';
        }
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, QosSmartConfiglistInfo, qos_smart_language, null);
    	return;
    }

    for (i = 0; i < RecordCount; i++)
    {
		TableDataInfo[Listlen] = new QosSmartItem();
		TableDataInfo[Listlen].domain = QosSmartList[i].Domain;
    	if ('' != QosSmartList[i].ClassInterface)
    	{
			TableDataInfo[Listlen].ClassInterface = QosSmartList[i].ClassInterface;
    	}
    	else
    	{
			TableDataInfo[Listlen].ClassInterface = '--';
    	}
    	
    	if ('' != QosSmartList[i].VLANIDCheck)
    	{
			TableDataInfo[Listlen].VLANIDCheck = QosSmartList[i].VLANIDCheck;
    	}
    	else
    	{
			TableDataInfo[Listlen].VLANIDCheck = '--';
    	}
    	
    	if ('' != QosSmartList[i].Protocol)
    	{
			TableDataInfo[Listlen].Protocol = QosSmartList[i].Protocol;
    	}
    	else
    	{
			TableDataInfo[Listlen].Protocol = '--';
    	}
    	
    	if ('' != QosSmartList[i].DestIP)
    	{  	
    		TableDataInfo[Listlen].DestIPMask = ShortFormatStr(QosSmartList[i].DestIP) + '/<br>' + ShortFormatStr(QosSmartList[i].DestMask);
		}
    	else
    	{
			TableDataInfo[Listlen].DestIPMask = '--';
    	}
    	
    	if ('' != QosSmartList[i].SourceIP)
    	{       	    
			TableDataInfo[Listlen].SrcIPMask = ShortFormatStr(QosSmartList[i].SourceIP) + '/<br>' + ShortFormatStr(QosSmartList[i].SourceMask);
    	}
    	else
    	{
			TableDataInfo[Listlen].SrcIPMask = '--';
    	} 
		TableDataInfo[Listlen].DestPortRange = PortDisp(QosSmartList[i].DestPort, QosSmartList[i].DestPortRangeMax);
		TableDataInfo[Listlen].SrcPortRange = PortDisp(QosSmartList[i].SourcePort, QosSmartList[i].SourcePortRangeMax);
		TableDataInfo[Listlen].DSCPMark = QosSmartList[i].DSCPMark;
		if (1 == QosSmartPriFlag)
		{
			TableDataInfo[Listlen].pbitmark = QosSmartList[i].PRIMARK;
		}
		else
		{
		TableDataInfo[Listlen].pbitmark = QosSmartList[i].DSCPMark>>3;
		}
        if (DisplayControl)
        {
			TableDataInfo[Listlen].TRAFFIC = QosSmartList[i].TRAFFIC;
			TableDataInfo[Listlen].remarkmode = ReMarkModeNum2ReMarkModeName(QosSmartList[i]);
		
        	if (-1 == QosSmartList[i].PRIMARK || '' == QosSmartList[i].PRIMARK)
        	{
				TableDataInfo[Listlen].tcremark = QosSmartList[i].TRAFFICMARK;
				TableDataInfo[Listlen].primark = '--';
        	}
        	else
        	{
				TableDataInfo[Listlen].tcremark = '--';
				TableDataInfo[Listlen].primark = QosSmartList[i].PRIMARK;
			}
        }
		Listlen++;
    }
    TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, QosSmartConfiglistInfo, qos_smart_language, null);

	for (var i = 0; i < RecordCount; i++)
	{
		var DestIPMaskId = 'QosSmartConfigList_' + i +'_4';
		if ('' != QosSmartList[i].SourceIP)
		{
			document.getElementById(DestIPMaskId).title = QosSmartList[i].DestIP + '/' + QosSmartList[i].DestMask;
		}
		
		var SrcIPMaskId = 'QosSmartConfigList_' + i +'_5';
		if ('' != QosSmartList[i].SourceIP)
		{
			document.getElementById(SrcIPMaskId).title = QosSmartList[i].SourceIP + '/' + QosSmartList[i].SourceMask;
		}
	}
}

function GetInputRuleInfo()
{
 if (1 == QosSmartPriFlag)
 {
 var qosSmartItem = new QosSmartItem("",getSelectVal("ClassInterface"), getValue("QosSmartDomainId"),getValue("DestIP"),
                                     getValue("DestMask"),getValue("SourceIP"),getValue("SourceMask"),
                                     getValue("Protocol"), getValue("DestPort"),getValue("DestPortRangeMax"),
                                     getValue("SourcePort"), getValue("SourcePortRangeMax"),
                                     getValue("DSCPMark"),getValue("VLANIDCheck"),
                                     getValue("TcMark"),
										 getValue("PRIMark"),getValue("TcReMark")); 
 }
 else
 {
	 var qosSmartItem = new QosSmartItem("",getSelectVal("ClassInterface"), getValue("QosSmartDomainId"),getValue("DestIP"),
										 getValue("DestMask"),getValue("SourceIP"),getValue("SourceMask"),
										 getValue("Protocol"), getValue("DestPort"),getValue("DestPortRangeMax"),
										 getValue("SourcePort"), getValue("SourcePortRangeMax"),
										 getValue("DSCPMark"),getValue("VLANIDCheck"),
										 getValue("TcMark"),
                                     getValue("TcPriMark"), getValue("TcReMark")); 
 }

 return qosSmartItem;
}

function SetInputRuleInfo(QosSmartItem)
{
    setSelect("ClassInterface", LanName2LanDomain(QosSmartItem.ClassInterface)); 
    setText("DestIP", QosSmartItem.DestIP);
    setText("DestMask", QosSmartItem.DestMask);
    setText("SourceIP", QosSmartItem.SourceIP);
    setText("SourceMask", QosSmartItem.SourceMask);
    setText("QosSmartDomainId", QosSmartItem.QosSmartDomain);
    setText("Protocol", QosSmartItem.Protocol);
    setText("DestPort", QosSmartItem.DestPort);
    setText("DestPortRangeMax", QosSmartItem.DestPortRangeMax);
    setText("SourcePort", QosSmartItem.SourcePort);
    setText("SourcePortRangeMax", QosSmartItem.SourcePortRangeMax);
    setText("DSCPMark", QosSmartItem.DSCPMark);
    if (1 == QosSmartPriFlag)
    {
		setText("PRIMark", QosSmartItem.PRIMARK);
    }
	else
	{
    Get802dot1pByDSCP();
	}
    setText("VLANIDCheck", QosSmartItem.VLANIDCheck);
    setText("TcMark", QosSmartItem.TRAFFIC);
    setSelect("ReMarkMode", ((-1 == QosSmartItem.PRIMARK || '' == QosSmartItem.PRIMARK ) ? 0 : 1));
    setText("TcReMark", QosSmartItem.TRAFFICMARK);
    setText("TcPriMark", QosSmartItem.PRIMARK);
}

function ReMarkModeChange()
{
	var ReMarkModeVal = getSelectVal('ReMarkMode');

	if (0 == ReMarkModeVal)
	{
		document.getElementById("TcReMarkRow").style.display = "";
		document.getElementById("TcPriMarkRow").style.display = "none";
	}
	else if (1 == ReMarkModeVal)
	{
		document.getElementById("TcReMarkRow").style.display = "none";
		document.getElementById("TcPriMarkRow").style.display = "";	
	}
}

function OnNewInstance(index)
{
   OperatorFlag = 1;

   var qossmartitem = new QosSmartItem("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
   document.getElementById("TableConfigInfo").style.display = "block";

  if (!DisplayControl)
  {
    document.getElementById("TcMarkRow").style.display = "none";
    document.getElementById("TcPriMarkRow").style.display = "none";
    document.getElementById("TcReMarkRow").style.display = "none";
    document.getElementById("ReMarkModeRow").style.display = "none";
  }
  else
  {
    document.getElementById("TcPriMarkRow").style.display = "none";
    document.getElementById("TcReMarkRow").style.display = "";
  }

   SetInputRuleInfo(qossmartitem);
}

function ModifyInstance(index)
{
    OperatorFlag = 2;

    document.getElementById("TableConfigInfo").style.display = "block";
	if (!DisplayControl)
	{
   		document.getElementById("TcMarkRow").style.display = "none";
   		document.getElementById("TcPriMarkRow").style.display = "none";
   		document.getElementById("TcReMarkRow").style.display = "none";
   		document.getElementById("ReMarkModeRow").style.display = "none";
	}
	else if (-1 == QosSmartList[index].PRIMARK || '' == QosSmartList[index].PRIMARK)
	{
		document.getElementById("TcPriMarkRow").style.display = "none";
		document.getElementById("TcReMarkRow").style.display = "";
	}
	else
	{
		document.getElementById("TcReMarkRow").style.display = "none";
		document.getElementById("TcPriMarkRow").style.display = "";	
	}
    SetInputRuleInfo(QosSmartList[index]);
}

function setControl(index)
{ 
    if (-1 == index)
    {
        if (QosSmartList.length-1 == MaxQosSmartRule)
        {
            var tableRow = getElementById(TableName);
            tableRow.deleteRow(tableRow.rows.length-1);
            AlertEx(qos_smart_language['bbsp_qossmartfull']);
            return false;
        }
    }
    
    selIndex = index;
	if (index < -1)
	{
		return;
	}

    if (-1 == index)
    {        
        return OnNewInstance(index);
    }
    else
    {
        return ModifyInstance(index);
    }
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
}

function IsRepeateConfig(RuleInfo)
{
    var i = 0;
    for(i = 0; i < QosSmartList.length-1; i++)
    {
        if (i != selIndex)
        {
            if ((QosSmartList[i].ClassInterface == RuleInfo.ClassInterface)
                && (QosSmartList[i].VLANIDCheck == RuleInfo.VLANIDCheck)
                && (QosSmartList[i].QosSmartDomain == RuleInfo.QosSmartDomain)
                && (QosSmartList[i].Protocol == RuleInfo.Protocol)
                && (QosSmartList[i].DestIP == RuleInfo.DestIP)
                && (QosSmartList[i].DestMask == RuleInfo.DestMask)
                && (QosSmartList[i].SourceIP == RuleInfo.SourceIP)
                && (QosSmartList[i].SourceMask == RuleInfo.SourceMask)
                && (QosSmartList[i].DestPort == RuleInfo.DestPort)
                && (QosSmartList[i].DestPortRangeMax == RuleInfo.DestPortRangeMax)
                && (QosSmartList[i].SourcePort == RuleInfo.SourcePort)
                && (QosSmartList[i].SourcePortRangeMax == RuleInfo.SourcePortRangeMax))
            {
                return true;
            }        
        }
    }
    return false;
}

function IPV6IpCheck(Address, Mask)
{
    if (Address != "")
    {
	    if (IsIPv6AddressValid(Address) == false || IsIPv6ZeroAddress(Address) == true || IsIPv6LoopBackAddress(Address) == true || IsIPv6MulticastAddress(Address) == true)
        {
            return 4;
        }
    }
    if ((Mask != '') && ( isValidIPV6SubnetMask(Mask) == false) )
    {            
        return 5;
    }
    return 6;
}

function IPV4IpCheck(Address, Mask)
{
    if(Address != "")
    {
        if ( isAbcIpAddress(Address) == false 
            || isDeIpAddress(Address) == true 
            || isBroadcastIpAddress(Address) == true 
            || isLoopIpAddress(Address) == true ) 
        {              	
            return 1;
        }
    }	 	  

    if ((Mask != '') && ( isValidSubnetMask(Mask) == false) )
    {            
        return 2;
    }

    return 3;
}

function IpValidCheck(RuleInfo)
{  
    var v4DipCheckRet = 0; 
    var v6DipCheckRet = 0; 
    if ((RuleInfo.DestIP == '') && (RuleInfo.DestMask == '') 
        && (RuleInfo.SourceIP == '') && (RuleInfo.SourceMask == ''))
    {
        return true;
    }
    
    if (((RuleInfo.DestIP == '') && (RuleInfo.DestMask != ''))
       || ((RuleInfo.SourceIP == '') && (RuleInfo.SourceMask != '')))
    {
        AlertEx(qos_smart_language['bbsp_ipneed']);
	    return false;
    }
    
    v4DipCheckRet = IPV4IpCheck(RuleInfo.DestIP, RuleInfo.DestMask );
    v6DipCheckRet = IPV6IpCheck(RuleInfo.DestIP, RuleInfo.DestMask);
    
    if ((RuleInfo.DestIP != '') && (3 != v4DipCheckRet) && (6 != v6DipCheckRet))
    {
        if ((1 == v4DipCheckRet) && (4 == v6DipCheckRet))
        {
            AlertEx(qos_smart_language['bbsp_ipaddress'] + RuleInfo.DestIP + qos_smart_language['bbsp_alert_invail']);
        }
        if (((2 == v4DipCheckRet) && (4 == v6DipCheckRet))
            ||((1 == v4DipCheckRet) && (5 == v6DipCheckRet)))
        {
            AlertEx(qos_smart_language['bbsp_mask'] + RuleInfo.DestMask + qos_smart_language['bbsp_alert_invail']);
        }
        
	    return false;
    }

	var v4SipCheckRet = 0;
	var v6SipCheckRet = 0;

	v4SipCheckRet = IPV4IpCheck(RuleInfo.SourceIP, RuleInfo.SourceMask );
    v6SipCheckRet = IPV6IpCheck(RuleInfo.SourceIP, RuleInfo.SourceMask);
    
    if ((RuleInfo.SourceIP != '')  && (3 != v4SipCheckRet) && (6 != v6SipCheckRet))
    {
        if ((1 == v4SipCheckRet) && (4 == v6SipCheckRet))
        {
            AlertEx(qos_smart_language['bbsp_ipaddress'] + RuleInfo.SourceIP + qos_smart_language['bbsp_alert_invail']);
        }
        if (((2 == v4SipCheckRet) && (4 == v6SipCheckRet))
            ||((1 == v4SipCheckRet) && (5 == v6SipCheckRet)))
        {
            AlertEx(qos_smart_language['bbsp_mask'] + RuleInfo.SourceMask + qos_smart_language['bbsp_alert_invail']);
        }
        
	    return false;
    }
    
    if ((RuleInfo.SourceIP != '') && (RuleInfo.DestIP != ''))
    {
        if ((3 == v4DipCheckRet ) && (6 == v6SipCheckRet))
        {
            AlertEx(qos_smart_language['bbsp_alert_ipaddr_v4_v6_not_match']);
	        return false;
        }

        if ((6 == v6DipCheckRet)  && (3 == v4SipCheckRet))
        {
            AlertEx(qos_smart_language['bbsp_alert_ipaddr_v4_v6_not_match']);
	        return false;
        } 
    } 
        
	return true;
}

function PortCheck(Protocol, StartPort, EndPort)
{	
	if ((StartPort == '') && (EndPort == ''))
	{
	    return true;
	}
	
	if ((Protocol != 6) && (Protocol != 17))
	{
	    AlertEx(qos_smart_language['bbsp_port_protocol_not_match']);
        return false;
	}
	
	if ((StartPort != "") && (false == CheckNumber(StartPort, 0, 65535)))
    {
        AlertEx(qos_smart_language['bbsp_port'] + StartPort + qos_smart_language['bbsp_alert_invail']);
        return false;
    }
    
    if ((EndPort != "") && (false == CheckNumber(EndPort, 0, 65535)))
    {
        AlertEx(qos_smart_language['bbsp_port'] + EndPort + qos_smart_language['bbsp_alert_invail']);
        return false;
    }
    
    if (parseInt(StartPort, 10) > parseInt(EndPort, 10))
    {
        AlertEx(qos_smart_language['bbsp_portrangeinvalid']);
        return false;
    }

	return true;
}

function CheckForm(RuleInfo)
{
	if ((RuleInfo.VLANIDCheck != "") && (false == CheckNumber(RuleInfo.VLANIDCheck, 0, 4094)))
    {
        AlertEx(qos_smart_language['bbsp_vlanidinvalid']);
        return false;
    }
 
	if ((RuleInfo.Protocol != "") && (false == CheckNumber(RuleInfo.Protocol, 0, 255)))
    {
        AlertEx(qos_smart_language['bbsp_protocolidinvalid']);
        return false;
    }

	if(false == PortCheck(RuleInfo.Protocol, RuleInfo.DestPort, RuleInfo.DestPortRangeMax))
    {
        return false;
    }
    
	if(false == PortCheck(RuleInfo.Protocol, RuleInfo.SourcePort, RuleInfo.SourcePortRangeMax))
    {
        return false;
    }

	if ( "" == RuleInfo.DSCPMark)
    {
         AlertEx(qos_smart_language['bbsp_dscpneed']);
         return false;
    }
	if ((1 == QosSmartPriFlag) && ( "" == RuleInfo.PRIMARK))
    {
         AlertEx(qos_smart_language['bbsp_pbitneed']);
         return false;
    }
    
	if ((RuleInfo.DSCPMark != "") && (false == CheckNumber(RuleInfo.DSCPMark, 0, 63)))
    {
        AlertEx(qos_smart_language['bbsp_dscpidinvalid']);
        return false;
    }

	if ((1 == QosSmartPriFlag) && (RuleInfo.PRIMARK != "") && (false == CheckNumber(RuleInfo.PRIMARK, 0, 7)))
    {
        AlertEx(qos_smart_language['bbsp_tcprimarkinvalid']);
        return false;
    }

	if (DisplayControl)
	{
		if (false == CheckNumber(RuleInfo.TRAFFIC, 0, 255))
		{
			AlertEx(qos_smart_language['bbsp_tcmarkinvalid']);
			return false;
		}
	
		if ((("" == RuleInfo.TRAFFICMARK) && 0 == getSelectVal("ReMarkMode")) 
			|| ("" != RuleInfo.TRAFFICMARK && 0 == getSelectVal("ReMarkMode") && (false == CheckNumber(RuleInfo.TRAFFICMARK, 0, 255))))
		{
			AlertEx(qos_smart_language['bbsp_tcremarkinvalid']);
			return false;	
		}
		
		if ((("" == RuleInfo.PRIMARK) && 1 == getSelectVal("ReMarkMode")) 
			|| ("" != RuleInfo.PRIMARK && 1== getSelectVal("ReMarkMode") && (false == CheckNumber(RuleInfo.PRIMARK, 0, 7))))
		{
			AlertEx(qos_smart_language['bbsp_tcprimarkinvalid']);
			return false;
		}	
	}
	
    return true;
}

function FillupSubmitPara(Form, RuleInfo)
{
    if(RuleInfo.ClassInterface.length)
    {
        Form.addParameter('x.ClassInterface', LanName2LanDomain(RuleInfo.ClassInterface));
    }
    else
    {
    	Form.addParameter('x.ClassInterface', '');
    }
   
    if(RuleInfo.QosSmartDomain.length)
    {
        Form.addParameter('x.DomainName', RuleInfo.QosSmartDomain);
    }
    else
    {
    	Form.addParameter('x.DomainName', '');
    }
    
    if (RuleInfo.DestIP.length)
    {
        Form.addParameter('x.DestIP', RuleInfo.DestIP);
    } 
    else
    {
    	Form.addParameter('x.DestIP', '');
    }  
    if (RuleInfo.DestMask.length)
    {
        Form.addParameter('x.DestMask', RuleInfo.DestMask);
    }
    else
    {
    	Form.addParameter('x.DestMask', '');
    }
    if (RuleInfo.SourceIP.length)
    {
        Form.addParameter('x.SourceIP', RuleInfo.SourceIP);
    }
    else
    {
    	Form.addParameter('x.SourceIP', '');
    }
    if (RuleInfo.SourceMask.length)
    {
        Form.addParameter('x.SourceMask', RuleInfo.SourceMask);
    }
    else
    {
    	Form.addParameter('x.SourceMask', '');
    }
    if (!RuleInfo.Protocol.length)
    {
        RuleInfo.Protocol = -1;
    }
    Form.addParameter('x.Protocol', RuleInfo.Protocol);
    
    if (!RuleInfo.DestPort.length)
    {
    	RuleInfo.DestPort = -1;        
    }
    Form.addParameter('x.DestPort', RuleInfo.DestPort);
    
    if (!RuleInfo.DestPortRangeMax.length)
    {
        RuleInfo.DestPortRangeMax = -1;
    }
    Form.addParameter('x.DestPortRangeMax', RuleInfo.DestPortRangeMax);
    
    if (!RuleInfo.SourcePort.length)
    {
        RuleInfo.SourcePort = -1;
    }
    Form.addParameter('x.SourcePort', RuleInfo.SourcePort);
    
    if (!RuleInfo.SourcePortRangeMax.length)
    {
        RuleInfo.SourcePortRangeMax = -1; 
    }
    Form.addParameter('x.SourcePortRangeMax', RuleInfo.SourcePortRangeMax);
    
    if (RuleInfo.DSCPMark.length)
    {
        Form.addParameter('x.DSCPMark', RuleInfo.DSCPMark);
    }
    
    if(!RuleInfo.VLANIDCheck.length)
    {
        RuleInfo.VLANIDCheck = -1;
    }
    Form.addParameter('x.VLANIDCheck', RuleInfo.VLANIDCheck);
    
    if (1 == QosSmartPriFlag)
    {
		if (!DisplayControl)
		{
			RuleInfo.TRAFFIC = -1;
			RuleInfo.TRAFFICMARK = -1;	
		}
		else
		{
			RuleInfo.TRAFFICMARK = -1;		
		}

		Form.addParameter('x.PRIMARK', ('' == RuleInfo.PRIMARK) ? -1 : RuleInfo.PRIMARK);

	}
	else
	{
    if (!DisplayControl)
    {
    	RuleInfo.TRAFFIC = -1;
    	RuleInfo.PRIMARK = -1;
    	RuleInfo.TRAFFICMARK = -1;	
    }
    if (0 == getSelectVal("ReMarkMode"))
    {
    	RuleInfo.PRIMARK = -1;
    }
    else
    {
		RuleInfo.TRAFFICMARK = -1;		
		}
   	}
	if (DisplayControl)
	{
		Form.addParameter('x.TRAFFIC', ('' == RuleInfo.TRAFFIC) ? -1 : RuleInfo.TRAFFIC);
		Form.addParameter('x.PRIMARK', ('' == RuleInfo.PRIMARK) ? -1 : RuleInfo.PRIMARK);
		Form.addParameter('x.TRAFFICMARK', ('' == RuleInfo.TRAFFICMARK) ? -1 : RuleInfo.TRAFFICMARK);
	}
}

function OnModifySubmit()
{
    var RuleInfo = GetInputRuleInfo();
    
    if (CheckForm(RuleInfo) == false)
    {
        return false;
    }
    

    if (true == IsRepeateConfig(RuleInfo))
    {
        AlertEx(qos_smart_language['bbsp_ruleexist']);
        return false;
    }
  
    var Form = new webSubmitForm();
    FillupSubmitPara(Form, RuleInfo);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));   
    Form.setAction('set.cgi?' +'x='+ QosSmartList[selIndex].Domain + '&RequestFile=html/bbsp/qossmart/qossmart.asp');
    Form.submit();

}


function OnAddNewSubmit()
{
    var RuleInfo = GetInputRuleInfo();
    if (CheckForm(RuleInfo) == false)
    {
        return false;
    }

    if (true == IsRepeateConfig(RuleInfo))
    {
        AlertEx(qos_smart_language['bbsp_ruleexist']);
        return false;
    } 

    var Form = new webSubmitForm();
    FillupSubmitPara(Form, RuleInfo);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.QueueManagement.X_HW_Classification' + '&RequestFile=html/bbsp/qossmart/qossmart.asp');
    Form.submit();
    DisableRepeatSubmit();
}

function QosSmartConfigListselectRemoveCnt(val)
{
}

function OnDeleteButtonClick(TableID)
{
    var CheckBoxList = document.getElementsByName(TableName + 'rml');
    var Count = 0;
    var i;
    for (i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked == true)
        {
            Count++;
        }
    }

    if (Count == 0)
    {
        return false;
    }

    var Form = new webSubmitForm();
    for (i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }

        Form.addParameter(CheckBoxList[i].value,'');
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.QueueManagement.X_HW_Classification' + '&RequestFile=html/bbsp/qossmart/qossmart.asp');
    Form.submit();
	DisableRepeatSubmit();
}


function OnApply()
{
    if (OperatorFlag == 1)
    {
        return OnAddNewSubmit();
    }
    else
    {
        return OnModifySubmit();
    }
}

function OnCancel()
{
    getElById('TableConfigInfo').style.display = 'none';
    getElById('TableConfigInfo').style.display = 'none';
    
    if (selIndex == -1)
    {
         var tableRow = getElementById(TableName);
         if (tableRow.rows.length > 2)
         tableRow.deleteRow(tableRow.rows.length-1);
         return false;
     }
}

function Get802dot1pByDSCP()
{   
    var DSCP = 0;
    
    if ('' == getValue("DSCPMark"))
    {
        setText("PRIMark",'');  
        return;
    }
    DSCP = parseInt(getValue("DSCPMark"), 10); 
    setText("PRIMark", DSCP>>3);  
    return; 
}


</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("qossmarttitle", GetDescFormArrayById(qos_smart_language, "bbsp_mune"), GetDescFormArrayById(qos_smart_language, "bbsp_qos_smart_title"), false);
</script> 
<div class="title_spread"></div>

<div  id="divqossmart" style="overflow-x:auto;overflow-y:hidden;width:100%;">
<form id="QosSmartEnableForm" style="display:block;">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
        <li   id="QosSmartEnableValue"                 RealType="CheckBox"           DescRef="bbsp_enableqossmart"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_ClassificationEnable"             InitValue="Empty" ClickFuncApp="onclick=SubmitEnableForm"/>
    </table>
    <script>
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        var QosSmartEnableConfigFormList = new Array();
        QosSmartEnableConfigFormList = HWGetLiIdListByForm("QosSmartEnableForm", null);
        HWParsePageControlByID("QosSmartEnableForm", TableClass, qos_smart_language, null);
    </script>
    <div class="func_spread"></div>
</form>

<form id="Bandwidth" style="display:none;">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
        <li   id="SetBandwidth"  RealType="TextBox"   DescRef="bbsp_qossmartdownbandwidth"  RemarkRef="bbsp_qossmartdownbandwidthunit"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_Down_Bandwidth"             InitValue="Empty"/>
    </table>
    <script>
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        var QosSmartEnableConfigFormList = new Array();
        QosSmartEnableConfigFormList = HWGetLiIdListByForm("Bandwidth", null);
        HWParsePageControlByID("Bandwidth", TableClass, qos_smart_language, null);
    </script>
    <table width="100%"  cellspacing="1" class="table_button"> 
        <tr> 
          <td class="width_per25"></td> 
          <td class="table_submit pad_left10p">
              <button id='BandwidthApply' type=button onclick = "javascript:return SubmitBandwidthForm();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(qos_smart_language['bbsp_qossmartapp']);</script></button>
          </td> 
        </tr> 
      </table> 
	<div class="func_spread"></div>
</form>

<script language="JavaScript" type="text/javascript">
	var QosSmartConfiglistInfo = new Array();
	var ColumnNum = '';
	if (CfgModeWord.toUpperCase() == "ROSUNION") {
		QosSmartConfiglistInfo.push(new stTableTileInfo("Empty","align_center width_per5","DomainBox"));
	} else {
		QosSmartConfiglistInfo.push(new stTableTileInfo("Empty","align_center width_per3","DomainBox"));
	}
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartclassinterface","align_center","ClassInterface"));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartvlan","align_center","VLANIDCheck"));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartprotocol","align_center","Protocol"));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartdestipmask","align_center restrict_dir_ltr","DestIPMask", false,"",0));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartsrcipmask","align_center restrict_dir_ltr","SrcIPMask", false,"",0));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartdestportrange","align_center","DestPortRange"));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartsrcportrange","align_center","SrcPortRange"));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmardscpmark","align_center","DSCPMark"));
	QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartpbitmark","align_center","pbitmark"));
	ColumnNum = 10;
	if (DisplayControl)
	{
		QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmarttcmark","align_center","TRAFFIC"));
		QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartremarkmode","align_center","remarkmode"));
		QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmarttcremark","align_center","tcremark"));
		QosSmartConfiglistInfo.push(new stTableTileInfo("bbsp_qossmartprimark","align_center","primark"));
		ColumnNum = 14;
	}
	QosSmartConfiglistInfo.push(new stTableTileInfo(null));
	InitTableData();
</script> 
 
<form id="TableConfigInfo" style="display:none;"> 
 <div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="ClassInterface"              RealType="DropDownList"       DescRef="Empty"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.ClassInterface"    Elementclass="width_260px"     InitValue=""/>
		<li   id="VLANIDCheck"                 RealType="TextBox"            DescRef="Empty"             RemarkRef="bbsp_vlanrange"   ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.VLANIDCheck"       Elementclass="width_260px"     InitValue="Empty"    MaxLength='4'/>
		<li   id="Protocol"                    RealType="TextBox"            DescRef="Empty"        RemarkRef="bbsp_protocolrange"    ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.Protocol"          Elementclass="width_260px"     InitValue="Empty"    MaxLength='3'/>
		<li   id="QosSmartDomainId"            RealType="TextBox"            DescRef="Empty"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DomainName"        Elementclass="width_260px"     InitValue="Empty"    MaxLength='64'/>
		<li   id="DestIP"                      RealType="TextOtherBox"       DescRef="Empty"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DestIP"            Elementclass="width_260px restrict_dir_ltr"         MaxLength="64" 
		InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'DestIPBias'},{AttrName:'innerhtml', AttrValue:'bbsp_bias'}]},
					{Type:'text',Item:[{AttrName:'id',AttrValue:'DestMask'},{AttrName:'BindFileld', AttrValue:'x.DestMask'},{AttrName:'MaxLength', AttrValue:'64'},{AttrName:'class', AttrValue:'width_260px restrict_dir_ltr'}]}]"/>    
		<li   id="SourceIP"                    RealType="TextOtherBox"       DescRef="Empty"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.SourceIP"          Elementclass="width_260px restrict_dir_ltr"         MaxLength="64" 
		InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'SourceIPBias'},{AttrName:'innerhtml', AttrValue:'bbsp_bias'}]},
					{Type:'text',Item:[{AttrName:'id',AttrValue:'SourceMask'},{AttrName:'BindFileld', AttrValue:'x.SourceMask'},{AttrName:'MaxLength', AttrValue:'64'},{AttrName:'class', AttrValue:'width_260px restrict_dir_ltr'}]}]"/>    
		<li   id="DestPort"                    RealType="TextOtherBox"       DescRef="Empty"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DestPort"          Elementclass="width_260px "     MaxLength="5" 
		InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'DestPortDash'},{AttrName:'innerhtml', AttrValue:'bbsp_dash'}]},
					{Type:'text',Item:[{AttrName:'id',AttrValue:'DestPortRangeMax'},{AttrName:'BindFileld', AttrValue:'x.DestPortRangeMax'},{AttrName:'MaxLength', AttrValue:'5'},{AttrName:'class', AttrValue:'width_260px'}]}]"/>    
		<li   id="SourcePort"                  RealType="TextOtherBox"       DescRef="Empty"             RemarkRef="Empty"            ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.SourcePort"          Elementclass="width_260px "     MaxLength="5" 
		InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'SourcePortDash'},{AttrName:'innerhtml', AttrValue:'bbsp_dash'}]},
					{Type:'text',Item:[{AttrName:'id',AttrValue:'SourcePortRangeMax'},{AttrName:'BindFileld', AttrValue:'x.SourcePortRangeMax'},{AttrName:'MaxLength', AttrValue:'5'},{AttrName:'class', AttrValue:'width_260px'}]}]"/>    
		<script language="JavaScript" type="text/javascript">
		if (1 == QosSmartPriFlag)
		{
			document.write("\<li   id=\"DSCPMark\"                 RealType=\"TextBox\"            DescRef=\"Empty\"             RemarkRef=\"bbsp_DSCPrange\"      ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"x.DSCPMark\"       Elementclass=\"width_260px\"     InitValue=\"Empty\"    MaxLength='2'\/\> ");
			document.write("\<li   id=\"PRIMark\"                  RealType=\"TextBox\"            DescRef=\"Empty\"             RemarkRef=\"Empty\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"x.PRIMARK\"        Elementclass=\"width_260px\"     InitValue=\"Empty\" \/\> ");
		}
		else
		{
			document.write("\<li   id=\"DSCPMark\"                 RealType=\"TextBox\"            DescRef=\"Empty\"             RemarkRef=\"bbsp_DSCPrange\"      ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"x.DSCPMark\"       	Elementclass=\"width_260px\"     InitValue=\"Empty\"    MaxLength='2'  ClickFuncApp=\"onchange=Get802dot1pByDSCP\"\/\> ");
			document.write("\<li   id=\"PRIMark\"                  RealType=\"TextBox\"            DescRef=\"Empty\"             RemarkRef=\"bbsp_dscprelation\"   ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"x.PRIMARK\"        Elementclass=\"width_260px\"     InitValue=\"Empty\" \/\> ");
		}
		</script>
		<li   id="TcMark"                   RealType="TextBox"            DescRef="Empty"             RemarkRef="bbsp_TcMarkrange"    ErrorMsgRef="Empty"    Require="TRUE"     BindField="TcMark"           Elementclass="width_260px"     InitValue="Empty" />
		<li   id="ReMarkMode"               RealType="DropDownList"       DescRef="Empty"             RemarkRef="Empty"               ErrorMsgRef="Empty"    Require="FALSE"    BindField="ReMarkMode"       Elementclass="width_260px"     ClickFuncApp="onchange=ReMarkModeChange"/>
		<li   id="TcReMark"                 RealType="TextBox"            DescRef="Empty"             RemarkRef="bbsp_TcMarkrange"    ErrorMsgRef="Empty"    Require="TRUE"     BindField="TcReMark"         Elementclass="width_260px"     InitValue="Empty" />
		<li   id="TcPriMark"                RealType="TextBox"            DescRef="Empty"             RemarkRef="bbsp_TcPrirange"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="TcPriMark"        Elementclass="width_260px"     InitValue="Empty" />
	</table>
	<script language="JavaScript" type="text/javascript">
		var TableClass = new stTableClass("width_per15", "width_per85", "ltr");
		var QosSmartConfigFormList = new Array();
		QosSmartConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
		HWParsePageControlByID("TableConfigInfo", TableClass, qos_smart_language, null);
		setElementInnerHtmlById("ClassInterfaceColleft", appendPrompt('bbsp_qossmartclassinterface'));
		setElementInnerHtmlById("VLANIDCheckColleft", appendPrompt('bbsp_qossmartvlan'));
		setElementInnerHtmlById("ProtocolColleft", appendPrompt('bbsp_qossmartprotocol'));
		document.getElementById("Protocol").title = qos_smart_language['bbsp_protocol_title'];
		setElementInnerHtmlById("QosSmartDomainIdColleft", appendPrompt('bbsp_qossmartdomain'));
		setNoEncodeInnerHtmlValue("QosSmartDomainIdRemark", qos_smart_language['bbsp_qossmartdomaintips']);
		setElementInnerHtmlById("DestIPColleft", appendPrompt('bbsp_qossmartdestipmask'));
		setElementInnerHtmlById("SourceIPColleft", appendPrompt('bbsp_qossmartsrcipmask'));
		setElementInnerHtmlById("DestPortColleft", appendPrompt('bbsp_qossmartdestportrange'));
		setElementInnerHtmlById("SourcePortColleft", appendPrompt('bbsp_qossmartsrcportrange'));
		setElementInnerHtmlById("DSCPMarkColleft", appendPrompt('bbsp_qossmardscpmark'));
		setElementInnerHtmlById("PRIMarkColleft", appendPrompt('bbsp_qossmartpbitmark'));
		setElementInnerHtmlById("TcMarkColleft", appendPrompt('bbsp_qossmarttcmark'));
		setElementInnerHtmlById("ReMarkModeColleft", appendPrompt('bbsp_qossmartremarkmode'));
		setElementInnerHtmlById("TcReMarkColleft", appendPrompt('bbsp_qossmarttcremark'));
		setElementInnerHtmlById("TcPriMarkColleft", appendPrompt('bbsp_qossmartprimark'));
	</script>
	
    <table width="100%"  cellspacing="1" class="table_button"> 
      <tr> 
        <td class="width_per15"></td> 
        <td class="table_submit pad_left5p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			<button id='Apply' type=button onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(qos_smart_language['bbsp_qossmartapp']);</script></button>
          	<button id='Cancel' type=button onclick="javascript:OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(qos_smart_language['bbsp_qossmartcancel']);</script></button> 
		</td> 
      </tr> 
    </table> 
</form> 
<div style="height:20px;"></div>
</div>
<div style="height:20px;"></div>
</body>
</html>
