<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var TimerHandleRefresh;
var StopPageRefresh = false;
var RefreshFlag = false;
var TimeoutCount = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_CLEANOUTOFOPT.UINT32);%>';
var iponlyflg ='<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
var ProgramMaxNum = 6;
var MIP_OTHER = iptvdiagnose_language['bbsp_other'];
var TopoInfo = GetTopoInfo();
var IptvMIPList = new Array();
var g_tIPList = new Array();
var ColorList = new Array("#ff7f50", "#87cefa", "#00fa9a", "#32cd32", "#6495ed", "#ff69b4", "#ba55d3");
var firstpage = 1;
var lastpage = '';
var page = 0;

function getListNum()
{
	var listNum = 0;
	var appName = navigator.appName;
	if (appName == "Microsoft Internet Explorer")
	{
		listNum = 2000;
	}
	else
	{
		listNum = 10000;
	}
	
	return listNum;
}
function DisablePageBtn(CurPage)
{
	if ((firstpage == 0) && (lastpage == 0))
	{
		setDisable('pagejump',1);
		setDisable('jump',1);
		setDisable('button_download_id',1);
		setDisable('button_statrefresh_id',1);
		setDisable('button_stoprefresh_id',1);
	}
	else
	{
		setDisable('pagejump',0);
		setDisable('jump',0);
		setDisable('button_download_id',0);
		setDisable('button_statrefresh_id',1);
		setDisable('button_stoprefresh_id',0);
	}
	
	if(CurPage == firstpage)
	{
		setDisable('first',1);
		setDisable('prv',1);
	}
	else
	{
		setDisable('first',0);
		setDisable('prv',0);
	}
	if(CurPage == lastpage)
	{
		setDisable('next',1);
		setDisable('last',1);
	}
	else
	{
		setDisable('next',0);
		setDisable('last',0);
	}	
}

function InitPageInfo(DataList)
{
	var DataInfoNr = DataList.DiagResultList.length;

	if(DataInfoNr == 0)
	{
		firstpage = 0;
		lastpage = 0;
	}
	else
	{
		firstpage = 1;
		var listNum = getListNum();
		lastpage = DataInfoNr/listNum;
		if(lastpage != parseInt(lastpage,10))
		{
			lastpage = parseInt(lastpage,10) + 1;	
		}
	}
	
	if (!((RefreshFlag == true) && (page != 1)))
	{
		page = firstpage;
	}
	DisablePageBtn(page);
	var str = parseInt(page,10) + "/" + lastpage;
	document.getElementById("pagenum").innerHTML = str;
	return page;
}

function UpdatePageInfo(DataInfoNr,inputpage)
{
	page = inputpage;
	if (false == IsValidPage(page))
	{
		page = (0 == DataInfoNr) ? 0:1;
	}
	var str = parseInt(page,10) + "/" + lastpage;
	document.getElementById("pagenum").innerHTML = str;
	DisablePageBtn(page);
	return page;
}

function IsValidPage(pagevalue)
{
	if ((true != isInteger(pagevalue)) || (parseInt(pagevalue,10) <= 0))
	{
		return false;
	}
	return true;
}
function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		return;
	}
	ChartDataViewByPage(parseInt(page,10));
}
function submitprv()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page--;
	ChartDataViewByPage(parseInt(page,10));
}
function submitnext()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page++;
	ChartDataViewByPage(parseInt(page,10));
}
function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		return;
	}
	
	ChartDataViewByPage(parseInt(page,10));
}
function submitjump()
{
	var jumppage = getValue('pagejump');
	if((jumppage == '') || (isInteger(jumppage) != true))
	{
		setText('pagejump', '');
		return;
	}
	
	jumppage = parseInt(jumppage, 10);
	if(jumppage < firstpage)
	{
		jumppage = firstpage;
	}
	if(jumppage > lastpage)
	{
		jumppage = lastpage;
	}
	setText('pagejump', '');
	ChartDataViewByPage(jumppage);
}

function DataInfoSt()
{
	this.DiagResultList = new Array();
	this.DiagTimeList = new Array();
}

function stVideoDiagInfo(_domain, _Enbale, _IPAddr, _Interval, _DelayTime, _RecordMode, _Interface, _VlanId)
{
	this.domain = _domain;
	this.Enbale = _Enbale;
	this.IPAddr = _IPAddr;
	this.Interval = _Interval;
	this.DelayTime = _DelayTime;
	this.RecordMode = _RecordMode;
	this.PortID = _Interface;
	this.VlanID = _VlanId;
}

function stMIPData(_ip, _time, _isdel, _color)
{
	this.IP = _ip;
	this.Time = _time;
	this.IsDel = _isdel;
	this.Color = _color;
}

function stMIPInfo()
{
	this.IPList = new stMIPData('','','','');
	this.CutTime = '';
}

var VideoDiagInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_VideoDiagnostics, Enable|IpAddr|Interval|DelayTime|RecordMode|Interface|VlanId,stVideoDiagInfo);%>; 

var VideoDiagInfo = VideoDiagInfos[0];

function stIPtvDiagResult(Time, MulticastIP, VMOS, DF, MLR, PCRJITMax, PCRJITMean, BDW)
{
   this.Time = Time;
   this.MulticastIP = MulticastIP;
   this.VMOS = VMOS;
   this.DF = DF;
   this.MLR = MLR;
   this.PCRJITMax = PCRJITMax;
   this.PCRJITMean = PCRJITMean;
   this.BDW = BDW;
}

function MakeRecordInst(curRecList)
{
	var tempRecInst = new stIPtvDiagResult("", "", "", "", "", "", "", "");
	var curRecListLen = curRecList.length - 1;
	for(var i = 0; i < curRecListLen; i++)
	{
		tempRecInst.Time = $.trim(curRecList[0]);
		tempRecInst.MulticastIP = $.trim(curRecList[1]);
		tempRecInst.VMOS = ($.trim(curRecList[1]) == '0.0.0.0') ?  '-' : $.trim(curRecList[2]);
		tempRecInst.DF = ($.trim(curRecList[1]) == '0.0.0.0') ?  '-' : $.trim(curRecList[3]);
		tempRecInst.MLR = ($.trim(curRecList[1]) == '0.0.0.0') ?  '-' : $.trim(curRecList[4]);
		tempRecInst.PCRJITMax = ($.trim(curRecList[1]) == '0.0.0.0') ?  '-' : $.trim(curRecList[5]);
		tempRecInst.PCRJITMean = ($.trim(curRecList[1]) == '0.0.0.0') ?  '-' : $.trim(curRecList[6]);
		tempRecInst.BDW = ($.trim(curRecList[1]) == '0.0.0.0') ?  '-' : $.trim(curRecList[7]);
		
	}
	return tempRecInst;
}

