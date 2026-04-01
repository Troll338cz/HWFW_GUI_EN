<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<script language="JavaScript" type="text/javascript">
	var CfgMode ='<%HW_WEB_GetCfgMode();%>';
	var TelNum;
	document.write('<title>中国移动</title>');
	TelNum='10086号';
 </script>	
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<style>
.input_time {border:0px; }
</style>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="/../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript">
var br0Ip = '<%HW_WEB_GetBr0IPString();%>';
var httpport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';

function stResultInfo(domain, Result, Status, Limits, Times, RegTimerState, InformStatus, ProvisioningCode, ServiceNum)
{
	this.domain = domain;
	this.Result = Result;
	this.Status = Status;
	this.Limits = Limits;
 	this.Times = Times;
 	this.RegTimerState = RegTimerState;
    this.InformStatus	= InformStatus;
 	this.ProvisioningCode = ProvisioningCode;
    this.ServiceNum = ServiceNum;
}  

function WANIP(domain,ConnectionStatus,ExternalIPAddress, X_HW_SERVICELIST,ConnectionType,X_HW_TR069FLAG)
{
  this.domain 	= domain;
  this.ConnectionStatus 	= ConnectionStatus;	
		
  if(ConnectionType == 'IP_Bridged')
  {
  	this.ExternalIPAddress	= '';
  }
  else
  {
    this.ExternalIPAddress	= ExternalIPAddress;
  }
  
  this.X_HW_SERVICELIST = X_HW_SERVICELIST;
  this.X_HW_TR069FLAG = X_HW_TR069FLAG;
	
}

function WANPPP(domain,ConnectionStatus,ExternalIPAddress, X_HW_SERVICELIST,ConnectionType,X_HW_TR069FLAG)
{
  this.domain	= domain;
  this.ConnectionStatus	= ConnectionStatus;	
	
  if (ConnectionType == 'PPPoE_Bridged')
  {  
  	this.ExternalIPAddress	= '';	  
  }
  else
  {
    this.ExternalIPAddress= ExternalIPAddress;
  }	 
  this.X_HW_SERVICELIST = X_HW_SERVICELIST;
  this.X_HW_TR069FLAG = X_HW_TR069FLAG;
}
 
function PingResultClass(domain, FailureCount, SuccessCount)
{
    this.domain = domain;
    this.FailureCount = FailureCount;
    this.SuccessCount = SuccessCount;
} 

var opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>';      
var stResultInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, Result|Status|Limit|Times|X_HW_TimeoutState|X_HW_InformStatus|ProvisioningCode, stResultInfo);%>;
var Infos = stResultInfos[0];
if (Infos.Status != 0 && Infos.Status != 5)
{
	Infos.Status = 99;
	Infos.Result = 99;
}
var InfosBak = Infos;

var WanIp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i},ConnectionStatus||ExternalIPAddress|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANIP);%>;
var WanPpp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},ConnectionStatus|ExternalIPAddress|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANPPP);%>;
var Wan = new Array();

var stOnlineStatusInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>';
var IsOntOnline = stOnlineStatusInfo;
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';

var loadedcolor='orange' ;   
var unloadedcolor='white';     
var bordercolor='orange';     
var barheight=15;             
var barwidth=300;              
var ns4=(document.layers)?true:false;
var ie4=(document.all)?true:false;
var PBouter;
var PBdone;
var PBbckgnd;
var ResultTemp="";
var txt='';
var acsUrl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.ManagementServer.URL);%>';
var GetLoidAuthStatus = '<%HW_WEB_GetLoidAuthStatus();%>';
var opticMode = '<%HW_WEB_GetOpticMode();%>'
var opticType = '<%HW_WEB_GetOpticType();%>';

var timer;
var CheckDetailInfo = 1;
var StartCheckStatus = 0;
var RefreshCount = 0;
var RefreshStop = 0;
var isExistUserChoice = 1;
var CheckCnt = 0;
var CurBinMode = '<%HW_WEB_GetBinMode();%>';
var RefreshNum = 0;
var CheckOnlineCnt = 0;

if ('CMCC' != CurBinMode.toUpperCase())	
{
	window.location="/login.asp";
}

txt += getLayerStr(ns4, barheight, barwidth, bordercolor, barheight, unloadedcolor, loadedcolor);