function RemoveRepeatIP(IPList,FlagLegend)
{
	var NewIPList = new Array();
	var temp = '';
	var IPListLen = IPList.length;
	for(var i = 0; i < IPListLen; i++)
	{
		for(var j = 0; j < IPListLen; j++)
		{
			if ((i != j) && (IPList[i].IP == IPList[j].IP))
			{
				if ((FlagLegend == 1) && ((GetDateObjectTime(IPList[i].Time)) < (GetDateObjectTime(IPList[j].Time))))
				{	
					IPList[i].IsDel = 1;
				}
				if ((FlagLegend != 1) && ((GetDateObjectTime(IPList[i].Time)) > (GetDateObjectTime(IPList[j].Time))))
				{	
					IPList[i].IsDel = 1;
				}
			}
		}
	}
	for(var i = 0; i < IPListLen; i++)
	{
		if (IPList[i].IsDel != 1)
		{
			NewIPList.push(IPList[i]);
		}
	}
	return NewIPList;
}

function IsIpInvaild(IP)
{
	if (IP == '0.0.0.0')
	{
		return true;
	}
	return false;
}

function getColorByIP(IP,IPList)
{
	var color = '';
	var Len = IPList.length;
	for(var i = 0; i < Len; i++)
	{		
		if (IP == IPList[i].IP)
		{
			color = IPList[i].Color;
			break;
		}
	}
	return color;
}

function setMIPColor(ResultList,FlagLegend)
{
	var coloridx = 1;
	var Len = ResultList.IPList.length - 1;
	if (FlagLegend == 0)
	{
		for(var i = Len; i >= 0; i--)
		{
			if (ResultList.IPList[i].IP == MIP_OTHER)
			{
				ResultList.IPList[i].Color = ColorList[0];
			}
			else 
			{
				ResultList.IPList[i].Color = ColorList[coloridx];
				coloridx++;
			}
		}
	}
	else if (FlagLegend == 1)
	{
		for(var j = 0; j <= Len; j++)
		{
			ResultList.IPList[j].Color = getColorByIP(ResultList.IPList[j].IP, IptvMIPList.IPList);
			
		}
	}
}


function GetMulticastIPList(ResultList,FlagLegend)
{
	var num = 0;
	var Len = ResultList.length - 1;
	var CutTime = ResultList[0].Time;
	var temp = new stMIPData();
	g_tIPList = new Array();
	var IPList = new Array();
	temp.IP = ResultList[Len].MulticastIP;
	temp.Time = ResultList[Len].Time;
	temp.IsDel = 0;
	IPList.push(temp);
	g_tIPList = IPList;
	var flag = temp.IP;
	num++;
	for(var i = Len; i >= 0; i--)
	{
		if ((flag != ResultList[i].MulticastIP) && (IsIpInvaild(ResultList[i].MulticastIP) == false))
		{
			temp = new stMIPData();
			temp.Time = ResultList[i].Time;
			temp.IsDel = 0;
			if (num != ProgramMaxNum)
			{
				temp.IP = ResultList[i].MulticastIP;
				IPList.push(temp);
				flag = temp.IP;
				num++;
			}
			else
			{
				temp.IP = MIP_OTHER;
				IPList.push(temp);
				CutTime = ResultList[i].Time;
				break;
			}
		}
	}
	g_tIPList = IPList;
	
	var MIPList = new stMIPInfo();
	MIPList.IPList = RemoveRepeatIP(IPList,FlagLegend);
	MIPList.CutTime = CutTime;
	setMIPColor(MIPList,FlagLegend);
	

	return MIPList;
}


function GetQueryMulticastIPList(ResultList,IPList,FlagLegend)
{	
	var num = 0;
	var temp = '';
	var MIPList = '';
	var tIPList = '';
	var starttime = ResultList[0].Time;
	var endtime = ResultList[ResultList.length - 1].Time;

	if ((GetDateObjectTime(starttime) != GetDateObjectTime(endtime)) && (GetDateObjectTime(endtime) <= GetDateObjectTime(IPList.CutTime)))
	{
		tIPList = new Array();
		temp = new stMIPData();
		temp.IP = MIP_OTHER;
		temp.Time = endtime;
		temp.IsDel = 0;
		temp.Color = getColorByIP(temp.IP,IPList.IPList);
		tIPList.push(temp);		
		MIPList = new stMIPInfo();
		MIPList.IPList = tIPList;
		MIPList.CutTime = IPList.CutTime;
	}
	else
	{
		tIPList = new Array();
		temp = new stMIPData();
		temp.IP = ResultList[ResultList.length - 1].MulticastIP;
		temp.Time = ResultList[ResultList.length - 1].Time;
		temp.IsDel = 0;
		temp.Color = getColorByIP(temp.IP,IPList.IPList);
		tIPList.push(temp);
		var flag = temp.IP;
		num++;
		for(var i = ResultList.length - 1; i >= 0; i--)
		{
			if ((flag != ResultList[i].MulticastIP) && (IsIpInvaild(ResultList[i].MulticastIP) == false))
			{
				temp = new stMIPData();
				temp.Time = ResultList[i].Time;
				temp.IsDel = 0;
				if (GetDateObjectTime(ResultList[i].Time) > GetDateObjectTime(IPList.CutTime))
				{
					temp.IP = ResultList[i].MulticastIP;
					temp.Color = getColorByIP(temp.IP,IPList.IPList);
					tIPList.push(temp);
					flag = temp.IP;
					num++;
				}
				else
				{
					temp.IP = MIP_OTHER;
					temp.Color = getColorByIP(temp.IP,IPList.IPList);
					tIPList.push(temp);
					break;
				}
			}
		}
		MIPList = new stMIPInfo();
		MIPList.IPList = RemoveRepeatIP(tIPList,FlagLegend);
		MIPList.CutTime = IPList.CutTime;
	}

	return MIPList;
}

function IsExitMipOther(IPList)
{
	var Len = IPList.length;
	for(var i = 0; i < Len; i++)
	{
		if (MIP_OTHER == IPList[i].IP)
		{
			return true;
		}
	}
	return false;
}