if ((parseInt(Infos.Result) == 1) && (parseInt(Infos.Status) == 0))
{
	window.location="/loidgregsuccess.asp";
}

function CheckWanInfo()
{
	for (i=0, j=0; WanIp.length > 1 && j < WanIp.length - 1; i++,j++)
	{
	  	if("1" == WanIp[j].X_HW_TR069FLAG)
	  	{
	    	i--;
	    	continue;
	  	}
	  	Wan[i]= WanIp[j];
	  	
		if (Wan[i].ConnectionStatus=="Connected")
	  	{
	  		CheckDetailInfo = 0;
	  	}	  
	}
	
	for (j=0; WanPpp.length > 1 && j<WanPpp.length - 1; i++,j++)
	{
	  	if("1" == WanPpp[j].X_HW_TR069FLAG)
	  	{
	    	i--;
	    	continue;
	  	}
	  	Wan[i]= WanPpp[j];

		if (Wan[i].ConnectionStatus=="Connected")
	  	{
	  		CheckDetailInfo = 0;
	  	}	  
	}
}

function resizeEl(id,t,r,b,l)
{
	if(ns4)
	{
		id.clip.left=l;
		id.clip.top=t;
		id.clip.right=r;
		id.clip.bottom=b;
	}
	else
	{
		id.style.width=r+'px';
	}
}

function FreshCountDel()  
{
	if (RefreshCount)
	{
		RefreshCount--;
	}
	
	RefreshStop = 0;
	RefreshNum = 0;	
}	

function CheckUserChoiceStatus()
{
	var tmpFlag = 0;
	$.ajax({
			type : "POST",
			async : false,
			cache : false,
			timeout : 4000,
			url : "asp/GetUserChoiceStatus.asp",
			success : function(data) {
				tmpFlag = data;
			}  
	});
	
	return tmpFlag;
}

function myrefresh()   
{
	if (1 == isExistUserChoice && CheckCnt < 40)
	{	
		CheckCnt++;
		if (1 == CheckUserChoiceStatus())
		{
			LoadFrameInfo(2000);
			return;
		}
		else
		{
			isExistUserChoice = 0;
		}
	}
		
	RefreshStop++;
	if (RefreshStop > 120)
	{
		return;
	}	

	if (RefreshCount)
	{
		RefreshNum++;
		if (RefreshNum > 4)
		{
			RefreshCount=0;
			RefreshNum=0;
			LoadFrameInfo(2000);
			return;			
		}	
		
		if (((RefreshNum - 1) % 2 ) == 0)
		{
			LoadFrameInfo(1000);
		}
		else
		{	
			setRefreshInterval(1000);
		}	
		return;
	}	
	
	RefreshCount++;
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		timeout : 4000,
		url : "/asp/GetOpticRxPower.asp",
		success : function(data) {
			opticInfo = data;
			FreshCountDel();
		}
	});	
	
	RefreshCount++;	
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		timeout : 4000,
		url : "asp/GetONTonlineStat.asp",
		success : function(data) {
			IsOntOnline = data;
			FreshCountDel();
		}
	});	
	
	if (1 == IsOntOnline)
	{
		if (1 == CheckDetailInfo)
		{	
			RefreshCount++;
			$.ajax({
				type : "POST",
				async : true,
				cache : false,
				timeout : 4000,
				url : "asp/GetRegWanIp.asp",
				success : function(data) {
					WanIp = dealDataWithFun(data);
					FreshCountDel();
				}
			});	
		
			RefreshCount++;
			$.ajax({
				type : "POST",
				async : true,
				cache : false,
				timeout : 4000,
				url : "asp/GetRegWanPpp.asp",
				success : function(data) {
					WanPpp = dealDataWithFun(data);
					FreshCountDel();
				}
			});
			
			CheckWanInfo();			
		}
		
		if ((1 < StartCheckStatus) && (0 == CheckDetailInfo))
		{		
			RefreshCount++;
			$.ajax({
				type : "POST",
				async : true,
				cache : false,
				timeout : 4000,
				url : "asp/GetRegResult.asp",
				success : function(data) {
					Infos = dealDataWithFun(data);
					if (parseInt(Infos.Status) != parseInt(InfosBak.Status))
					{
						Infos.Result = 	InfosBak.Result;
					}
					
					InfosBak = Infos;
					FreshCountDel();
				}
			});	
		}
	}
	else
	{
		CheckDetailInfo = 1;	
	}		
	
	if (CheckDetailInfo)
	{	
		RefreshCount++;
		$.ajax({
			type : "POST",
			async : true,
			cache : false,
			timeout : 4000,
			url : "asp/GetRegLoidAuthStatus.asp",
			success : function(data) {
				GetLoidAuthStatus = data;
				FreshCountDel();
			}
		});		
	}
	
	LoadFrameInfo(2000);
}  