function SetAllIPtvDiagList(ResultList,MIPList,AllDiagList)
{
	var temp = '';
	var CutTime = MIPList.CutTime;
	var IPList = MIPList.IPList;
	var IPListLen = IPList.length;
	var ResultListLen = ResultList.length;
	for(var i = 0; i < IPListLen; i++)
	{
		AllDiagList[i] = new Array();
	}
	
	if (true == IsExitMipOther(IPList))
	{
		for(var i = 0; i < IPListLen; i++)
		{
			for(var j = 0; j < ResultListLen; j++)
			{
				if (MIP_OTHER != IPList[i].IP) 
				{
					if ((IPList[i].IP == ResultList[j].MulticastIP) && (GetDateObjectTime(ResultList[j].Time) > GetDateObjectTime(CutTime)))
					{
						AllDiagList[i].push(ResultList[j]);
					}
					else
					{
						temp = new stIPtvDiagResult();
						temp.Time = ResultList[j].Time;
						temp.MulticastIP = ResultList[j].MulticastIP;
						temp.VMOS = '-';
						temp.DF = '-';
						temp.MLR = '-';
						temp.PCRJITMax = '-';
						temp.PCRJITMean = '-';
						temp.BDW = ResultList[j].BDW;
						AllDiagList[i].push(temp);
					}
				}
				else
				{
					if (GetDateObjectTime(ResultList[j].Time) <= GetDateObjectTime(CutTime))
					{
						AllDiagList[i].push(ResultList[j]);
					}
					else
					{
						temp = new stIPtvDiagResult();
						temp.Time = ResultList[j].Time;
						temp.MulticastIP = ResultList[j].MulticastIP;
						temp.VMOS = '-';
						temp.DF = '-';
						temp.MLR = '-';
						temp.PCRJITMax = '-';
						temp.PCRJITMean = '-';
						temp.BDW = ResultList[j].BDW;
						AllDiagList[i].push(temp);
					}
				}
			}
		}
	}
	else
	{
		for(var i = 0; i < IPListLen; i++)
		{
			for(var j = 0; j < ResultListLen; j++)
			{
				if (IPList[i].IP == ResultList[j].MulticastIP)
				{
					AllDiagList[i].push(ResultList[j]);
				}
				else
				{
					temp = new stIPtvDiagResult();
					temp.Time = ResultList[j].Time;
					temp.MulticastIP = ResultList[j].MulticastIP;
					temp.VMOS = '-';
					temp.DF = '-';
					temp.MLR = '-';
					temp.PCRJITMax = '-';
					temp.PCRJITMean = '-';
					temp.BDW = ResultList[j].BDW;
					AllDiagList[i].push(temp);
				}
			}
		}
	}
}


var IPtvDiagResultList = new Array();
var tIPtvDiagResultList = '';
 
function GetVmosDfMlrDataList(MIPNum, AllDiagList, AllvmosList, AllDFList, AllMLRList, AllPCRMXList, AllPCRMNList)
{
	var tmpVmosList;
	var tmpDfList;
	var tmpMlrList;
	var tmpPCRMXList;
	var tmpPCRMNList;
	for(var i = 0; i < MIPNum; i++)
	{
		var Len = AllDiagList[i].length;
		tmpVmosList = new Array();
		tmpDfList = new Array();
		tmpMlrList = new Array();
		tmpPCRMXList = new Array();
		tmpPCRMNList = new Array();
		for(var j = 0; j < Len; j++)
		{
			if(AllDiagList[i][j].MulticastIP == '0.0.0.0')
			{
				tmpVmosList.push('-');
				tmpDfList.push('-');
				tmpMlrList.push('-');
				tmpPCRMXList.push('-');
				tmpPCRMNList.push('-');
			}
			else
			{
				if(AllDiagList[i][j].VMOS == '-')
				{
					tmpVmosList.push(AllDiagList[i][j].VMOS);
				}
				else
				{
					tmpVmosList.push(AllDiagList[i][j].VMOS/10);
				}
				tmpDfList.push(AllDiagList[i][j].DF);
				tmpMlrList.push(AllDiagList[i][j].MLR);
				if(AllDiagList[i][j].PCRJITMean == '-')
				{
				    tmpPCRMNList.push('-');
				}
				else
				{
				    tmpPCRMNList.push(parseFloat((parseFloat(AllDiagList[i][j].PCRJITMean)*1000).toFixed(3)));
				}
				if(AllDiagList[i][j].PCRJITMax == '-')
				{
				    tmpPCRMXList.push('-');
				}
				else
				{
				    tmpPCRMXList.push(parseFloat((parseFloat(AllDiagList[i][j].PCRJITMax)*1000).toFixed(3)));
				}
			}
		}
		AllvmosList.push(tmpVmosList);
		AllDFList.push(tmpDfList);
		AllMLRList.push(tmpMlrList);
		AllPCRMXList.push(tmpPCRMXList);
		AllPCRMNList.push(tmpPCRMNList);
		
	}

}

function getPageData(DataList,page)
{
	var DataInfoNr = DataList.DiagResultList.length;
	tIPtvDiagResultList = DataList.DiagResultList;
	if (DataInfoNr != 0)
	{
		IptvMIPList = GetMulticastIPList(DataList.DiagResultList,0);
	}
	
	var startIdx = 0;
	var endIdx = 0;
	var listNum = getListNum();
	var PageDataList = new DataInfoSt('','');
	if(DataInfoNr == 0)
	{
		return PageDataList;
	}
	else if( DataInfoNr >= listNum*parseInt(page,10) )
	{
		startIdx = (parseInt(page,10)-1)*listNum;
		endIdx = parseInt(page,10)*listNum;
	}
	else
	{
		startIdx = (parseInt(page,10)-1)*listNum;
		endIdx = DataInfoNr;
	}

	for(var i = startIdx; i <= endIdx-1; i++)
	{
		PageDataList.DiagResultList.push(DataList.DiagResultList[i]);
		PageDataList.DiagTimeList.push(DataList.DiagResultList[i].Time);
	}
	return PageDataList;
}

function FirstChartSetData(DataList)
{
	var PageDataList = new DataInfoSt('','');
	var page = InitPageInfo(DataList);
	PageDataList = getPageData(DataList,page);
	QueryDataByPage(PageDataList);
}

function FirstChartDataView()
{
	$.ajax({
            type : "POST",
            async : true,
            cache : false,
            url : "./GetVideoDiagResult.asp",
            success : function(data) {
			var DataList = new DataInfoSt('','');
            DataList = dealDataWithFun(data);
			FirstChartSetData(DataList);
            }
        });
}

function RefreshChartDataView(DataList)
{
	var PageDataList = new DataInfoSt('','');
	var updatepage = InitPageInfo(DataList);
	PageDataList = getPageData(DataList,updatepage);
	QueryDataByPage(PageDataList);
	return;
}

function ChartDataViewByPage(inputpage)
{
	var DataList = new DataInfoSt('','');
	DataList.DiagResultList = tIPtvDiagResultList;
	var len= DataList.DiagResultList.length;
	for (var i=0;i<len;i++)
	{
		DataList.DiagTimeList.push(DataList.DiagResultList[i].Time);
	}
	var PageDataList = new DataInfoSt('','');
	var UpdatePage = UpdatePageInfo(len,inputpage);
	PageDataList = getPageData(DataList,UpdatePage);
	QueryDataByPage(PageDataList);
}

function controlEmulate(enable)
{
	if (enable == 1)
	{
		setDisable('IPAddress', 0);
		setDisable('PortId', 0);
		setDisable('VlanId', 0);
	}
	else
	{
		setDisable('IPAddress', 1);
		setDisable('PortId', 1);
		setDisable('VlanId', 1);
	}
}

var specialOption="";
var addOptionFlag = 0;
function setPortId(PortID)
{
	var portid = LanName2LanDomain(PortID);
	var EthNum = TopoInfo.EthNum;
	for(var i=1; i<=EthNum;i++)
	{
		var lanid = 'InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.'+i;
		if (lanid == portid)
		{
			setSelect('PortId', LanName2LanDomain(VideoDiagInfo.PortID)); 
			return;
		}
	}
	
	if (0 == addOptionFlag)
	{
		addOption('PortId','','','');
		setSelect('PortId', '');
		specialOption = '';
		addOptionFlag = 1;
	}
	
	return;
	
}

function DisplayVideoDiagInfo()
{
	if(VideoDiagInfo != null)
	{
		setCheck('EnableId', VideoDiagInfo.Enbale);
		setText('IntervalId', VideoDiagInfo.Interval);
		setText('DelayTimeId', VideoDiagInfo.DelayTime);
		setSelect('RecordModeId', VideoDiagInfo.RecordMode);
		var enableemulate = (VideoDiagInfo.IPAddr != '') ? 1: 0;
		setCheck('EnableEmulate', enableemulate);
		controlEmulate(enableemulate);
		setText('IPAddress', VideoDiagInfo.IPAddr);
		setPortId(VideoDiagInfo.PortID);	
		var vlanid = (VideoDiagInfo.VlanID == 0) ? '': VideoDiagInfo.VlanID;
		setText('VlanId', vlanid);
	}
}

function RefreshChartData()
{
	if(StopPageRefresh == true)
	{
	    return;
	}
	RefreshFlag = true;
	$.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "./GetVideoDiagResult.asp",
            success : function(data) {
			var DataList = new DataInfoSt('','');
            DataList = dealDataWithFun(data);		
			RefreshChartDataView(DataList);
            }
        });
		
}

function LoadFrame()
{
	DisplayVideoDiagInfo();
	FirstChartDataView();

	TimerHandleRefresh = setInterval(
		function() {
			try 
			{
				RefreshChartData();
			}
			catch (e) 
			{
		
			}
		}, 10000);	
}

function GetXaxisLabels(DiagResultList)
{
	var xAxisSteps = new Array();
	var Len = DiagResultList.length;
	
	for(var i = 0; i < Len; i++)
	{
		xAxisSteps.push(DiagResultList[i].Time);
	}
	return xAxisSteps;
}

function DisplayChartNodata(Chart)
{
	Chart.showLoading({
			text : iptvdiagnose_language['bbsp_nodata'],
			effect : 'bubble',
			textStyle : {
				fontSize : 12
			}
		});
}

function stOptionInfo(ChartId, TitleText, TooltipyAxis, yAxisName, yAxisMax, LegendId)
{
	this.ChartId = ChartId;
	this.TitleText = TitleText;
	this.TooltipyAxis = TooltipyAxis;
	this.yAxisName = yAxisName;
	this.yAxisMax = yAxisMax;
	this.LegendId = LegendId;
}

function getOptionInfo(flag)
{
	var OptionInfo = new stOptionInfo('','','','','');
	switch (flag.toUpperCase())
	{
		case "MLR":
			OptionInfo.ChartId = 'main_mlr';
			OptionInfo.TitleText = iptvdiagnose_language['bbsp_mlrchart'];
			OptionInfo.TooltipyAxis = iptvdiagnose_language['bbsp_mlrmh'];;
			OptionInfo.yAxisName = iptvdiagnose_language['bbsp_mlry'];
			OptionInfo.yAxisMax = 10000;
			OptionInfo.LegendId = 'main_mlr_legend';
			break;
		case "PCRJITMAX":
		    OptionInfo.ChartId = 'main_pcr';
			OptionInfo.TitleText = iptvdiagnose_language['bbsp_pcrchart'];
			OptionInfo.TooltipyAxis = iptvdiagnose_language['bbsp_pcrmh'];;
			OptionInfo.yAxisName = iptvdiagnose_language['bbsp_pcry'];
			OptionInfo.yAxisMax = 300;
			OptionInfo.LegendId = 'main_pcr_legend';
			break;
		default:
			break;
	}
	return OptionInfo;
}

var chartvmos = null;
var chartdf = null;
var chartmlr = null;
var chartpcrmx = null;
var chartpcrmn = null;

function initchart(flag,ChartId)
{
	var Chart = null;
	if (flag.toUpperCase() == 'MLR')
	{
		if (chartmlr != null)
		{
			chartmlr.clear;
			chartmlr.dispose();
			chartmlr = null;
		}
		chartmlr = echarts.init(document.getElementById(ChartId));
		Chart = chartmlr;
	}
	else if (flag.toUpperCase() == 'PCRJITMAX')
	{
		if (chartpcrmx != null)
		{
			chartpcrmx.clear;
			chartpcrmx.dispose();
			chartpcrmx = null;
		}
		chartpcrmx = echarts.init(document.getElementById(ChartId));
		Chart = chartpcrmx;
	}
	else if (flag.toUpperCase() == 'PCRJITMEAN')
	{
		if (chartpcrmn != null)
		{
			chartpcrmn.clear;
			chartpcrmn.dispose();
			chartpcrmn = null;
		}
		chartpcrmn = echarts.init(document.getElementById(ChartId));
		Chart = chartpcrmn;
	}
	return Chart;
}