function setPrograss(status, width)
{
	PBouter=(ns4)?findlayer('PBouter',document):(ie4)?document.all['PBouter']:document.getElementById('PBouter');
  	PBdone=(ns4)?PBouter.document.layers['PBdone']:(ie4)?document.all['PBdone']:document.getElementById('PBdone');
	if(ns4)
	{
		if (1 == status)
		{
			PBouter.visibility="show";
		}
		else
		{
			PBouter.visibility="hide";
		}
	}
	else
	{
		if (1 == status)
		{
			PBouter.style.visibility="visible";
		}
		else
		{
			PBouter.style.visibility="hidden";
		}
	}
	
	resizeEl(PBdone, 0, width, barheight-2, 0);
}


function GetDateTimeDiff()
{
	lStartTime = getCookie('lStartTime');	
    if (lStartTime == null || lStartTime == "")
    {
        setCookie("lStartTime", new Date());
        return '1';
    }	
	var CurrentTime = new Date();
	var PrevTime = new Date(getCookie("lStartTime"));
 	return parseInt((CurrentTime.getTime()-PrevTime.getTime())/1000);
}

function GetStepStatus()
{
	StepStatus = getCookie('StepStatus');
    if (StepStatus == null || StepStatus == "" || (StepStatus < '0' || StepStatus > '7'))
    {
        setCookie("StepStatus", "0");
        return '0';
    }
    return StepStatus;
}

/**********************************
GPON接收光功率范围：
CLASS B+: (-27,-8)
CLASS C+: (-30,-8)
EPON接收光功率范围：
PX20:  (-24,-3)
PX20+: (-27,-3)
其它:  参考PX20+的值。
***********************************/
function IsOpticPowerLow()
{
	
	if (ontPonMode.toUpperCase() == 'GPON')
	{ 
		if (opticType == 1) /* GPON */
		{ 
			return opticInfo < -27;/* CLASS B+: (-27,-8) */
		}
		else if(opticType == 2)
		{ 
			return opticInfo < -30;/* CLASS C+: (-30,-8) */
		}
	}
	else if (ontPonMode.toUpperCase() == 'EPON') /* EPON */	
	{ 
		if(opticType == 0)
		{ 
			return opticInfo < -24;/*PX20:  (-24,-3)*/
		}
		else if(opticType == 1)
		{
			return opticInfo < -27;/*PX20+: (-27,-3)*/
		}
	}
    return opticInfo < -27;
}

function GetAcsUrlAddress()
{
	var aclUrlTmp1 = acsUrl.split('//');
	if(aclUrlTmp1.length > 1)
	{
		var aclUrlTmp2 = aclUrlTmp1[1].split(':');
		return(aclUrlTmp2[0]);
	}
	return aclUrlTmp1[0];
}



function StartRegStatus()
{
	setPrograss(1,90);
	document.getElementById('percent').innerHTML="30%"+"（历时"+GetDateTimeDiff()+"秒）";
	if(IsOpticPowerLow())
	{
	document.getElementById("regResult").innerHTML = "终端正在向OLT发起注册"+"（光功率过低）。";
	}
	else
	{
	document.getElementById("regResult").innerHTML = "终端正在向OLT发起注册。";
	}
}


function setPrograss(status, width)
{
	PBouter=(ns4)?findlayer('PBouter',document):(ie4)?document.all['PBouter']:document.getElementById('PBouter');
  	PBdone=(ns4)?PBouter.document.layers['PBdone']:(ie4)?document.all['PBdone']:document.getElementById('PBdone');
	if(ns4)
	{
		if (1 == status)
		{
			PBouter.visibility="show";
		}
		else
		{
			PBouter.visibility="hide";
		}
	}
	else
	{
		if (1 == status)
		{
			PBouter.style.visibility="visible";
		}
		else
		{
			PBouter.style.visibility="hidden";
		}
	}
	
	resizeEl(PBdone, 0, width, barheight-2, 0);
}

function setRefreshInterval(time)
{

	timer = setTimeout('myrefresh()', time); 
	
	return;
}


function IsOpticalNomal()
{
	return opticInfo != "--";
}


function mystep()   
{
	if (1 != IsOntOnline)
	{
		CheckOnlineCnt = 0;
	    setCookie("StepStatus","3");
		return;
	}	
	
	if(CheckOnlineCnt < 6)
	{
		CheckOnlineCnt++;
		return;
	}
	
	CheckOnlineCnt = 0;
	StartCheckStatus++;

	setPrograss(1,90);
	document.getElementById('percent').innerHTML="30%"+" （历时"+GetDateTimeDiff()+"秒）" ;
	document.getElementById("regResult").innerHTML = "终端在OLT已注册成功，下一步是终端向CMS平台发起注册。";

    setCookie("StepStatus","2");	
}


function setTipsBeforeITMSResult()
{
	if ((!IsOpticalNomal()) || (1 == GetLoidAuthStatus && GetDateTimeDiff() > 40))
    {
        LoidRegResultLog("OLT_Fail");
        setPrograss(0,0);
        document.getElementById('percent').innerHTML="";
	    document.getElementById("regResult").innerHTML = "终端在OLT上注册失败，请检查光纤是否插接正常、或收光功率是否正常、或LOID是否输入正确"+" （历时"+GetDateTimeDiff()+"秒）。" ;
		setCookie("StepStatus","4"); 
	}
    else if(GetStepStatus() == '0')
    {
	    LoidRegResultLog("OLT_Fail");
	    if (GetDateTimeDiff() > 300)
		{
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			document.getElementById("regResult").innerHTML = "终端在OLT上注册失败，请检查光纤是否插接正常、或收光功率是否正常、或LOID是否输入正确"+" （历时"+GetDateTimeDiff()+"秒）。" ;						
			clearTimeout(timer);
		}
		else
		{
	        StartRegStatus(); 	
	        mystep();
	    }		  		  
    }
    else if(GetStepStatus() == '2')
	{	
		if (1 != IsOntOnline)
		{		
			setCookie("StepStatus","0");
		}		
		StartCheckStatus++;
		if( GetDateTimeDiff() > 120 )
		{
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			document.getElementById("regResult").innerHTML = "终端到CMS的通道不通，请找支撑经理处理"+" （历时"+GetDateTimeDiff()+"秒）。" ;
			LoidRegResultLog("ITMS_NoIP");
		}
		else
		{
			setPrograss(1,90);
			document.getElementById('percent').innerHTML="30%"+" （历时"+GetDateTimeDiff()+"秒）" ;
			document.getElementById("regResult").innerHTML = "终端在OLT已注册成功，下一步是终端向CMS平台发起注册。";
		}
	}

    else if(GetStepStatus() == '3')
	{	
		if (GetDateTimeDiff() > 300)
		{
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			document.getElementById("regResult").innerHTML = "终端在OLT上注册失败，请检查光纤是否插接正常、或收光功率是否正常、或LOID是否输入正确"+" （历时"+GetDateTimeDiff()+"秒）。" ;	
			clearTimeout(timer);
			LoidRegResultLog("OLT_Fail");
		}
		else
		{
			StartRegStatus();	
			CheckOnlineCnt = 0;	
			setCookie("StepStatus","0");	
		}
	}
	else
	{

		if(GetStepStatus() == '4')
		{
			setCookie("lStartTime",new Date());
		}
		StartRegStatus();
		setCookie("StepStatus","0");
	}		   			  
}