function DisplayDiagResultInfo(flag, xDataList, yDataList, tList, MIPList, LegendMIPList)
{
	var MIPNum = (MIPList.IPList!= undefined) ? MIPList.IPList.length : 0;
	var OptionInfo = getOptionInfo(flag);
	var Chart = initchart(flag,OptionInfo.ChartId);
	
	var option = {
		title : {
			text: OptionInfo.TitleText,
			x: 'center'
		},
		animation:false,
		tooltip : {
			trigger: 'axis',
			formatter: function(params) {
				var CurIP = GetIPAddrByTime(params[0].name, tList);
				var CurBDW = GetBdwByTime(params[0].name, tList);
				var ProgramId = GetProgrameIdByTime(params[0].name, CurIP, MIPList);
				var infostr = '';
				if (-1 < ProgramId)
				{
				   if((VideoDiagInfo.RecordMode == "VerboseRecord") && (CurBDW !="-"))
				   {
				       infostr = iptvdiagnose_language['bbsp_timemh'] + params[0].name + '<br/>'
					       + OptionInfo.TooltipyAxis + params[ProgramId].value + '<br/>'
					       + iptvdiagnose_language['bbsp_ipmh'] + CurIP + '<br/>'
					       + iptvdiagnose_language['bbsp_bdwmh'] + CurBDW + iptvdiagnose_language['bbsp_bdwpmh'];
				   }
				   else
				   {
				       infostr = iptvdiagnose_language['bbsp_timemh'] + params[0].name + '<br/>'
					       + OptionInfo.TooltipyAxis + params[ProgramId].value + '<br/>'
					       + iptvdiagnose_language['bbsp_ipmh'] + CurIP;
				   }
				}
				return infostr;
			}
		},
		legend: function(){
			var dataTemp=[];			
			var item={
			data:dataTemp,
			padding: 0,
			x: 'center',
			y: 'bottom'
			}
			return item;
		}(),
		toolbox: {
			show : true,
			feature : {
				mark : {show: false},
				dataView : {show: false, title:iptvdiagnose_language['bbsp_dataview'], readOnly: true, lang: [iptvdiagnose_language['bbsp_dataview'],iptvdiagnose_language['bbsp_close'],iptvdiagnose_language['bbsp_refresh']]},
				magicType : {show: false, type: ['line']},
				restore : {show: false},
				saveAsImage : {show: false}
			}
		},
		dataZoom : {
			show : true,
			realtime : false,
			height : 20,
			y : 360,
			start : 0,
			end : 100
		},
		xAxis : [
			{
				type : 'category',
				boundaryGap : false,
				axisLine: {onZero: false},
				data : xDataList
			}
		],
		yAxis : [
			{
				name : OptionInfo.yAxisName,
				type : 'value',
				min : 0,
				scale: true,
			}
		],
		
		series :function(){
			var serie=[];		
			var str = '';	
			for( var i=0;i < MIPNum;i++){
			var item={
			name:MIPList.IPList[i].IP,
			type:'line',
			itemStyle: {normal: {areaStyle: {type: 'default',color: MIPList.IPList[i].Color},color:MIPList.IPList[i].Color}},
			data:yDataList[i]
			}
			serie.push(item);
			};
			return serie;
		}()
	};
	
	if (MIPNum == 0) 
	{
		DisplayChartNodata(Chart);
		setDisplay('Tab_'+OptionInfo.LegendId, 0);
	}
	else
	{
		Chart.setOption(option);
		DrawQueryLegend(OptionInfo.LegendId, LegendMIPList, IptvMIPList);
	}
}

function DisplayPCRDiagResultInfo(flag1, xDataList, yDataList1, yDataList2, tList, MIPList, LegendMIPList)
{
	var MIPNum = (MIPList.IPList!= undefined) ? MIPList.IPList.length : 0;
	var OptionInfo = getOptionInfo(flag1);
	var Chart = initchart(flag1,OptionInfo.ChartId);
	var option = {
		title : {
			text: OptionInfo.TitleText,
			x: 'center'
		},
		tooltip: {
			trigger: 'axis',
			formatter: function(params) {
			    var CurIP = GetIPAddrByTime(params[0].name, tList);
				var CurBDW = GetBdwByTime(params[0].name, tList);
				var ProgramIdMa = parseInt(GetProgrameIdByTime(params[0].name, CurIP, MIPList),10)*2;
				var ProgramIdMn = parseInt(ProgramIdMa,10) + 1;
				var infostr = '';
				if (-1 < ProgramIdMa)
				{
				   if((VideoDiagInfo.RecordMode == "VerboseRecord") && (CurBDW !="-"))
				   {
				       infostr = iptvdiagnose_language['bbsp_timemh'] + params[0].name + '<br/>'
					       + iptvdiagnose_language['bbsp_pcrmamh'] + params[ProgramIdMa].value + iptvdiagnose_language['bbsp_bpcrmh'] + '<br/>'
						   + iptvdiagnose_language['bbsp_pcrmnmh'] + params[ProgramIdMn].value + iptvdiagnose_language['bbsp_bpcrmh'] + '<br/>'
					       + iptvdiagnose_language['bbsp_ipmh'] + CurIP + '<br/>'
					       + iptvdiagnose_language['bbsp_bdwmh'] + CurBDW + iptvdiagnose_language['bbsp_bdwpmh'];
				   }
				   else
				   {
				       infostr = iptvdiagnose_language['bbsp_timemh'] + params[0].name + '<br/>'
					       + iptvdiagnose_language['bbsp_pcrmamh'] + params[ProgramIdMa].value + iptvdiagnose_language['bbsp_bpcrmh'] + '<br/>'
						   + iptvdiagnose_language['bbsp_pcrmnmh'] + params[ProgramIdMn].value + iptvdiagnose_language['bbsp_bpcrmh'] + '<br/>'
					       + iptvdiagnose_language['bbsp_ipmh'] + CurIP;
				   }
				}
				return infostr;
			}
		},
		legend: {
			x: 'right',
			data:[{name:iptvdiagnose_language['bbsp_pcrmntitle'],textStyle: {fontSize: 8}},{name:iptvdiagnose_language['bbsp_pcrmatitle'],textStyle:{fontSize: 8}}]
		},
		toolbox: {
			show : false,
			feature : {
            mark : {show: false},
            dataView : {show: false, readOnly: true},
            magicType : {show: false, type: ['line', 'bar']},
            restore : {show: false},
            saveAsImage : {show: false}
            }
		},
		dataZoom: {
		    show : true,
			realtime : false,
            height : 20,
			y : 360,
			start : 0,
			end : 100
		},
		xAxis : [
			{
				type : 'category',
				boundaryGap : false,
				data: xDataList
			}
		],
		yAxis : 
			{
				name : OptionInfo.yAxisName,
				type : 'value',
				min : 0,
				scale: true,
				boundaryGap : [0.2,0.2]				
			},		
		series :function(){			    
                var serie1=[];				
			    var str = '';	
			    for( var i=0;i < MIPNum;i++){
			    var item1={
			    name:iptvdiagnose_language['bbsp_pcrmatitle'],
		    	type:'line',
				data:yDataList1[i],
				markLine: {
			        data: [
				        {type: 'average', name:'Maximum Value'}
			        ]
			    },
			    itemStyle: {normal:{color:'#D1EEEE'}}		  
			    };
				var item2={
			    name:iptvdiagnose_language['bbsp_pcrmntitle'],
		    	type:'line',
				data:yDataList2[i],
				markLine: {
			        data: [
				        {type: 'average', name:'Mean Value'}
			        ]
			    },
			    itemStyle: {normal:{color:'#9400D3'}}		  
			    }
			    serie1.push(item1,item2);
			    };
			    return serie1;
	 	    }()
	};

	if (MIPNum == 0) 
	{
		DisplayChartNodata(Chart);
	}
	else
	{
		Chart.setOption(option);
	}
}
function isMulticastIpAddress(address)
{
	if(address == "")
	{
		return true;
	}
	
	if (isValidIpAddress(address) == false)
	{
		return false;
	}

	var addrParts = address.split('.');
	var num = 0;

	num = parseInt(addrParts[0]);
	if (num < 224 || num > 239)
	{
		return false;
	}

	return true;
}

function CheckForm()
{
	if (false == CheckNumber(getValue('IntervalId'), 5, 255))
	{
		AlertEx(iptvdiagnose_language['bbsp_intervalinvalid']);
		return false;
	}
	if (false == CheckNumber(getValue('DelayTimeId'), 30, 300))
	{
		AlertEx(iptvdiagnose_language['bbsp_delaytimeinvalid']);
		return false;
	}
	
	var enable = getCheckVal('EnableEmulate');
	var ipaddr = getValue('IPAddress');
	var vlanid = getValue('VlanId');
	var portid = getSelectVal('PortId');
	
	if (enable == 1)
	{
		if ((ipaddr == '')
			|| ((ipaddr != '') && (false == isMulticastIpAddress(ipaddr))))
		{
			AlertEx(iptvdiagnose_language['bbsp_ipaddrinvalid']);
			return false;
		}		
		if (portid == '')
		{
			AlertEx(iptvdiagnose_language['bbsp_PortIdinvalid']);
			return false;
		}
		if ((vlanid != '') && (false == CheckNumber(vlanid, 1, 4094)))
		{
			AlertEx(iptvdiagnose_language['bbsp_portvlaninvalid']);
			return false;
		}
	}

	return true;
}

function ApplyConfig()
{
	if(CheckForm() != true)
	{
		DisplayVideoDiagInfo();
		return false;
	}
	setDisable('buttonApply', 1);
    setDisable('cancelValue', 1);
	
	var SpecConfigParaList = new Array();
	SpecConfigParaList.push(new stSpecParaArray("x.Enable",getCheckVal('EnableId'), 1));
	SpecConfigParaList.push(new stSpecParaArray("x.Interval",getValue('IntervalId'), 1));
	SpecConfigParaList.push(new stSpecParaArray("x.DelayTime",getValue('DelayTimeId'), 1));
	SpecConfigParaList.push(new stSpecParaArray("x.RecordMode",getSelectVal('RecordModeId'), 1));
	var enableemulate = getCheckVal('EnableEmulate');
	var ipaddr = (enableemulate == 1) ? getValue('IPAddress') : '';
	SpecConfigParaList.push(new stSpecParaArray("x.IpAddr",ipaddr, 1));
	if ((enableemulate == 0) || ((enableemulate == 1) && (getSelectVal('PortId') != '')))
	{
		SpecConfigParaList.push(new stSpecParaArray("x.Interface",getSelectVal('PortId'), 1));
	}
	var vlanid = getValue('VlanId');
	if ((getValue('VlanId') == '') || (enableemulate == 0))
	{
		vlanid = 0;
	}
	SpecConfigParaList.push(new stSpecParaArray("x.VlanId",vlanid, 1));
	
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = DiagConfigFormList;
	Parameter.SpecParaPair = SpecConfigParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=InternetGatewayDevice.X_HW_VideoDiagnostics' + '&RequestFile=html/bbsp/iptvdiagnose/iptvdiagnose.asp';
				  
	HWSetAction(null, url, Parameter, tokenvalue);
}

function CancelConfig()
{
	DisplayVideoDiagInfo();
}

function GetIPAddrByTime(time, DiagResultList)
{
	var curIPAddr = "";
	var Len = DiagResultList.length;
	for(var i = 0; i < Len; i++)
	{
		if($.trim(time) == DiagResultList[i].Time)
		{
			curIPAddr = DiagResultList[i].MulticastIP;
			break;
		}
	}
	return (curIPAddr == "0.0.0.0") ? "-" : curIPAddr;
}

function GetBdwByTime(time, DiagResultList)
{
	var curBdw = "";
	var Len = DiagResultList.length;
	for(var i = 0; i < Len; i++)
	{
		if($.trim(time) == DiagResultList[i].Time)
		{
			curBdw = DiagResultList[i].BDW;
			break;
		}
	}
	return (curBdw == "") ? "-" : curBdw;
}

function GetProgrameIdByTime(CurTime,CurIP,MIPList)
{
	var PId = -1;
	var MIPNum = (MIPList.IPList!= undefined) ? MIPList.IPList.length : 0;
	if ((MIPNum == 0) || (CurIP == '-'))
	{
		return PId;
	}
	
	if (MIPList.CutTime != '')
	{
		if (GetDateObjectTime(CurTime) <= GetDateObjectTime(MIPList.CutTime))
		{
			PId = MIPNum - 1;
		}
		else
		{
			for(var i = 0; i < MIPNum; i++)
			{
				if (CurIP == MIPList.IPList[i].IP)
				{
					PId = i;
					break;
				}
			}
		}
	}
	else
	{
		for(var i = 0; i < MIPNum; i++)
		{
			if (CurIP == MIPList.IPList[i].IP)
			{
				PId = i;
				break;
			}
		}
	}
	
	return PId;
}

function GetDateObjectTime(timestr)
{
	var timems = 0;
	var timelist = timestr.replace(/\:/g,"-").split('-');
	if(timelist.length >= 6)
	{
		var year = timelist[0];
		var month = timelist[1] - 1;
		var day = timelist[2];
		var hour = timelist[3];
		var minute = timelist[4];
		var second = timelist[5];
		
		var date = new Date(year, month, day, hour, minute, second);
		timems = parseInt(date.getTime()/1000);
	}
	
	return timems;
}

function QueryDataByPage(DataList)
{
	var specialResultList = DataList.DiagResultList;
	var specialMIPList = new Array();
	var LegendSpecialMIPList = new Array();
	var specialMIPNum = 0;
	var specialAllDiagList =  new Array();
	
	if (specialResultList.length != 0)
	{
		specialMIPList = GetQueryMulticastIPList(specialResultList, IptvMIPList, 0);
		specialMIPNum = specialMIPList.IPList.length;
		LegendSpecialMIPList = GetQueryMulticastIPList(specialResultList, IptvMIPList, 1);
		SetAllIPtvDiagList(specialResultList,specialMIPList,specialAllDiagList);
	}
	
	var xSpecialList = DataList.DiagTimeList;
	var AllvmosSpecialList = new Array();
	var AllDFSpecialList = new Array();
	var AllMLRSpecialList = new Array();
	var AllPCRMXSpecialList = new Array();
	var AllPCRMNSpecialList = new Array();
	
	GetVmosDfMlrDataList(specialMIPNum, specialAllDiagList, AllvmosSpecialList, AllDFSpecialList, AllMLRSpecialList, AllPCRMXSpecialList, AllPCRMNSpecialList);
	DisplayDiagResultInfo('MLR', xSpecialList, AllMLRSpecialList, specialResultList, specialMIPList, LegendSpecialMIPList);
	DisplayPCRDiagResultInfo('PCRJITMax', xSpecialList, AllPCRMXSpecialList, AllPCRMNSpecialList, specialResultList, specialMIPList, LegendSpecialMIPList);
	
	return;
}