function getRegSuccessTips()
{
    var strProvisioning=Infos.ProvisioningCode.split(',');
	var strNewProvisioning='';
	var strNum;
	LoidRegResultLog("ITMS_CfgSuccess");

    if (""== Infos.ProvisioningCode)
    {
        return "CMS平台数据下发成功，共下发了宽带、语音、iTV三个业务。";
    }
    else
    {
        for (i = 0; i < strProvisioning.length-1; i++)
        {
		    strNewProvisioning = strNewProvisioning+strProvisioning[i]+'、';
		}
        strNewProvisioning = strNewProvisioning+strProvisioning[strProvisioning.length-1];   	
		if (0 == strProvisioning.length)
		{
			strNum = "零";
		}
		else if (1 == strProvisioning.length)
		{
			strNum = "一";
		}
		else if (2 == strProvisioning.length)
		{
			strNum = "二";
		}
		else if (3 == strProvisioning.length)
		{
			strNum = "三";
		}
		else if (4 == strProvisioning.length)
		{
			strNum = "四";
		}
		else
		{
			strNum = "多";
		}		
        return "CMS平台数据下发成功，共下发了" + strNewProvisioning + strNum + "个业务。";
    }
}


function IsRegTimesToLimits()
{
    return parseInt(Infos.Times) >= parseInt(Infos.Limits);
}

function LoadFrame()
{
	CheckWanInfo();
	LoadFrameInfo(2000);
}	

function LoadFrameInfo(time)
{
	/* 启动超时定时器 */
	setRefreshInterval(time);	

    if ((1 != IsOntOnline) || (0 != parseInt(Infos.InformStatus)))
    {
        Infos.Status=99;
    } 
      
	   
	if (Infos != null)
	{
		if (parseInt(Infos.Status) == 0)
		{   
			StartCheckStatus++;
			if (parseInt(Infos.Result) == 99)
			{   
				setPrograss(1,150);
				document.getElementById('percent').innerHTML="50%";
				document.getElementById("regResult").innerHTML = "注册成功。";
			}
            else if (parseInt(Infos.Result) == 0)
            {
				setPrograss(1,180);
				document.getElementById('percent').innerHTML="60%";
				document.getElementById("regResult").innerHTML = "注册成功，正在下发业务，请等待。";		
			}
			else if (parseInt(Infos.Result) == 1)
			{	
				setPrograss(1,298);
				document.getElementById('percent').innerHTML="100%";
				document.getElementById("regResult").innerHTML = "注册成功，下发业务成功。";		
				clearTimeout(timer);
				LoidRegResultLog("ITMS_CfgSuccess");				
			}
			else
			{   
				setPrograss(0,0);		
				document.getElementById('percent').innerHTML="";
				document.getElementById("regResult").innerHTML = "注册成功，下发业务失败，请联系10086号。";
				LoidRegResultLog("ITMS_CfgFail");
			}
		}
		else if(parseInt(Infos.Status) == 1)
		{
			StartCheckStatus++;
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			LoidRegResultLog("ITMS_RegFail");
			if (IsRegTimesToLimits())
			{
				document.getElementById("regResult").innerHTML = "身份证不存在，用户绑定不成功并且超过最大重试次数！请联系10086号。";
			}
			else
			{
				document.getElementById("regResult").innerHTML = "身份证不存在，用户绑定不成功！请重试（剩余尝试次数：" + (parseInt(Infos.Limits)-parseInt(Infos.Times)) + "）。";
			}
		}
		else if(parseInt(Infos.Status) == 2)
		{ 
			StartCheckStatus++;
			setPrograss(0,0);
			LoidRegResultLog("ITMS_RegFail");
			document.getElementById('percent').innerHTML="";
			if (IsRegTimesToLimits())
			{
				document.getElementById("regResult").innerHTML = "宽带账号不存在！注册失败，请联系10086号。";
			}
			else
			{
				document.getElementById("regResult").innerHTML = "宽带账号不存在！请重试（剩余尝试次数：" + (parseInt(Infos.Limits)-parseInt(Infos.Times)) + "）。";
			}
		}
		else if(parseInt(Infos.Status) == 3)
		{
			StartCheckStatus++;
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			LoidRegResultLog("ITMS_RegFail");
			if (IsRegTimesToLimits())
			{
				document.getElementById("regResult").innerHTML = "身份证与宽带账号不匹配！注册失败，请联系10086号。";
			}
			else
			{
				document.getElementById("regResult").innerHTML = "身份证与宽带账号不匹配！请重试（剩余尝试次数：" + (parseInt(Infos.Limits)-parseInt(Infos.Times)) + "）。";
			}
		}
		else if (parseInt(Infos.Status) == 4)
		{
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			LoidRegResultLog("ITMS_Timeout");
			document.getElementById("regResult").innerHTML = "注册超时！请检查线路后重试。";
		}
		else if (parseInt(Infos.Status) == 5)
		{
			setPrograss(0,0);
			document.getElementById('percent').innerHTML="";
			LoidRegResultLog("ITMS_RegRepeat");
			document.getElementById("regResult").innerHTML = "已经注册成功，无需再注册。";
			clearTimeout(timer);
		}
		else
		{
		    setTipsBeforeITMSResult();
			return;
		}
		
	}
	else
	{
		setTipsBeforeITMSResult();
		return;
	}
}

function JumpTo()
{
	clearTimeout(timer);    
	
	if ((parseInt(Infos.Result) == 1) && (parseInt(Infos.Status) == 0))
	{
		window.location="/login.asp";
	}	
	else
	{
		window.location="/loidreg.asp";
	}
}


function LoidRegResultLog(RegResult)
{	
	if (ResultTemp != RegResult)
	{
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "LoidRegResultLog.cgi?&RequestFile=loidgresult.asp",
			data: getDataWithToken('RegResult=' + RegResult),
			success : function(data) {
			}
		});

		ResultTemp = RegResult;
	}
}
</script>
<body onLoad="LoadFrame();"> 
<form> 
<div align="center"> 
<TABLE cellSpacing="0" cellPadding="0" align="center" border="0" style="font-size:16px;"> <TBODY> 
<TR> 
</TR> 
<TR> 
<TD> <TABLE cellSpacing="0" cellPadding="0" align="middle" border="0" style="font-size:16px;"> 
<TBODY> <TR><TD align="center" style="width:653px;height:250px;" background="/images/register_cmccinfo.jpg">
<TABLE cellSpacing="0" cellPadding="0" width="96%" height="15%" border="0" style="font-size:16px;"> 
<TR> 
<TD align="right">
<script language="javascript">
document.write('<A href="http://' + br0Ip +':'+ httpport +'/login.asp"><font style="font-size: 14px;" color="#000000">返回登录页面</FONT></A>');
</script>
</TD> 
</TR> 
</TABLE> 
<br>
<br>
<TABLE cellSpacing="0" cellPadding="0" width="400" border="0" height="80%">    							
<script language="javascript"> 			      		       			
document.write('<TD colSpan="2" height="8"></TD>');
document.write('<TR>');
if (ontPonMode == 'gpon' || ontPonMode == 'GPON')
{
	document.write('<TD align="middle" colSpan="2" height="25" style="font-size: 18px;"><strong style="color:#FF0033">GPON上行终端</strong></TD>');         
}
else
{
	document.write('<TD align="middle" colSpan="2" height="25" style="font-size: 18px;"><strong style="color:#FF0033">EPON上行终端</strong></TD>');                        
}
document.write('</TR>');
document.write('<TD colSpan="2" height="16"></TD>');				
</script>
<TR> 
<TD colspan="2" align="center"> <div id="prograss"><span id="percent" style="font-size:12px;"></span></div></TD> 
</TR> 
<TR> 
<TD colspan="2" align="center">
<script language="JavaScript" type="text/javascript">
	document.write(txt);
</script> </TD> 
</TR> 
<TR> 
<TD align="middle" colSpan="2" height="4"></TD> 
</TR> 
<TR height="8"> 
<TD colspan="2" align="center"><span id="regResult" style="font-size:14px;"></span></TD> 
</TR> 
<TR> <TD colspan="2" valign="top" align="right" width="130" height="25" align="center"/> 
</TR>
<TR>
<TD colspan="2" align="center"　height="30">
	<input type="button" class="submit" style="font-size:13px;" value="返 回" onclick="JumpTo();"/></TD>		         
</TR>
<TR> 
<script language="javascript">
document.write('<TD align="center" colSpan="2" width="100%" height="20"><font style="font-size: 13px;">中国移动客服热线10086号</font></TD> ');
</script>
</TR> 
<TR> 
<TD align="left" colSpan="2" height="60"></TD> 
</TR> 
</TABLE> 

</TR> </TBODY> 
</TABLE></TD> 
</TR> 
</TBODY> 
</TABLE> 
</div> 
</form> 
</body>
</html>