function DownloadDiagResultFile()
{
	var Form = new webSubmitForm();
	Form.addParameter('logtype', "opt");
	Form.setAction('videodiagdown.cgi?FileType=videodiag&RequestFile=html/bbsp/iptvdiagnose/iptvdiagnose.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function StopRefreshPage()
{
	StopPageRefresh = true;
	setDisable('button_stoprefresh_id',1);
	setDisable('button_statrefresh_id',0);
}

function StartRefreshPage()
{
	StopPageRefresh = false;
	setDisable('button_stoprefresh_id',0);
	setDisable('button_statrefresh_id',1);
}

function LanName2LanDomain(LanName)
{
    if(LanName.length == 0)
    {
        return '';
    }
    var EthNum = LanName.charAt(LanName.length - 1);
    return  "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + EthNum;
}

function InitPortIdListControl(ObjId)
{
	var PortIdList = getElementById(ObjId);
	var EthNum = TopoInfo.EthNum;
    var i;
    var LanName = "";
    
	for(i=1; i<=EthNum;i++)
	{
		if(iponlyflg >0 && i==5)
		{
			LanName = "EXT1";
		}
		else
		{
			LanName = 'LAN' + i;
		}	
	    PortIdList.options.add(new Option(LanName, LanName2LanDomain('LAN' + i)));
	}
}

function IsFindCurMIP(QueryMIPList, MIPList)
{	
	if (MIPList.IPList.length >= 2)
	{
		if ((g_tIPList[0].IP == QueryMIPList.IPList[0].IP)
		&& (GetDateObjectTime(QueryMIPList.IPList[0].Time) > GetDateObjectTime(g_tIPList[1].Time)))
		{
			return true;
		}
		
	}
	else
	{
		if (g_tIPList[0].IP == QueryMIPList.IPList[0].IP)
		{
			return true;
		}
	}
	return false;
}

function DrawCurMIPRow(MIPList)
{
	var html = '';
	html += '<tr><td>';
	html += '<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="TableMarginLeft">';
	html += '<tr>';
	html += '<td width="13%" nowrap>'+ iptvdiagnose_language['bbsp_curpip'] + '</td>';
	if (IsIpInvaild(MIPList.IPList[0].IP) == true)
	{
		html += '<td width="5%" id="ip_0" nowrap>'+iptvdiagnose_language['bbsp_none']+'</td>';
		html += '<td width="82%"></td>';
	}
	else
	{
		html += '<td width="5%" id="ip_0" nowrap>'+MIPList.IPList[0].IP +'</td>';
		color = MIPList.IPList[0].Color;
		html += '<td width="5%"><div id="ipline_0" style="width:20px;height:3px;max-height:3px;background:'+color+'"></div></td>';
		html += '<td width="77%"></td>';
	}
	html += '</tr>';
	html += '</table>';
	html += '</td></tr>';
	return html;
}

function DrawLatestMIPRow(MIPList,startId)
{
	var html = '';
	var ip = '';
	var color = '';
	var blankwidth = 0;
	var usedwidth = 0;
	var MIPNum = (MIPList.IPList!= undefined) ? MIPList.IPList.length : 0;

	
	html += '<tr><td>';
	html += '<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="TableMarginLeft">';
	html += '<tr>';
	html += '<td width="13%" nowrap>'+iptvdiagnose_language['bbsp_recentpip']+'</td>';
	if (MIPNum <= 3)
	{
		usedwidth += 13;
		for (var i=startId;i<MIPNum;i++)
		{
			ip = (IsIpInvaild(MIPList.IPList[i].IP) == true) ? iptvdiagnose_language['bbsp_none'] : MIPList.IPList[i].IP;
			color = (IsIpInvaild(MIPList.IPList[i].IP) == true) ? '' : MIPList.IPList[i].Color;
			html += '<td  width="5%" id="ip_'+ i +'" nowrap>'+ip +'</td>';
			html += '<td width="5%"><div id="ipline_'+ i +'" style="width:20px;height:3px;max-height:3px;margin-right:10px;background:'+color+'"></div></td>';
			usedwidth += 10;
		}
	}
	else
	{		
		for (var i=startId;i<startId+3;i++)
		{
			ip = (IsIpInvaild(MIPList.IPList[i].IP) == true) ? iptvdiagnose_language['bbsp_none'] : MIPList.IPList[i].IP;
			color = (IsIpInvaild(MIPList.IPList[i].IP) == true) ? '' : MIPList.IPList[i].Color;
			html += '<td  width="5%" id="ip_'+ i +'" nowrap>'+ip +'</td>';
			html += '<td width="5%"><div id="ipline_'+ i +'" style="width:20px;height:3px;max-height:3px;margin-right:10px;background:'+color+'"></div></td>';
			usedwidth += 10;
		}
		blankwidth = 100 - usedwidth;
		html += '<td width="'+blankwidth+'%"></td>';
		html += '</tr>';
		html += '</table>';
		html += '</td></tr>';
		html += '<tr><td>';
		html += '<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="TableMarginLeft">';
		html += '<tr>';
		usedwidth = 0;
		for (var i=startId+3;i<MIPNum;i++)
		{
			html += '<td  width="5%" id="ip_'+ i +'" nowrap>'+MIPList.IPList[i].IP +'</td>';
			color = MIPList.IPList[i].Color;
			html += '<td width="5%"><div id="ipline_'+ i +'" style="width:20px;height:3px;max-height:3px;margin-right:10px;background:'+color+'"></div></td>';
			usedwidth += 10;
		}
	}
	
	blankwidth = 100 - usedwidth;
	html += '<td width="'+blankwidth+'%"></td>';
	html += '</tr>';
	html += '</table>';
	html += '</td></tr>';
	return html;
}

function DrawQueryLegend(DivId, QueryMIPList, MIPList)
{
	if(document.getElementById('Tab_'+DivId)!=null)
	{
		$('#Tab_'+DivId).remove();
	}
	var html = '';
	var QueryMIPNum = (QueryMIPList.IPList!= undefined) ? QueryMIPList.IPList.length : 0;
	if (QueryMIPNum == 0)
	{
		$("#"+DivId).after(html);
		return;
	}
	
	html += '<table id="Tab_'+DivId+'">';
	if (IsFindCurMIP(QueryMIPList, MIPList) == true)
	{
		html += DrawCurMIPRow(QueryMIPList);
		if (QueryMIPNum == 1)
		{
			$("#"+DivId).after(html);
			return;
		}
		html += DrawLatestMIPRow(QueryMIPList,1);
	}
	else
	{
		html += DrawLatestMIPRow(QueryMIPList,0);
	}
	
	html += '</table>';
	$("#"+DivId).after(html);
}


function DrawLegend(DivId, MIPList)
{
	if(document.getElementById('Tab_'+DivId)!=null)
	{
		$('#Tab_'+DivId).remove();
	}
	var html = '';
	var color = '';
	var blankwidth = 0;
	var usedwidth = 0;
	var MIPNum = (MIPList.IPList!= undefined) ? MIPList.IPList.length : 0;
	if (MIPNum == 0)
	{
		$("#"+DivId).after(html);
		return;
	}
	
	html += '<table id="Tab_'+DivId+'">';	
	html += DrawCurMIPRow(MIPList);
	if (MIPNum == 1)
	{
		$("#"+DivId).after(html);
		return;
	}
	
	html += DrawLatestMIPRow(MIPList,1);
	html += '</table>';
	$("#"+DivId).after(html);
}

function OnClickEmulate()
{
	var enable = getCheckVal('EnableEmulate');
	controlEmulate(enable);
}

function OnPortIdChange()
{
	removeOption('PortId',specialOption);
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();">
<script language="JavaScript" src="./<%HW_WEB_CleanCache_Resource(echarts-all.js);%>"></script>
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("iptvdiagtitle", GetDescFormArrayById(iptvdiagnose_language, "bbsp_mune"), GetDescFormArrayById(iptvdiagnose_language, "bbsp_diag_title"), false);
</script>
<div class="title_spread"></div>
<form id="ConfigForm">
<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
<li   id="EnableId"            RealType="CheckBox"           DescRef="bbsp_Enablemh"            RemarkRef="Empty"                    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"        InitValue="Empty" />
<li   id="IntervalId"          RealType="TextBox"            DescRef="bbsp_Intervalmh"          RemarkRef="bbsp_Intervalremark"      ErrorMsgRef="FALSE"    Require="TRUE"     BindField="Empty"      InitValue="5"  />
<li   id="DelayTimeId"         RealType="TextBox"            DescRef="bbsp_DelayTimemh"         RemarkRef="bbsp_DelayTimeremark"     ErrorMsgRef="FALSE"    Require="TRUE"     BindField="Empty"     InitValue="60" />
<li   id="RecordModeId"        RealType="DropDownList"       DescRef="bbsp_RecordModemh"        RemarkRef="Empty"                    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    Elementclass="width_135px"     InitValue="[{TextRef:'bbsp_BriefRecord',Value:'BriefRecord'},{TextRef:'bbsp_VerboseRecord',Value:'VerboseRecord'}]" />
<li   id="EnableEmulate"       RealType="CheckBox"           DescRef="bbsp_enableEmulate"       RemarkRef="Empty"                    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"        InitValue="Empty"   ClickFuncApp="onclick=OnClickEmulate"/>
<li   id="IPAddress"           RealType="TextBox"            DescRef="bbsp_IpAddrmh"          RemarkRef="Empty"      ErrorMsgRef="FALSE"    Require="TRUE"     BindField="Empty"      InitValue="Empty"  />
<li   id="PortId"              RealType="DropDownList"       DescRef="bbsp_PortId"              RemarkRef="Empty"                    ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"     Elementclass="width_135px"  InitValue="Empty" ClickFuncApp="onMousedown=OnPortIdChange"/>
<li   id="VlanId"              RealType="TextBox"            DescRef="bbsp_Vlan"                RemarkRef="bbap_WanVlanIdRemark"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"        InitValue="Empty"/>
</table>
<script>
var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
var DiagConfigFormList = new Array();
DiagConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
HWParsePageControlByID("ConfigForm", TableClass, iptvdiagnose_language, null);
InitPortIdListControl("PortId");
</script>
<table cellpadding="0" cellspacing="1" width="100%" class="table_button">
<tr>
	<td class="width_per25"></td>
	<td class="table_submit">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<button id="buttonApply" name="buttonApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="ApplyConfig();"><script>document.write(iptvdiagnose_language['bbsp_app']);</script></button>
		<button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px"  type="button" onClick="CancelConfig();"><script>document.write(iptvdiagnose_language['bbsp_cancel']);</script></button>
	</td> 
</tr>        
</table>
</form>	
<div style="height:20px;"></div>

<div id="ConfigForm2"> 
  <div class="list_table_spread"></div>
    <table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
		<tr> 
			<td class='align_left'><input type="button" id="button_statrefresh_id" class="ApplyButtoncss buttonwidth_100px" onClick="StartRefreshPage();" BindText="bbsp_startrefresh"></td>
			<td class='align_left'><input type="button" id="button_stoprefresh_id" class="ApplyButtoncss buttonwidth_100px" onClick="StopRefreshPage();" BindText="bbsp_stoprefresh"></td>
			<td class='title_bright1' >
				<input name="first" id="first" class="PageNext jumppagejumplastbutton_wh_px" type="button" value="<<" onClick="submitfirst();"/> 
				<input name="prv" id="prv"  class="PageNext jumppagejumpbutton_wh_px" type="button" value="<" onClick="submitprv();"/> 
					<label id="pagenum"></label> 
				<input name="next"  id="next" class="PageNext jumppagejumpbutton_wh_px" type="button" value=">" onClick="submitnext();"/> 
				<input name="last"  id="last" class="PageNext jumppagejumplastbutton_wh_px" type="button" value=">>" onClick="submitlast();"/> 
			</td>
			<td class='width_per5'></td>
			<td  class='title_bright1'>
				<script> document.write(sroute_language['bbsp_goto']); </script> 
					<input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
				<script> document.write(sroute_language['bbsp_page']); </script>
			</td>
			<td class='title_bright1'>
				<button name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="submitjump();"> <script> document.write(sroute_language['bbsp_jump']); </script></button> 
			</td>
			 <td class='title_bright1'><input type="button" id="button_download_id" class="ApplyButtoncss buttonwidth_100px" onClick="DownloadDiagResultFile();" BindText="bbsp_download"></td>

		</tr> 	  
    </table> 
</div>  

<div id="DivChart" style="background-color: #f8f8f8;">

<div id="main_mlr" style="height:400px; "></div>
<div id='main_mlr_legend' style="margin-top:-20px;"></div>

<table width="100%" height="20" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
</table>

<div id="main_pcr" style="height:400px; "></div>
<div id='main_pcr_legend' style="margin-top:-30px;"></div>

<table width="100%" height="20" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
</table>
</div>
	
<script>
	ParseBindTextByTagName(iptvdiagnose_language, "span",  1);
	ParseBindTextByTagName(iptvdiagnose_language, "td",    1);
	ParseBindTextByTagName(iptvdiagnose_language, "input", 2);
</script>
</body>
</html>